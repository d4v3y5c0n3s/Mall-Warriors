with allegro5_bitmap_draw_h;
with allegro_primitives_h;
with Interfaces.C;

package body Fighter is

  procedure Queue_Input (F : in out Fighter; input_on_frame : Frame_And_Input) is
    on_frame : Frame_And_Input := input_on_frame;
  begin
    if not F.facing_right then
      if on_frame.input = left then
        on_frame.input := right;
      elsif on_frame.input = right then
        on_frame.input := left;
      end if;
    end if;
    Inputs_List.Append(F.inputs, on_frame);
  end Queue_Input;
  
  procedure Add_Move (F : in out Fighter; M : Move.Move; Index : Natural) is
    root_cursor : Input_Tree.Cursor := Input_Tree.Root(F.tree_of_move_inputs);
    child_cursor : Input_Tree.Cursor := Input_Tree.First_Child(root_cursor);
    temp_node : Input_Tree_Node_Access := new Input_Tree_Node'(ID => up);
    
    procedure EnsureIsInTree (ToAdd : Input_Tree_Node_Access) is
      cursor_out : Input_Tree.Cursor;
    begin
      loop
        if not Input_Tree.Has_Element(child_cursor) then
          -- no match found, MUST create new tree node
          Input_Tree.Insert_Child(F.tree_of_move_inputs, root_cursor, Input_Tree.No_Element, ToAdd, cursor_out);
          exit;
        end if;
        temp_node := Input_Tree.Element(child_cursor);
        if temp_node.ID = ToAdd.ID then
          -- match found, no need to create new tree node
          cursor_out := child_cursor;
          exit;
        end if;
        
        child_cursor := Input_Tree.Next_Sibling(child_cursor);
      end loop;
      
      root_cursor := cursor_out;
      child_cursor := Input_Tree.First_Child(root_cursor);
    end EnsureIsInTree;
  begin
    for I of M.command.all loop
      EnsureIsInTree(I);
    end loop;
    
    EnsureIsInTree(new Input_Tree_Node'(ID => tree_end, key => Index));
    F.moves(Index) := M;
  end Add_Move;

  procedure Press_Input (F : in out Fighter; given_input : input_ids; frame : Natural) is
  begin
    Queue_Input(F, Frame_And_Input'(frame, given_input));
    case given_input is
      when up =>
        if F.on_ground and not Stunned(F) then
          F.on_ground := false;
          F.velocity_vertical := F.jump_speed;
          F.strafing_left := F.holding_left;
          F.strafing_right := F.holding_right;
        end if;
      when left =>
        F.holding_left := true;
      when right =>
        F.holding_right := true;
      when down =>
        if F.on_ground and not Stunned(F) then
          F.crouching := true;
          Execute_Move(F, F.start_crouch_steps, Start_Crouch);
        end if;
      when others =>
        null;
    end case;
  end Press_Input;
  
  procedure Release_Input (F : in out Fighter; given_input : input_ids; frame : Natural) is
  begin
    case given_input is
      when left =>
        F.holding_left := false;
      when right =>
        F.holding_right := false;
      when down =>
        if F.crouching and not Stunned(F) then
          F.crouching := false;
          Execute_Move(F, F.start_uncrouch_steps, Start_Uncrouch);
        end if;
      when others =>
        null;
    end case;
  end Release_Input;
  
  procedure Draw (F : Fighter) is
    pos_with_offset : constant Position := F.pos + F.sprite_offset;
    sprite_facing : Interfaces.C.int := 0;
  begin
    case F.sprite_data.S is
      when none =>
        null;
      when has_bitmap =>
        if not F.facing_right then
          -- change based on whether sprite should face a different direction
          sprite_facing := 1;
        end if;
        allegro5_bitmap_draw_h.al_draw_bitmap_region(
          F.sprite_data.bitmap,
          F.active_animation(F.active_anim_index).x_start, F.active_animation(F.active_anim_index).y_start,
          Float(F.frame_width), Float(F.frame_height),
          Float(pos_with_offset.X), Float(pos_with_offset.Y),
          sprite_facing
        );
    end case;
    
    if F.show_hitboxes then
      Draw_Debug_Hitboxes:
        declare
          upper_hb_pos : constant Position := F.upper_hitbox.pos + F.pos;
          lower_hb_pos : constant Position := F.lower_hitbox.pos + F.pos;
          cb_hb_pos : constant Position := F.chunkbox.pos + F.pos;
          index : Active_Hitboxes.Cursor := Active_Hitboxes.First(F.attack_hitboxes);
          elem : Hitbox;
          attack_hitbox_pos : Position;
        begin
          allegro_primitives_h.al_draw_circle(Float(upper_hb_pos.X), Float(upper_hb_pos.Y), Float(F.upper_hitbox.radius), debug_upper_hitbox_color, 4.0);
          allegro_primitives_h.al_draw_circle(Float(lower_hb_pos.X), Float(lower_hb_pos.Y), Float(F.lower_hitbox.radius), debug_lower_hitbox_color, 4.0);
          allegro_primitives_h.al_draw_circle(Float(cb_hb_pos.X), Float(cb_hb_pos.Y), Float(F.chunkbox.radius), debug_chunkbox_color, 4.0);
          
          while Active_Hitboxes.Has_Element(index) loop
            elem := Active_Hitboxes.Element(index);
            
            attack_hitbox_pos := (if F.facing_right then F.pos + elem.shape.pos else F.pos - elem.shape.pos);
            
            allegro_primitives_h.al_draw_circle(Float(attack_hitbox_pos.X), Float(attack_hitbox_pos.Y), Float(elem.shape.radius), debug_attack_hitbox_color, 4.0);
            
            index := Active_Hitboxes.Next(index);
          end loop;
        end Draw_Debug_Hitboxes;
    end if;
  end Draw;
  
  procedure Update (F : in out Fighter; Current_Frame : Natural) is
  begin
    -- do input buffer here
    if not Inputs_List.Is_Empty(F.inputs) then
      ProcessInputs:
        declare
          input_chain : Inputs_List.List;
          inputs_cursor : Inputs_List.Cursor;
          tree_cursor : Input_Tree.Cursor;
          found_path_tree_cursor : Input_Tree.Cursor;
          temp_node : Input_Tree_Node_Access := new Input_Tree_Node'(ID => up);
          longest_input_chain_key : Natural;
          longest_match : Inputs_List.List;
          found_match_at_level : Boolean := false;
          match_found : Boolean := false;
          elem_at_inputs_cursor : Frame_And_Input;
          buffer_expired : Boolean := Inputs_List.First_Element(F.inputs).frame + Globals.input_buffer_frames < Current_Frame;
          button_delay_expired : Boolean := Inputs_List.First_Element(F.inputs).frame + input_buffer_max_button_delay < Current_Frame;
        begin
          loop
            if Inputs_List.Is_Empty(F.inputs) then
              exit;
            end if;
            
            if buffer_expired or button_delay_expired then
              tree_cursor := Input_Tree.First_Child(Input_Tree.Root(F.tree_of_move_inputs));
              inputs_cursor := Inputs_List.First(F.inputs);
              loop
                if not Input_Tree.Has_Element(tree_cursor) then
                  if found_match_at_level then
                    found_match_at_level := false;
                    tree_cursor := found_path_tree_cursor;
                  else
                    exit;
                  end if;
                end if;
                
                temp_node := Input_Tree.Element(tree_cursor);
                
                if temp_node.ID = tree_end then
                  longest_input_chain_key := temp_node.key;
                  longest_match := Inputs_List.Copy(input_chain);
                  match_found := true;
                  tree_cursor := Input_Tree.Next_Sibling(tree_cursor);
                elsif Inputs_List.Has_Element(inputs_cursor) then
                  elem_at_inputs_cursor := Inputs_List.Element(inputs_cursor);
                  
                  if temp_node.ID = elem_at_inputs_cursor.input then
                    found_match_at_level := true;
                    Inputs_List.Append(input_chain, elem_at_inputs_cursor);
                    found_path_tree_cursor := tree_cursor;
                    Inputs_List.Next(inputs_cursor);
                    tree_cursor := Input_Tree.First_Child(tree_cursor);
                  else
                    tree_cursor := Input_Tree.Next_Sibling(tree_cursor);
                  end if;
                else
                  tree_cursor := Input_Tree.Next_Sibling(tree_cursor);
                end if;
              end loop;
              
              inputs_cursor := Inputs_List.First(F.inputs);
              if match_found then
                if F.doing /= Normal_Move then
                  -- Remove found input sequence & execute the associated move
                  Inputs_List.Delete(F.inputs, inputs_cursor, Inputs_List.Length(longest_match));
                  
                  if not Stunned(F) then
                    Execute_Move(F, F.moves(longest_input_chain_key).steps, Normal_Move);
                  end if;
                elsif buffer_expired then
                  Inputs_List.Delete(F.inputs, inputs_cursor, Inputs_List.Length(longest_match));
                else
                  exit;
                end if;
              else
                 --if loop ends with no pattern, remove top elem of F.inputs
                Inputs_List.Delete(F.inputs, inputs_cursor);
              end if;
            else
              exit;
            end if;
          end loop;
        end ProcessInputs;
    end if;
    
    -- process move here
    if F.move_frame_progression = 0 then
      -- iterate through sub-steps & apply them
      for I in F.active_move_steps(F.move_step_index).operations'Range loop
        Operation_Step:
          declare
            operation : constant Move.Move_Sub_Step_Access := F.active_move_steps(F.move_step_index).operations(I);
          begin
            case operation.O is
              when Move.Play_Animation =>
                F.active_animation := operation.anim;
                F.active_anim_index := 0;
                F.animation_progression := 0;
              when Move.Spawn_Hitbox =>
                Mark_As_Hit_If_Existing_ID_Hit:
                  declare
                    index : Active_Hitboxes.Cursor := Active_Hitboxes.First(F.attack_hitboxes);
                    elem : Hitbox;
                  begin
                    while Active_Hitboxes.Has_Element(index) loop
                      elem := Active_Hitboxes.Element(index);
                      
                      if elem.effect = Grab then
                        F.grabbing := true;
                      end if;
                      
                      if elem.identity = operation.hb.identity and elem.hit then
                        operation.hb.hit := true;
                      end if;
                      
                      index := Active_Hitboxes.Next(index);
                    end loop;
                    Active_Hitboxes.Append(F.attack_hitboxes, operation.hb);
                  end Mark_As_Hit_If_Existing_ID_Hit;
              when Move.Despawn_Hitbox =>
                Find_and_Despawn:
                  declare
                    index : Active_Hitboxes.Cursor := Active_Hitboxes.First(F.attack_hitboxes);
                    elem : Hitbox;
                    found : Boolean := false;
                    another_grabbox_remains : Boolean := false;
                    a_grabbox_was_removed : Boolean := false;
                  begin
                    while Active_Hitboxes.Has_Element(index) loop
                      elem := Active_Hitboxes.Element(index);
                      
                      if elem.identity = operation.despawn_hitbox_id then
                        found := true;
                        Active_Hitboxes.Delete(F.attack_hitboxes, index);
                        if elem.effect = Grab then
                          a_grabbox_was_removed := true;
                        end if;
                      else
                        if elem.effect = Grab then
                          another_grabbox_remains := true;
                        end if;
                      end if;
                      
                      index := Active_Hitboxes.Next(index);
                    end loop;
                    
                    if a_grabbox_was_removed and not another_grabbox_remains then
                      F.grabbing := false;
                    end if;
                    
                    if not found then
                      raise Hitbox_To_Despawn_Not_Found;
                    end if;
                  end Find_and_Despawn;
              when Move.Dash =>
                F.dash_duration := operation.dash_duration;
                F.dash_velocity_vertical := operation.dash_vertical;
                F.dash_velocity_horizontal := operation.dash_horizontal;
              when Move.Play_Sound =>
                Try_To_Play_Sound:
                  declare
                    success : Boolean;
                    sample_id : access allegro_audio_h.ALLEGRO_SAMPLE_ID := new allegro_audio_h.ALLEGRO_SAMPLE_ID;
                  begin
                    success := Boolean(
                      allegro_audio_h.al_play_sample(
                        F.sounds(operation.sound_index).value,
                        1.0, 0.0, 1.0,
                        allegro_audio_h.ALLEGRO_PLAYMODE_ONCE,
                        sample_id
                      )
                    );
                  end Try_To_Play_Sound;
            end case;
          end Operation_Step;
      end loop;
    end if;
      
      F.move_frame_progression := F.move_frame_progression + 1;
      
      if F.move_frame_progression >= F.active_move_steps(F.move_step_index).frame_duration then
        F.move_step_index := F.move_step_index + 1;
        F.move_frame_progression := 0;
      end if;
      
      if F.move_step_index > F.active_move_steps'Last then
        Active_Hitboxes.Clear(F.attack_hitboxes);
        
        F.move_step_index := 0;
        
        F.grabbed := false;
        F.grabbing := false;
        
        if not Stunned(F) then
          if F.crouching then
            Execute_Move(F, F.idle_crouch_steps, Crouched);
          else
            Execute_Move(F, F.idle_stand_steps, Idle);
          end if;
        end if;
    end if;
    
    -- continue processing the current animation here
    if F.animation_progression >= F.active_animation(F.active_anim_index).frame_dration then
      F.animation_progression := 0;
      
      if F.active_anim_index < F.active_animation'Last then
        F.active_anim_index := F.active_anim_index + 1;
      else
        F.active_anim_index := F.active_animation'First;
      end if;
    else
      F.animation_progression := F.animation_progression + 1;
    end if;
    
    -- update position based on velocity
    if (F.knockback_duration > 0) then
      F.velocity_vertical := -F.knockback_velocity_vertical;
      if F.facing_right then
        F.velocity_horizontal := -F.knockback_velocity_horizontal;
      else
        F.velocity_horizontal := F.knockback_velocity_horizontal;
      end if;
    elsif not Stunned(F) or F.grabbed then
      if (F.dash_duration > 0) then
        F.velocity_vertical := -F.dash_velocity_vertical;
        if F.facing_right then
          F.velocity_horizontal := F.dash_velocity_horizontal;
        else
          F.velocity_horizontal := -F.dash_velocity_horizontal;
        end if;
      else
        if F.on_ground then
          if F.holding_left and not F.holding_right then
            F.velocity_horizontal := -F.walk_speed;
          elsif F.holding_right and not F.holding_left then
            F.velocity_horizontal := F.walk_speed;
          else
            F.velocity_horizontal := 0.0;
          end if;
        else
          if F.strafing_left and not F.strafing_right then
            F.velocity_horizontal := -F.air_strafe_speed;
          elsif F.strafing_right and not F.strafing_left then
            F.velocity_horizontal := F.air_strafe_speed;
          else
            F.velocity_horizontal := 0.0;
          end if;
        end if;
      end if;
    end if;
    
    F.pos := Position'(F.pos.X + F.velocity_horizontal, F.pos.Y + F.velocity_vertical);
    
    -- apply gravity
    if not F.on_ground and not (F.dash_duration > 0) and not (F.knockback_duration > 0) then
      F.velocity_vertical := F.velocity_vertical + F.gravity;
    else
      F.velocity_vertical := 0.0;
    end if;
    
    if F.hitstun_duration > 0 then
      F.hitstun_duration := F.hitstun_duration - 1;
    end if;
    
    if F.blockstun_duration > 0 then
      F.blockstun_duration := F.blockstun_duration - 1;
    end if;
    
    if F.knockback_duration > 0 then
      F.knockback_duration := F.knockback_duration - 1;
      
      if F.knockback_duration = 0 then
        F.on_ground := false;
      end if;
    end if;
    
    if F.dash_duration > 0 then
      F.dash_duration := F.dash_duration - 1;
      
      if F.dash_duration = 0 then
        F.on_ground := false;
      end if;
    end if;
  end Update;
  
  procedure Execute_Move (F : in out Fighter; ThisMove : Move.Move_Step_Array_Access; Doing : What_Doing) is
  begin
      F.doing := Doing;
      F.move_frame_progression := 0;
      F.move_step_index := 0;
      F.active_move_steps := ThisMove;
  end Execute_Move;

end Fighter;

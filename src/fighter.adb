with allegro5_bitmap_io_h;
with allegro5_bitmap_draw_h;
with Interfaces.C;
with Ada.Text_IO;

package body Fighter is

  procedure Queue_Input (F : in out Fighter; input_on_frame : Frame_And_Input) is
  begin
    Inputs_List.Append(F.inputs, input_on_frame);
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
        if F.on_ground then
          F.on_ground := false;
          F.velocity_vertical := F.jump_speed;
        end if;
      when left =>
        F.moving_left := true;
      when right =>
        F.moving_right := true;
      when others =>
        null;
    end case;
  end Press_Input;
  
  procedure Release_Input (F : in out Fighter; given_input : input_ids; frame : Natural) is
  begin
    case given_input is
      when left =>
        F.moving_left := false;
      when right =>
        F.moving_right := false;
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
          0.0, 0.0,
          Float(F.frame_width), Float(F.frame_height),
          Float(pos_with_offset.X), Float(pos_with_offset.Y),
          sprite_facing
        );
    end case;
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
        begin
          loop
            if Inputs_List.Is_Empty(F.inputs) then
              exit;
            end if;
            if Inputs_List.First_Element(F.inputs).frame + Globals.input_buffer_frames < Current_Frame then
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
                 --Remove found input sequence & execute the associated move
                Inputs_List.Delete(F.inputs, inputs_cursor, Inputs_List.Length(longest_match));
                
                Execute_Move(F, F.moves(longest_input_chain_key), Current_Frame);
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
    
    -- if doing a move, continue processing it here
    if F.doing_action then
      Ada.Text_IO.Put_Line("Move executed");
    end if;
    
    -- update position based on velocity
    if F.moving_left and not F.moving_right then
      F.velocity_horizontal := -F.walk_speed;
    elsif F.moving_right and not F.moving_left then
      F.velocity_horizontal := F.walk_speed;
    else
      F.velocity_horizontal := 0.0;
    end if;
    
    F.pos := Position'(F.pos.X + F.velocity_horizontal, F.pos.Y + F.velocity_vertical);
    
    -- apply gravity
    if not F.on_ground then
      F.velocity_vertical := F.velocity_vertical + F.gravity;
    else
      F.velocity_vertical := 0.0;
    end if;
  end Update;
  
  procedure Execute_Move (F : in out Fighter; ThisMove : Move.Move; Starting_Frame : Natural) is
  begin
    if not F.hitstunned and not F.doing_action then
      F.doing_action := true;
      F.active_move := new Doing_Move'(CAM => ThisOne, M => ThisMove);
      F.started_move_on := Starting_Frame;
    end if;
  end Execute_Move;

end Fighter;

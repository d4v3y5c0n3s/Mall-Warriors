with allegro5_bitmap_h;
with allegro5_bitmap_io_h;
with allegro5_bitmap_draw_h;

package body Fighter is

  procedure Queue_Input (F : in out Fighter; input_on_frame : Frame_And_Input) is
  begin
    Inputs_List.Append(F.inputs, input_on_frame);
  end Queue_Input;
  
  procedure Add_Move (F : in out Fighter; M : Move.Move) is
  begin
    null;
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
    pos_with_offset : Position := F.pos + F.sprite_offset;
  begin
    case F.sprite_data.S is
      when none =>
        null;
      when has_bitmap =>
        allegro5_bitmap_draw_h.al_draw_bitmap_region(
          F.sprite_data.bitmap,
          0.0, 0.0,
          Float(F.frame_width), Float(F.frame_height),
          Float(pos_with_offset.X), Float(pos_with_offset.Y),
          0
        );
    end case;
  end Draw;
  
  procedure Update (F : in out Fighter) is
  begin
    -- do input buffer here
    loop
      if Inputs_List.Is_Empty(F.inputs) then
        exit;
      else
        -- pop oldest (first elem) onto input chain
        exit;
      end if;
    end loop;
    
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

end Fighter;

with Ada.Calendar; use Ada.Calendar;
with Interfaces.C.Strings; use Interfaces.C.Strings;
with Interfaces.C; use Interfaces.C;
with Interfaces; use Interfaces;
with Interfaces.C.Extensions; use Interfaces.C.Extensions;
with allegro5_events_h; use allegro5_events_h;
with allegro5_system_h; use allegro5_system_h;
with allegro5_base_h; use allegro5_base_h;
with allegro5_keyboard_h; use allegro5_keyboard_h;
with allegro_primitives_h; use allegro_primitives_h;
with allegro_image_h; use allegro_image_h;
with allegro5_display_h; use allegro5_display_h;
with allegro5_color_h; use allegro5_color_h;
with allegro5_drawing_h; use allegro5_drawing_h;
with allegro_font_h; use allegro_font_h;
with allegro5_bitmap_io_h; use allegro5_bitmap_io_h;
with allegro5_transformations_h; use allegro5_transformations_h;
with allegro_audio_h; use allegro_audio_h;
with allegro_acodec_h; use allegro_acodec_h;
with allegro5_bitmap_h; use allegro5_bitmap_h;
with allegro5_bitmap_draw_h; use allegro5_bitmap_draw_h;
with allegro5_joystick_h; use allegro5_joystick_h;
with Globals; use Globals;
with Fighter;
with Cool_Math; use Cool_Math;
with Stage_Data; use Stage_Data;
with Fighter_Data; use Fighter_Data;
with Control_Bindings; use Control_Bindings;

procedure Fighting_Game_Ada is
  
  type Title_State is (Logo_Slide_In, Press_Start_Flashing, Start_Transition_To_Menu);
  
  type Player_Assignment_Slot is (Middle, P1, P2);
  
  type Menu_Entry is record
    operation : access procedure;
    text : access String;
    offset : Position;
    above_move_entry : Natural;
    below_move_entry : Natural;
    left_move_entry : Natural;
    right_move_entry : Natural;
  end record;
  type Menu_Entry_Array is array(Natural range <>) of Menu_Entry;
  type Menu_Move_Dir is (Up, Down, Left, Right);
  
  function Menu_Move (M : Menu_Entry_Array; Index : Natural; Direction : Menu_Move_Dir) return Natural is
    ret_index : Natural := 0;
    m_entry : constant Menu_Entry := M(Index);
  begin
    case Direction is
      when Up =>
        ret_index := m_entry.above_move_entry;
      when Down =>
        ret_index := m_entry.below_move_entry;
      when Left =>
        ret_index := m_entry.left_move_entry;
      when Right =>
        ret_index := m_entry.right_move_entry;
    end case;
    return ret_index;
  end Menu_Move;
  
  procedure Menu_Select_Entry (M : Menu_Entry_Array; Index : Natural) is
  begin
    M(Index).operation.all;
  end Menu_Select_Entry;
  
  function Menu_Entries_Connect_Gridwise (M : Menu_Entry_Array; RowSize : Positive) return Menu_Entry_Array is
    ret : Menu_Entry_Array := M;
  begin
    for I in M'Range loop
      Assign_Direction_Indexes:
        declare
          above : constant Natural := (if (I - RowSize) in M'Range then I - RowSize else I);
          below : constant Natural := (if (I + RowSize) in M'Range then I + RowSize else I);
          left : constant Natural := (if (I - 1) in M'Range then I - 1 else I);
          right : constant Natural := (if (I + 1) in M'Range then I + 1 else I);
        begin
          ret(I).above_move_entry := above;
          ret(I).below_move_entry := below;
          ret(I).left_move_entry := left;
          ret(I).right_move_entry := right;
        end Assign_Direction_Indexes;
    end loop;
    
    return ret;
  end Menu_Entries_Connect_Gridwise;
  
  procedure Main_Menu_Go_To_Verses;
  procedure Main_Menu_Quit_Game;
  
  procedure Choose_Stage;
  
  procedure Choose_Character;
  
  stage_select_row_count : constant Positive := 5;
  char_select_row_count : constant Positive := 5;
  stage_select_background_path : constant String := "assets/stage_select_background.png";
  char_select_background_path : constant String := "assets/character_select_background.png";
  selection_cursor_player_one_path : constant String := "assets/selector_player_one.png";
  selection_cursor_player_two_path : constant String := "assets/selector_player_two.png";
  
  type Icon is record
    bitmap : access ALLEGRO_BITMAP;
  end record;
  type Icon_Array is array(Natural range <>) of Icon;
  
  type Game_State is (Title, Menu, Stage_Select, Character_Select, Battle, Battle_Over);
  type Game_State_Data (GS : Game_State) is record
    should_exit : Boolean := false;
    frame : Natural := 0;
    player_assignment_screen_open : Boolean := false;
    player_assignment_slot_one : Player_Assignment_Slot := Middle;
    player_assignment_slot_two : Player_Assignment_Slot := Middle;
    player_connected_slot_one : Boolean := false;
    player_connected_slot_two : Boolean := false;
    player_input_state_slot_one : Game_Input_State;
    player_input_state_slot_two : Game_Input_State;
    p1_input_state : Game_Input_State := Game_Input_State'(
      last => (others => (others => 0.0)),
      cur => (others => (others => 0.0)),
      translations => default_keyboard_translation,
      optional_joystick_handle => new Opt_Joy_Handle(J => No_Joy)
    );
    p2_input_state : Game_Input_State := Game_Input_State'(
      last => (others => (others => 0.0)),
      cur => (others => (others => 0.0)),
      translations => default_keyboard_translation,
      optional_joystick_handle => new Opt_Joy_Handle(J => No_Joy)
    );
    p1_connected : Boolean := true;
    p2_connected : Boolean := false;
    case GS is
      when Title =>
        ts : Title_State := Logo_Slide_In;
        tbackground : access ALLEGRO_BITMAP;
        tlogo : access ALLEGRO_BITMAP;
        tstartmsg : access ALLEGRO_BITMAP;
        logo_x : Scalar;
        logo_y : Scalar;
        start_flash_showing : Boolean := true;
        update_title_frames : Boolean := true;
        logo_scale : Scalar := 1.0;
      when Menu =>
        mbackground : access ALLEGRO_BITMAP;
        mlogo : access ALLEGRO_BITMAP;
        mlogo_scale : Scalar := 1.0;
        mlogo_pos : Position;
        main_menu : access Menu_Entry_Array := new Menu_Entry_Array'(
          0 => Menu_Entry'(
            operation => Main_Menu_Go_To_Verses'Access,
            text => new String'("Versus Mode"),
            offset => Position'(X => 100.0, Y => 100.0),
            above_move_entry => 0,
            below_move_entry => 1,
            left_move_entry => 0,
            right_move_entry => 0
          ),
          1 => Menu_Entry'(
            operation => Main_Menu_Quit_Game'Access,
            text => new String'("Quit"),
            offset => Position'(X => 100.0, Y => 140.0),
            above_move_entry => 0,
            below_move_entry => 1,
            left_move_entry => 1,
            right_move_entry => 1
          )
        );
        menu_index : Natural := 0;
      when Stage_Select =>
        stage_entries : access Menu_Entry_Array := new Menu_Entry_Array'(Menu_Entries_Connect_Gridwise(
        Menu_Entry_Array'(
          0 => Menu_Entry'(
            operation => Choose_Stage'Access,
            text => new String'(Stage_Name(Test1)),
            offset => Position'(X => 100.0, Y => 100.0),
            above_move_entry => 0,
            below_move_entry => 0,
            left_move_entry => 0,
            right_move_entry => 0
          ),
          1 => Menu_Entry'(
            operation => Choose_Stage'Access,
            text => new String'(Stage_Name(Test2)),
            offset => Position'(X => 180.0, Y => 100.0),
            above_move_entry => 0,
            below_move_entry => 0,
            left_move_entry => 0,
            right_move_entry => 0
          )
        ),
        stage_select_row_count));
        stage_icons : access Icon_Array := new Icon_Array'(
          0 => Icon'(bitmap => Stage_Icon(Test1)),
          1 => Icon'(bitmap => Stage_Icon(Test2))
        );
        p1_stage_index : Natural := 0;
        stage_select_background : access ALLEGRO_BITMAP := al_load_bitmap(New_String(stage_select_background_path));
        stage_selector_player_one : access ALLEGRO_BITMAP := al_load_bitmap(New_String(selection_cursor_player_one_path));
      when Character_Select =>
        char_entries : access Menu_Entry_Array := new Menu_Entry_Array'(Menu_Entries_Connect_Gridwise(
        Menu_Entry_Array'(
          0 => Menu_Entry'(
            operation => Choose_Character'Access,
            text => new String'(Fighter_Name(Shambler)),
            offset => Position'(X => 100.0, Y => 100.0),
            above_move_entry => 0,
            below_move_entry => 0,
            left_move_entry => 0,
            right_move_entry => 0
          ),
          1 => Menu_Entry'(
            operation => Choose_Character'Access,
            text => new String'(Fighter_Name(Test)),
            offset => Position'(X => 180.0, Y => 100.0),
            above_move_entry => 0,
            below_move_entry => 0,
            left_move_entry => 0,
            right_move_entry => 0
          )
        ),
        char_select_row_count));
        char_icons : access Icon_Array := new Icon_Array'(
          0 => Icon'(bitmap => Fighter_Icon(Shambler)),
          1 => Icon'(bitmap => Fighter_Icon(Test))
        );
        p1_char_index : Natural := 0;
        p2_char_index : Natural := 0;
        choosen_stage : Stage_Options;
        char_select_background : access ALLEGRO_BITMAP := al_load_bitmap(New_String(char_select_background_path));
        char_selector_player_one : access ALLEGRO_BITMAP := al_load_bitmap(New_String(selection_cursor_player_one_path));
        char_selector_player_two : access ALLEGRO_BITMAP := al_load_bitmap(New_String(selection_cursor_player_two_path));
      when Battle =>
        player_one : Fighter.Fighter;
        player_two : Fighter.Fighter;
        camera_pos : Position;
        stage : Stage_Assets;
      when Battle_Over =>
        null;
    end case;
  end record;
  type Game_State_Data_Access is access Game_State_Data;
  
  type Wall_Collision is (None, Left_Collision, Right_Collision);
  
  screen_width : constant Scalar := 800.0;
  half_screen_width : constant Scalar := screen_width / 2.0;
  screen_height : constant Scalar := 600.0;
  floor_height : constant Scalar := Scalar(screen_height / 6.0) * 5.0;
  stage_width : constant Scalar := screen_width * 3.0;
  half_stage_width : constant Scalar := stage_width / 2.0;
  title_background_path : constant String := "assets/mall_warriors_sky_background.png";
  title_logo_path : constant String := "assets/mall_warriors_logo.png";
  title_start_message_path : constant String := "assets/mall_warriors_press_start.png";
  title_logo_slide_frames : constant Natural := 120;
  title_start_flash_on_frames : constant Natural := 60;
  title_start_flash_off_frames : constant Natural := 30;
  title_start_msg_x : constant Float := 280.0;
  title_start_msg_y : constant Float := 300.0;
  title_logo_y_move_by : constant Scalar := 2.0;
  title_transition_to_menu_title_slide_frames : constant Natural := 60;
  title_transition_scale_amount : constant Scalar := -0.01;
  title_transition_move_x_amount : constant Scalar := 5.0;
  title_transition_move_y_amount : constant Scalar := 2.0;
  menu_text_zoom : constant Float := 2.0;
  menu_selected_text_x_offset : constant Float := -5.0;
  menu_sound_path : constant String := "assets/menu_move_pop.flac";
  player_assign_background_path : constant String := "assets/player_assign_background.png";
  player_assign_controller_icon_path : constant String := "assets/controller_icon.png";
  player_assign_keyboard_icon_path : constant String := "assets/keyboard_icon.png";
  player_assign_player_one_path : constant String := "assets/assignment_player_one.png";
  player_assign_player_two_path : constant String := "assets/assignment_player_two.png";
  
  frame_start_time : Time := Clock;
  Color_Black : ALLEGRO_COLOR;
  Text_Color : ALLEGRO_COLOR;
  basic_font : access ALLEGRO_FONT;
  transform : access ALLEGRO_TRANSFORM := new ALLEGRO_TRANSFORM;
  state : Game_State_Data_Access;
  Unselected_Text_Color : ALLEGRO_COLOR;
  Selected_Text_Color : ALLEGRO_COLOR;
  menu_move_sound : access ALLEGRO_SAMPLE;
  player_assign_background_bitmap: access ALLEGRO_BITMAP;
  player_assign_controller_icon_bitmap : access ALLEGRO_BITMAP;
  player_assign_keyboard_icon_bitmap : access ALLEGRO_BITMAP;
  player_assign_player_one_icon_bitmap : access ALLEGRO_BITMAP;
  player_assign_player_two_icon_bitmap : access ALLEGRO_BITMAP;
  
  Allegro_Initialization_Failure : exception;
  
  Q : access ALLEGRO_EVENT_QUEUE;
  Display : access ALLEGRO_DISPLAY;
  DisplayEventSrc : access ALLEGRO_EVENT_SOURCE;
  KBEventSrc : access ALLEGRO_EVENT_SOURCE;
  JoyEventSrc : access ALLEGRO_EVENT_SOURCE;
  Ev : access ALLEGRO_EVENT := new ALLEGRO_EVENT;
  
  procedure Game_State_Pass_Player_Inputs (Old_GS : access Game_State_Data; New_GS : access Game_State_Data) is
  begin
    New_GS.p1_connected := Old_GS.p1_connected;
    New_GS.p2_connected := Old_GS.p2_connected;
    New_GS.p1_input_state := Old_GS.p1_input_state;
    New_GS.p2_input_state := Old_GS.p2_input_state;
  end Game_State_Pass_Player_Inputs;
  
  procedure Main_Menu_Go_To_Verses is
  begin
    Go_To_Stage_Select:
      declare
        temp_state : access Game_State_Data := state;
      begin
        state := new Game_State_Data(Stage_Select);
        Game_State_Pass_Player_Inputs(temp_state, state);
      end Go_To_Stage_Select;
  end Main_Menu_Go_To_Verses;
  
  procedure Main_Menu_Quit_Game is
  begin
    state.should_exit := true;
  end Main_Menu_Quit_Game;
  
  procedure Choose_Stage is
  begin
    Go_To_Character_Select:
      declare
        temp_state : access Game_State_Data := state;
      begin
        state := new Game_State_Data(Character_Select);
        state.choosen_stage := Stage_Options'Val(temp_state.p1_stage_index);
        Game_State_Pass_Player_Inputs(temp_state, state);
      end Go_To_Character_Select;
  end Choose_Stage;
  
  procedure Choose_Character is
  begin
    Go_To_Battle:
      declare
        temp_state : access Game_State_Data := state;
      begin
        state := new Game_State_Data(Battle);
        state.player_one := Load_Fighter(Fighter_Options'Val(temp_state.p1_char_index));
        state.player_two := Load_Fighter(Fighter_Options'Val(temp_state.p2_char_index));
        state.stage := Load_Stage(temp_state.choosen_stage);
        state.player_one.pos := Position'(200.0, 400.0);
        state.player_two.pos := Position'(600.0, 400.0);
        Game_State_Pass_Player_Inputs(temp_state, state);
      end Go_To_Battle;
  end Choose_Character;
  
  procedure feet_touches_floor (F : in out Fighter.Fighter) is
  begin
    if F.pos.Y + F.bottom_of_feet.Y >= floor_height then
      F.on_ground := true;
      F.pos.Y := floor_height - F.bottom_of_feet.Y;
      F.strafing_left := false;
      F.strafing_right := false;
    end if;
  end feet_touches_floor;
  
  function body_touches_wall (F : Fighter.Fighter; Camera_X : Scalar) return Wall_Collision is
    translated_chunkbox : constant Circle := F.chunkbox + F.pos;
    chunkbox_left : constant Scalar := translated_chunkbox.pos.X - translated_chunkbox.radius;
    chunkbox_right : constant Scalar := translated_chunkbox.pos.X + translated_chunkbox.radius;
    left_side : constant Scalar := -Camera_X;
    right_side : constant Scalar := -(Camera_X) + screen_width;
  begin
    if chunkbox_left < left_side then
      return Left_Collision;
    elsif chunkbox_right > right_side then
      return Right_Collision;
    else
      return None;
    end if;
  end body_touches_wall;
  
  procedure Collide_Attacks_With (Attacker : in out Fighter.Fighter; Defender : in out Fighter.Fighter) is
      index : Fighter.Active_Hitboxes.Cursor := Fighter.Active_Hitboxes.First(Attacker.attack_hitboxes);
      elem : Hitbox;
      shape : Circle;
      
      procedure Mark_Matching_As_Hit (hit_id : Integer) is
        cursor : Fighter.Active_Hitboxes.Cursor := Fighter.Active_Hitboxes.First(Attacker.attack_hitboxes);
        temp_hitbox : Hitbox;
      begin
        while Fighter.Active_Hitboxes.Has_Element(cursor) loop
          temp_hitbox := Fighter.Active_Hitboxes.Element(cursor);
          
          if temp_hitbox.identity = hit_id then
            temp_hitbox.hit := true;
            Fighter.Active_Hitboxes.Replace_Element(Attacker.attack_hitboxes, cursor, temp_hitbox);
          end if;
          
          cursor := Fighter.Active_Hitboxes.Next(cursor);
        end loop;
      end Mark_Matching_As_Hit;
      
      procedure On_Hit is
      begin
        Defender.hitpoints := Defender.hitpoints - elem.damage;
        Defender.hitstun_duration := elem.hitstun_duration;
        Defender.knockback_velocity_vertical := elem.knockback_vertical;
        Defender.knockback_velocity_horizontal := elem.knockback_horizontal;
        Defender.knockback_duration := elem.knockback_duration;
        Defender.dash_duration := 0;
        Fighter.Execute_Move(Defender, Defender.on_hit_steps, Hit_By_Attack);
      end On_Hit;
      
      procedure On_Block is
      begin
        Defender.blockstun_duration := universal_blockstun;
        Fighter.Execute_Move(Defender, Defender.block_steps, Blocked_Attack);
      end On_Block;
      
      procedure On_Grab is
      begin
        if Attacker.grabbing and Defender.grabbing then
          Attacker.knockback_velocity_horizontal := counter_grab_pushback;
          Attacker.knockback_duration := counter_grab_push_duration;
          Defender.knockback_velocity_horizontal := counter_grab_pushback;
          Defender.knockback_duration := counter_grab_push_duration;
        else
          Defender.grabbed := true;
          Fighter.Execute_Move(Attacker, Attacker.grab_actions_steps(elem.grab_opponent_steps_index), Grabbing);
          Fighter.Execute_Move(Defender, Attacker.grabbed_opponent_reactions_steps(elem.grab_opponent_steps_index), Grabbed);
        end if;
      end On_Grab;
      
    begin
      while Fighter.Active_Hitboxes.Has_Element(index) loop
        elem := Fighter.Active_Hitboxes.Element(index);
        shape := elem.shape;
        
        if not Attacker.facing_right then
          shape.pos.X := -shape.pos.X;
        end if;
        
        if not elem.hit then
          if Collides(shape + Attacker.pos + Attacker.sprite_offset, Defender.upper_hitbox + Defender.pos + Defender.sprite_offset) then
            case elem.effect is
              when Attack =>
                if Defender.blocking and not Defender.crouching then
                  On_Block;
                else
                  On_Hit;
                end if;
              when Grab =>
                On_Grab;
            end case;
            Mark_Matching_As_Hit(elem.identity);
          elsif Collides(shape + Attacker.pos + Attacker.sprite_offset, Defender.lower_hitbox + Defender.pos + Defender.sprite_offset) then
            case elem.effect is
              when Attack =>
                if Defender.blocking and Defender.crouching then
                  On_Block;
                else
                  On_Hit;
                end if;
              when Grab =>
                On_Grab;
            end case;
            Mark_Matching_As_Hit(elem.identity);
          end if;
        end if;
        
        index := Fighter.Active_Hitboxes.Next(index);
      end loop;
  end Collide_Attacks_With;
  
  procedure Set_Players_Blocking (F1 : in out Fighter.Fighter; F2 : in out Fighter.Fighter) is
  begin
    if F1.pos.X < F2.pos.X then
      if F1.holding_left then
        F1.blocking := true;
      elsif F1.holding_right then
        F1.blocking := false;
      else
        F1.blocking := false;
      end if;
      
      if F2.holding_left then
        F2.blocking := false;
      elsif F2.holding_right then
        F2.blocking := true;
      else
        F2.blocking := false;
      end if;
    else
      if F1.holding_left then
        F1.blocking := false;
      elsif F1.holding_right then
        F1.blocking := true;
      else
        F1.blocking := false;
      end if;
      
      if F2.holding_left then
        F2.blocking := true;
      elsif F2.holding_right then
        F2.blocking := false;
      else
        F2.blocking := false;
      end if;
    end if;
  end Set_Players_Blocking;
    
  procedure Open_Assignment_Screen is
  begin
    state.player_assignment_screen_open := true;
    state.player_connected_slot_one := false;
    state.player_connected_slot_two := false;
    state.p1_connected := false;
    state.p2_connected := false;
  end Open_Assignment_Screen;
    
  procedure Exit_Assignment_Screen is
    procedure Slot_To_Player (GIS : Game_Input_State; slot : Player_Assignment_Slot) is
    begin
      case slot is
        when P1 =>
          state.p1_input_state := GIS;
          state.p1_connected := true;
        when P2 =>
          state.p2_input_state := GIS;
          state.p2_connected := true;
        when others =>
          null;
      end case;
    end Slot_To_Player;
  begin
    if state.player_connected_slot_one then
      Slot_To_Player(state.player_input_state_slot_one, state.player_assignment_slot_one);
    end if;
    
    if state.player_connected_slot_two then
      Slot_To_Player(state.player_input_state_slot_two, state.player_assignment_slot_two);
    end if;
    
    state.player_assignment_screen_open := false;
  end Exit_Assignment_Screen;
  
  procedure State_Input_Step is
    procedure Connect_Player (tran : access Game_Input_Translations; ojh : Opt_Joy_Handle_Access) is
    begin
      state.player_assignment_slot_one := state.player_assignment_slot_two;
      state.player_connected_slot_one := state.player_connected_slot_two;
      if state.player_connected_slot_two then
        state.player_input_state_slot_one := state.player_input_state_slot_two;
      end if;
      state.player_assignment_slot_two := Middle;
      state.player_connected_slot_two := true;
      state.player_input_state_slot_two := Game_Input_State'(
        last => (others => (others => 0.0)),
        cur => (others => (others => 0.0)),
        translations => tran,
        optional_joystick_handle => ojh
      );
    end Connect_Player;
    
    type Slot_Num is (Slot1, Slot2);
    type Slot_Move_Dir is (Left, Right);
    procedure Move_Slot(num : Slot_Num; dir : Slot_Move_Dir) is
      procedure Move_Given_Slot (slot : in out Player_Assignment_Slot) is
      begin
        case dir is
          when Left =>
            if slot = P2 then
              slot := Middle;
            elsif slot = Middle then
              slot := P1;
            end if;
          when Right =>
            if slot = P1 then
              slot := Middle;
            elsif slot = Middle then
              slot := P2;
            end if;
        end case;
      end Move_Given_Slot;
    begin
      case num is
        when Slot1 =>
          Move_Given_Slot(state.player_assignment_slot_one);
        when Slot2 =>
          Move_Given_Slot(state.player_assignment_slot_two);
      end case;
    end Move_Slot;
    
    procedure Refresh_Last_If_Connected (connected : Boolean; GIS : in out Game_Input_State) is
    begin
      if connected then
        Refresh_Last_Direction(GIS);
      end if;
    end Refresh_Last_If_Connected;
    
    procedure Refresh_Cur_If_Connected (connected : Boolean; GIS : in out Game_Input_State; Ev : access ALLEGRO_EVENT) is
    begin
      if connected then
        Refresh_Cur_Direction(GIS, Ev);
      end if;
    end Refresh_Cur_If_Connected;
    
  begin
    while al_get_next_event(Q, Ev) loop
      Refresh_Cur_If_Connected(state.p1_connected, state.p1_input_state, Ev);
      Refresh_Cur_If_Connected(state.p2_connected, state.p2_input_state, Ev);
      
      case Ev.c_type is
        when 42 =>-- code for display getting closed
          state.should_exit := true;
        when others =>
          if Ev.c_type = 4 then
            Reconfigure_Joys:
              declare
                config_changed : Boolean;
              begin
                config_changed := Boolean(al_reconfigure_joysticks);
              end Reconfigure_Joys;
          end if;
          
          if state.player_assignment_screen_open then
            Assignment_Screen_Input:
              declare
                input_caught_by_slot : Boolean := state.player_connected_slot_one or state.player_connected_slot_two;
              begin
                -- needs to move left/right to select player number
                if state.player_connected_slot_one then
                  if Input_Recognized(Ev, state.player_input_state_slot_one, Left_Press) then
                    Move_Slot(Slot1, Left);
                  elsif Input_Recognized(Ev, state.player_input_state_slot_one, Right_Press) then
                    Move_Slot(Slot1, Right);
                  elsif Input_Recognized(Ev, state.player_input_state_slot_one, Start_Press) then
                    Exit_Assignment_Screen;
                  else
                    input_caught_by_slot := false;
                  end if;
                end if;
                
                if state.player_connected_slot_two then
                  if Input_Recognized(Ev, state.player_input_state_slot_two, Left_Press) then
                    Move_Slot(Slot2, Left);
                  elsif Input_Recognized(Ev, state.player_input_state_slot_two, Right_Press) then
                    Move_Slot(Slot2, Right);
                  elsif Input_Recognized(Ev, state.player_input_state_slot_two, Start_Press) then
                    Exit_Assignment_Screen;
                  else
                    input_caught_by_slot := false;
                  end if;
                end if;
                
                if not input_caught_by_slot then
                  case Ev.c_type is
                    when 10 =>-- key down
                      case Ev.keyboard.keycode is
                        when 67 =>-- enter
                          Connect_Player(default_keyboard_translation, new Opt_Joy_Handle(J => No_Joy));
                        when others =>
                          null;
                      end case;
                    when 2 =>-- joystick button down
                      case Ev.joystick.button is
                        when 7 =>-- start button
                          Connect_Player(default_joystick_translation, new Opt_Joy_Handle'(J => Joy, handle => Ev.joystick.source));
                        when others =>
                          null;
                      end case;
                    when others =>
                      null;
                  end case;
                end if;
              end Assignment_Screen_Input;
          else
            case state.GS is
              when Title =>
                if Ev.c_type = 4 then
                  Open_Assignment_Screen;
                end if;
                
                if Input_Recognized(Ev, state.p1_input_state, Start_Press) then
                  if state.ts /= Start_Transition_To_Menu then
                    state.ts := Start_Transition_To_Menu;
                    state.logo_y := Scalar(title_logo_slide_frames) * title_logo_y_move_by;
                    state.frame := 0;
                  end if;
                end if;
              when Menu =>
                if Ev.c_type = 4 then
                  Open_Assignment_Screen;
                end if;
                
                MenuInput:
                  declare
                    procedure Play_Move_Sound is
                      sid : access ALLEGRO_SAMPLE_ID := new ALLEGRO_SAMPLE_ID;
                      played_successfully : Boolean;
                    begin
                      played_successfully := Boolean(al_play_sample(menu_move_sound, 1.0, 0.0, 1.0, ALLEGRO_PLAYMODE_ONCE, sid));
                    end Play_Move_Sound;
                    
                    procedure Menu_Input_For_Player (Player_Connected : Boolean; Player_GIS : Game_Input_State) is
                    begin
                      if Player_Connected then
                        if Input_Recognized(Ev, Player_GIS, Up_Press) then
                          state.menu_index := Menu_Move(state.main_menu.all, state.menu_index, Up);
                          Play_Move_Sound;
                        elsif Input_Recognized(Ev, Player_GIS, Down_Press) then
                          state.menu_index := Menu_Move(state.main_menu.all, state.menu_index, Down);
                          Play_Move_Sound;
                        elsif Input_Recognized(Ev, Player_GIS, Left_Press) then
                          state.menu_index := Menu_Move(state.main_menu.all, state.menu_index, Left);
                          Play_Move_Sound;
                        elsif Input_Recognized(Ev, Player_GIS, Right_Press) then
                          state.menu_index := Menu_Move(state.main_menu.all, state.menu_index, Right);
                          Play_Move_Sound;
                        end if;
                        if Input_Recognized(Ev, Player_GIS, Start_Press) then
                          Menu_Select_Entry(state.main_menu.all, state.menu_index);
                        end if;
                        if Input_Recognized(Ev, Player_GIS, Attack_1_Press) then
                          Menu_Select_Entry(state.main_menu.all, state.menu_index);
                        end if;
                      end if;
                    end Menu_Input_For_Player;
                  begin
                    Menu_Input_For_Player(state.p1_connected, state.p1_input_state);
                    Menu_Input_For_Player(state.p2_connected, state.p2_input_state);
                  end MenuInput;
              when Stage_Select =>
                if Input_Recognized(Ev, state.p1_input_state, Up_Press) then
                  state.p1_stage_index := Menu_Move(state.stage_entries.all, state.p1_stage_index, Up);
                elsif Input_Recognized(Ev, state.p1_input_state, Down_Press) then
                  state.p1_stage_index := Menu_Move(state.stage_entries.all, state.p1_stage_index, Down);
                elsif Input_Recognized(Ev, state.p1_input_state, Left_Press) then
                  state.p1_stage_index := Menu_Move(state.stage_entries.all, state.p1_stage_index, Left);
                elsif Input_Recognized(Ev, state.p1_input_state, Right_Press) then
                  state.p1_stage_index := Menu_Move(state.stage_entries.all, state.p1_stage_index, Right);
                end if;
                
                if Input_Recognized(Ev, state.p1_input_state, Attack_1_Press) then
                  Menu_Select_Entry(state.stage_entries.all, state.p1_stage_index);
                end if;
              when Character_Select =>
                Char_Select_Input:
                  declare
                    procedure Player_Char_Select_Input (GIS : Game_Input_State; menu : access Menu_Entry_Array; menu_index : in out Natural) is
                    begin
                      if Input_Recognized(Ev, GIS, Up_Press) then
                        menu_index := Menu_Move(menu.all, menu_index, Up);
                      elsif Input_Recognized(Ev, GIS, Down_Press) then
                        menu_index := Menu_Move(menu.all, menu_index, Down);
                      elsif Input_Recognized(Ev, GIS, Left_Press) then
                        menu_index := Menu_Move(menu.all, menu_index, Left);
                      elsif Input_Recognized(Ev, GIS, Right_Press) then
                        menu_index := Menu_Move(menu.all, menu_index, Right);
                      end if;
                      
                      if Input_Recognized(Ev, GIS, Attack_1_Press) then
                        Menu_Select_Entry(menu.all, menu_index);
                      end if;
                    end Player_Char_Select_Input;
                  begin
                    Player_Char_Select_Input(state.p1_input_state, state.char_entries, state.p1_char_index);
                    if state.GS = Character_Select then
                      Player_Char_Select_Input(state.p2_input_state, state.char_entries, state.p2_char_index);
                    end if;
                  end Char_Select_Input;
              when Battle =>
                Battle_Input_Step:
                  declare
                    procedure Player_Battle_Input (GIS : Game_Input_State; F : in out Fighter.Fighter) is
                    begin
                      if Input_Recognized(Ev, GIS, Up_Press) then
                        Fighter.Press_Input(F, Globals.up, state.frame);
                      elsif Input_Recognized(Ev, GIS, Left_Press) then
                        Fighter.Press_Input(F, Globals.left, state.frame);
                      elsif Input_Recognized(Ev, GIS, Down_Press) then
                        Fighter.Press_Input(F, Globals.down, state.frame);
                      elsif Input_Recognized(Ev, GIS, Right_Press) then
                        Fighter.Press_Input(F, Globals.right, state.frame);
                      elsif Input_Recognized(Ev, GIS, Attack_1_Press) then
                        Fighter.Press_Input(F, Globals.atk_1, state.frame);
                      elsif Input_Recognized(Ev, GIS, Attack_2_Press) then
                        Fighter.Press_Input(F, Globals.atk_2, state.frame);
                      elsif Input_Recognized(Ev, GIS, Attack_3_Press) then
                        Fighter.Press_Input(F, Globals.atk_3, state.frame);
                      elsif Input_Recognized(Ev, GIS, Attack_4_Press) then
                        Fighter.Press_Input(F, Globals.atk_4, state.frame);
                      elsif Input_Recognized(Ev, GIS, Attack_5_Press) then
                        Fighter.Press_Input(F, Globals.atk_5, state.frame);
                      elsif Input_Recognized(Ev, GIS, Attack_6_Press) then
                        Fighter.Press_Input(F, Globals.atk_6, state.frame);
                      elsif Input_Recognized(Ev, GIS, Start_Press) then
                        F.show_hitboxes := not F.show_hitboxes;
                      end if;
                      
                      if Input_Recognized(Ev, GIS, Up_Release) then
                        Fighter.Release_Input(F, Globals.up, state.frame);
                      end if;
                      
                      if Input_Recognized(Ev, GIS, Left_Release) then
                        Fighter.Release_Input(F, Globals.left, state.frame);
                      end if;
                      
                      if Input_Recognized(Ev, GIS, Down_Release) then
                        Fighter.Release_Input(F, Globals.down, state.frame);
                      end if;
                      
                      if Input_Recognized(Ev, GIS, Right_Release) then
                        Fighter.Release_Input(F, Globals.right, state.frame);
                      end if;
                      
                      if Input_Recognized(Ev, GIS, Attack_1_Release) then
                        Fighter.Release_Input(F, Globals.atk_1, state.frame);
                      elsif Input_Recognized(Ev, GIS, Attack_2_Release) then
                        Fighter.Release_Input(F, Globals.atk_2, state.frame);
                      elsif Input_Recognized(Ev, GIS, Attack_3_Release) then
                        Fighter.Release_Input(F, Globals.atk_3, state.frame);
                      elsif Input_Recognized(Ev, GIS, Attack_4_Release) then
                        Fighter.Release_Input(F, Globals.atk_4, state.frame);
                      elsif Input_Recognized(Ev, GIS, Attack_5_Release) then
                        Fighter.Release_Input(F, Globals.atk_5, state.frame);
                      elsif Input_Recognized(Ev, GIS, Attack_6_Release) then
                        Fighter.Release_Input(F, Globals.atk_6, state.frame);
                      end if;
                    end Player_Battle_Input;
                  begin
                    Player_Battle_Input(state.p1_input_state, state.player_one);
                    Player_Battle_Input(state.p2_input_state, state.player_two);
                  end Battle_Input_Step;
              when Battle_Over =>
                null;
            end case;
          end if;
      end case;

      Refresh_Last_If_Connected(state.p1_connected, state.p1_input_state);
      Refresh_Last_If_Connected(state.p2_connected, state.p2_input_state);
    end loop;
  end State_Input_Step;
  
  procedure State_Draw_Step is
  begin
    al_clear_to_color(Color_Black);
    
    if state.player_assignment_screen_open then
      al_draw_bitmap(player_assign_background_bitmap, 0.0, 0.0, 0);
      
      Draw_Slot_Icons:
        declare
          function Icon_X_Offset (Slot : Player_Assignment_Slot) return Float is
          begin
            case Slot is
              when P1 =>
                return Float(half_screen_width - 360.0);
              when Middle =>
                return Float(half_screen_width - 100.0);
              when P2 =>
                return Float(half_screen_width + 160.0);
            end case;
          end Icon_X_Offset;
          
          function Icon_Bitmap (GIS : Game_Input_State) return access ALLEGRO_BITMAP is
          begin
            if GIS.optional_joystick_handle.J = Joy then
              return player_assign_controller_icon_bitmap;
            else
              return player_assign_keyboard_icon_bitmap;
            end if;
          end Icon_Bitmap;
          
        begin
          al_draw_bitmap(player_assign_player_one_icon_bitmap, 90.0, 30.0, 0);
          al_draw_bitmap(player_assign_player_two_icon_bitmap, 600.0, 30.0, 0);
          if state.player_connected_slot_one then
            al_draw_bitmap(Icon_Bitmap(state.player_input_state_slot_one), Icon_X_Offset(state.player_assignment_slot_one), 80.0, 0);
          end if;
          
          if state.player_connected_slot_two then
            al_draw_bitmap(Icon_Bitmap(state.player_input_state_slot_two), Icon_X_Offset(state.player_assignment_slot_two), 320.0, 0);
          end if;
        end Draw_Slot_Icons;
    else
      case state.GS is
        when Title =>
          al_identity_transform(transform);
          al_use_transform(transform);
          al_draw_bitmap(state.tbackground, 0.0, 0.0, 0);
          
          if state.ts /= Start_Transition_To_Menu then
            al_draw_bitmap(state.tlogo, Float(state.logo_x), Float(state.logo_y), 0);
          else
            al_identity_transform(transform);
            al_scale_transform(transform, Float(state.logo_scale), Float(state.logo_scale));
            al_use_transform(transform);
            al_draw_bitmap(state.tlogo, Float(state.logo_x), Float(state.logo_y), 0);
          end if;
          
          al_identity_transform(transform);
          al_use_transform(transform);
          
          if state.ts = Press_Start_Flashing and state.start_flash_showing then
            al_draw_bitmap(state.tstartmsg, title_start_msg_x, title_start_msg_y, 0);
          end if;
        when Menu =>
          al_identity_transform(transform);
          al_use_transform(transform);
          al_draw_bitmap(state.mbackground, 0.0, 0.0, 0);
          
          al_identity_transform(transform);
          al_scale_transform(transform, Float(state.mlogo_scale), Float(state.mlogo_scale));
          al_use_transform(transform);
          al_draw_bitmap(state.mlogo, Float(state.mlogo_pos.X), Float(state.mlogo_pos.Y), 0);
          
          al_identity_transform(transform);
          al_scale_transform(transform, menu_text_zoom, menu_text_zoom);
          al_use_transform(transform);
          for e in state.main_menu.all'Range loop
            Step:
              declare
                elem : Menu_Entry := state.main_menu.all(e);
              begin
                if e = state.menu_index then
                  -- need to indicate that this element is currently selected
                  al_draw_text(basic_font, Selected_Text_Color, Float(elem.offset.X) + menu_selected_text_x_offset, Float(elem.offset.Y), 0, New_String(elem.text.all));
                else
                  al_draw_text(basic_font, Unselected_Text_Color, Float(elem.offset.X), Float(elem.offset.Y), 0, New_String(elem.text.all));
                end if;
              end Step;
          end loop;
          
          al_identity_transform(transform);
          al_use_transform(transform);
        when Stage_Select =>
          al_draw_bitmap(state.stage_select_background, 0.0, 0.0, 0);
          
          for I in state.stage_icons'Range loop
            al_draw_bitmap(state.stage_icons(I).bitmap, Float(state.stage_entries(I).offset.X), Float(state.stage_entries(I).offset.Y), 0);
            al_draw_text(basic_font, Text_Color, Float(state.stage_entries(I).offset.X), Float(state.stage_entries(I).offset.Y + 68.0), 0, New_String(state.stage_entries(I).text.all));
          end loop;
          
          al_draw_bitmap(state.stage_selector_player_one, Float(state.stage_entries(state.p1_stage_index).offset.X), Float(state.stage_entries(state.p1_stage_index).offset.Y), 0);
        when Character_Select =>
          al_draw_bitmap(state.char_select_background, 0.0, 0.0, 0);
          
          for I in state.char_icons'Range loop
            al_draw_bitmap(state.char_icons(I).bitmap, Float(state.char_entries(I).offset.X), Float(state.char_entries(I).offset.Y), 0);
            al_draw_text(basic_font, Text_Color, Float(state.char_entries(I).offset.X), Float(state.char_entries(I).offset.Y + 68.0), 0, New_String(state.char_entries(I).text.all));
          end loop;
          
          al_draw_bitmap(state.char_selector_player_one, Float(state.char_entries(state.p1_char_index).offset.X), Float(state.char_entries(state.p1_char_index).offset.Y), 0);
          al_draw_bitmap(state.char_selector_player_two, Float(state.char_entries(state.p2_char_index).offset.X), Float(state.char_entries(state.p2_char_index).offset.Y), 0);
        when Battle =>
          al_identity_transform(transform);
          al_translate_transform(transform, Float(state.camera_pos.X), Float(state.camera_pos.Y));
          al_use_transform(transform);
          al_draw_bitmap(state.stage.background, Float(-(screen_width)), 0.0, 0);
          Fighter.Draw(state.player_one);
          Fighter.Draw(state.player_two);
          al_identity_transform(transform);
          al_use_transform(transform);
          al_draw_text(basic_font, Text_Color, 100.0, 10.0, 0, New_String("Player 1 HP: " & state.player_one.hitpoints'Image));
          al_draw_text(basic_font, Text_Color, 500.0, 10.0, 0, New_String("Player 2 HP: " & state.player_two.hitpoints'Image));
        when Battle_Over =>
          null;
      end case;
    end if;
    
    al_flip_display;
  end State_Draw_Step;
  
begin
  
  if al_install_system(Interfaces.C.int(al_get_allegro_version), null) and
  al_install_keyboard and
  al_init_primitives_addon and
  al_init_font_addon and
  al_init_image_addon and
  al_install_audio and
  al_init_acodec_addon and
  al_reserve_samples(32) and
  al_install_joystick then
    Q := al_create_event_queue;
    Display := al_create_display(int(screen_width), int(screen_height));
    DisplayEventSrc := al_get_display_event_source(Display);
    al_register_event_source(Q, DisplayEventSrc);
    KBEventSrc := al_get_keyboard_event_source;
    al_register_event_source(Q, KBEventSrc);
    JoyEventSrc := al_get_joystick_event_source;
    al_register_event_source(Q, JoyEventSrc);
    
    Color_Black := al_map_rgb(0, 0, 0);
    Text_Color := al_map_rgb(255, 255, 255);
    basic_font := al_create_builtin_font;
    Unselected_Text_Color := al_map_rgb(227, 218, 26);
    Selected_Text_Color := al_map_rgb(251, 247, 90);
    
    debug_upper_hitbox_color := al_map_rgb(250, 230, 80);
    debug_lower_hitbox_color := al_map_rgb(170, 130, 170);
    debug_attack_hitbox_color := al_map_rgb(220, 50, 50);
    debug_chunkbox_color := al_map_rgb(87, 87, 82);
    
    menu_move_sound := al_load_sample(New_String(menu_sound_path));
    
    state := new Game_State_Data(Title);
    
    state.tbackground := al_load_bitmap(New_String(title_background_path));
    state.tlogo := al_load_bitmap(New_String(title_logo_path));
    state.tstartmsg := al_load_bitmap(New_String(title_start_message_path));
    state.logo_x := 140.0;
    state.logo_y := -90.0;
    
    player_assign_background_bitmap := al_load_bitmap(New_String(player_assign_background_path));
    player_assign_controller_icon_bitmap := al_load_bitmap(New_String(player_assign_controller_icon_path));
    player_assign_keyboard_icon_bitmap := al_load_bitmap(New_String(player_assign_keyboard_icon_path));
    player_assign_player_one_icon_bitmap := al_load_bitmap(New_String(player_assign_player_one_path));
    player_assign_player_two_icon_bitmap := al_load_bitmap(New_String(player_assign_player_two_path));
    
    loop
      frame_start_time := Clock;
      
      State_Input_Step;
      
      if state.player_assignment_screen_open then
        null;
      else
        case state.GS is
          when Title =>
            case state.ts is
              when Logo_Slide_In =>
                if state.frame >= title_logo_slide_frames then
                  state.ts := Press_Start_Flashing;
                  state.frame := 0;
                  state.update_title_frames := false;
                else
                  state.logo_y := state.logo_y + title_logo_y_move_by;
                end if;
              when Press_Start_Flashing =>
                if state.start_flash_showing then
                  if state.frame >= title_start_flash_on_frames then
                    state.start_flash_showing := false;
                    state.frame := 0;
                    state.update_title_frames := false;
                  end if;
                else
                  if state.frame >= title_start_flash_off_frames then
                    state.start_flash_showing := true;
                    state.frame := 0;
                    state.update_title_frames := false;
                  end if;
                end if;
              when Start_Transition_To_Menu =>
                if state.frame >= title_transition_to_menu_title_slide_frames then
                  PassOnData:
                    declare
                      temp_state : access Game_State_Data := state;
                    begin
                      state := new Game_State_Data(Menu);
                      state.mbackground := temp_state.tbackground;
                      state.mlogo := temp_state.tlogo;
                      state.mlogo_scale := temp_state.logo_scale;
                      state.mlogo_pos := Position'(X => temp_state.logo_x, Y => temp_state.logo_y);
                      state.p1_connected := temp_state.p1_connected;
                      state.p2_connected := temp_state.p2_connected;
                      state.p1_input_state := temp_state.p1_input_state;
                      state.p2_input_state := temp_state.p2_input_state;
                    end PassOnData;
                else
                  state.logo_scale := state.logo_scale + title_transition_scale_amount;
                  state.logo_x := state.logo_x + title_transition_move_x_amount;
                  state.logo_y := state.logo_y + title_transition_move_y_amount;
                end if;
            end case;
            
            if state.GS = Title then
              if state.update_title_frames then
                state.frame := state.frame + 1;
              else
                state.update_title_frames := true;
              end if;
            end if;
          when Menu =>
            null;
          when Stage_Select =>
            if (not state.p1_connected) or (not state.p2_connected) then
              Open_Assignment_Screen;
            end if;
          when Character_Select =>
            if (not state.p1_connected) or (not state.p2_connected) then
              Open_Assignment_Screen;
            end if;
          when Battle =>
            if (state.player_one.pos.X + state.player_one.sprite_offset.X) < (state.player_two.pos.X + state.player_two.sprite_offset.X) then
              if not state.player_one.facing_right and state.player_one.on_ground and not (state.player_one.doing = Normal_Move) and Fighter.Inputs_List.Is_Empty(state.player_one.inputs) then
                state.player_one.facing_right := true;
              end if;
              
              if state.player_two.facing_right and state.player_two.on_ground and not (state.player_two.doing = Normal_Move) and Fighter.Inputs_List.Is_Empty(state.player_two.inputs) then
                state.player_two.facing_right := false;
              end if;
            else
              if state.player_one.facing_right and state.player_one.on_ground and not (state.player_one.doing = Normal_Move) and Fighter.Inputs_List.Is_Empty(state.player_one.inputs) then
                state.player_one.facing_right := false;
              end if;
              
              if not state.player_two.facing_right and state.player_two.on_ground and not (state.player_two.doing = Normal_Move) and Fighter.Inputs_List.Is_Empty(state.player_two.inputs) then
                state.player_two.facing_right := true;
              end if;
            end if;
            
            Fighter.Update(state.player_one, state.frame);
            Fighter.Update(state.player_two, state.frame);
            
            -- check for floor collision here
            feet_touches_floor(state.player_one);
            feet_touches_floor(state.player_two);
            
            -- check for other collisions here
            FighterGeneralCollision:
              declare
                p1_touching_wall : Wall_Collision := body_touches_wall(state.player_one, state.camera_pos.X);
                p2_touching_wall : Wall_Collision := body_touches_wall(state.player_two, state.camera_pos.X);
                players_colliding : Boolean := Collides(state.player_one.chunkbox + state.player_one.pos, state.player_two.chunkbox + state.player_two.pos);
                p1_hitstunned : Boolean := state.player_one.hitstun_duration > 0;
                p2_hitstunned : Boolean := state.player_two.hitstun_duration > 0;
                p1_is_left : Boolean := state.player_one.pos.X < state.player_two.pos.X;
                
                function uncollide_wall (Player : Fighter.Fighter; Touching : Wall_Collision) return Scalar is
                  value : constant Scalar := Player.pos.X + Player.chunkbox.pos.X;
                  absolute_value : constant Scalar := abs value;
                  difference : Scalar := 0.0;
                  
                  procedure calculate_difference is
                    WallX : Scalar := 0.0;
                    rad : Scalar := 0.0;
                    dir : Scalar := 0.0;
                    absolute_wall_x : Scalar := 0.0;
                  begin
                    if Touching = Left_Collision then
                      WallX := -state.camera_pos.X;
                      rad := -Player.chunkbox.radius;
                      dir := -1.0;
                    elsif Touching = Right_Collision then
                      WallX := -(state.camera_pos.X) + screen_width;
                      rad := Player.chunkbox.radius;
                      dir := 1.0;
                    end if;
                    absolute_wall_x := abs WallX;
                    difference := dir * (rad + absolute_value - absolute_wall_x);
                  end calculate_difference;
                begin
                  if Touching = Left_Collision then
                    calculate_difference;
                    return Player.pos.X + difference;
                  elsif Touching = Right_Collision then
                    calculate_difference;
                    return Player.pos.X - difference;
                  else
                    return Player.pos.X;
                  end if;
                end uncollide_wall;
                
                type Uncollide_Dir is (Left, Right);
                
                function uncollide_player (ToMove : Fighter.Fighter; From : Fighter.Fighter; Direction : Uncollide_Dir) return Scalar is
                  move_rad : constant Scalar := ToMove.chunkbox.radius;
                  from_rad : constant Scalar := From.chunkbox.radius;
                  dir : Scalar := 0.0;
                begin
                  case Direction is
                    when Left =>
                      dir := -1.0;
                    when Right =>
                      dir := 1.0;
                  end case;
                  return From.pos.X + (dir * (From.chunkbox.pos.X + move_rad + from_rad + ToMove.chunkbox.pos.X));
                end uncollide_player;
              begin
                if players_colliding and not (state.player_one.grabbed or state.player_two.grabbed) then
                  if p1_touching_wall = p2_touching_wall and p1_touching_wall /= None then
                    state.player_one.pos.X := uncollide_wall(state.player_one, p1_touching_wall);
                    state.player_two.pos.X := uncollide_wall(state.player_two, p2_touching_wall);
                    
                    if p1_touching_wall = Left_Collision then
                      if p1_is_left then
                        state.player_two.pos.X := uncollide_player(state.player_two, state.player_one, Right);
                      else
                         state.player_one.pos.X := uncollide_player(state.player_one, state.player_two, Right);
                      end if;
                    elsif p1_touching_wall = Right_Collision then
                      if p1_is_left then
                        state.player_one.pos.X := uncollide_player(state.player_one, state.player_two, Left);
                      else
                        state.player_two.pos.X := uncollide_player(state.player_two, state.player_one, Left);
                      end if;
                    end if;
                  elsif p1_touching_wall /= None and p2_touching_wall = None then
                    if p1_touching_wall = Left_Collision then
                      state.player_two.pos.X := uncollide_player(state.player_two, state.player_one, Right);
                    elsif p1_touching_wall = Right_Collision then
                      state.player_two.pos.X := uncollide_player(state.player_two, state.player_one, Left);
                    end if;
                  elsif p2_touching_wall /= None and p1_touching_wall = None then
                    if p2_touching_wall = Left_Collision then
                      state.player_one.pos.X := uncollide_player(state.player_one, state.player_two, Right);
                    elsif p2_touching_wall = Right_Collision then
                      state.player_one.pos.X := uncollide_player(state.player_one, state.player_two, Left);
                    end if;
                  elsif p1_hitstunned and not p2_hitstunned then
                    if p1_is_left then
                      state.player_one.pos.X := uncollide_player(state.player_one, state.player_two, Left);
                    else
                      state.player_one.pos.X := uncollide_player(state.player_one, state.player_two, Right);
                    end if;
                  elsif not p1_hitstunned and p2_hitstunned then
                    if p1_is_left then
                      state.player_two.pos.X := uncollide_player(state.player_two, state.player_one, Right);
                    else
                      state.player_two.pos.X := uncollide_player(state.player_two, state.player_one, Left);
                    end if;
                  else
                    if p1_is_left then
                      state.player_one.pos.X := uncollide_player(state.player_one, state.player_two, Left);
                      state.player_two.pos.X := uncollide_player(state.player_two, state.player_one, Right);
                    else
                      state.player_one.pos.X := uncollide_player(state.player_one, state.player_two, Right);
                      state.player_two.pos.X := uncollide_player(state.player_two, state.player_one, Left);
                    end if;
                  end if;
                else
                  state.player_one.pos.X := uncollide_wall(state.player_one, p1_touching_wall);
                  state.player_two.pos.X := uncollide_wall(state.player_two, p2_touching_wall);
                end if;
              end FighterGeneralCollision;
            
            Set_Players_Blocking(state.player_one, state.player_two);
            
            Collide_Attacks_With(state.player_one, state.player_two);
            Collide_Attacks_With(state.player_two, state.player_one);
            
            -- move camera here
            MoveCamera:
              declare
                midpoint : constant Scalar := (Scalar((state.player_one.pos.X - state.player_two.pos.X) / 2.0) + 200.0) * (-1.0);
              begin
                if midpoint < (-(half_stage_width) + half_screen_width) then
                  state.camera_pos.X := -(half_stage_width) + half_screen_width;
                elsif midpoint > (half_stage_width - half_screen_width) then
                  state.camera_pos.X := half_stage_width - half_screen_width;
                else
                  state.camera_pos.X := midpoint;
                end if;
              end MoveCamera;
            
            state.frame := state.frame + 1;
          
          when Battle_Over =>
            null;
        end case;
      end if;
      
      State_Draw_Step;
      
      if state.should_exit then
        exit;
      end if;
      
      delay until frame_start_time + frame_duration;
    end loop;
    al_destroy_event_queue(Q);
    al_destroy_display(Display);
  else
    raise Allegro_Initialization_Failure;
  end if;
end Fighting_Game_Ada;

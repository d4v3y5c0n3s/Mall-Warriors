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
with Move;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Projectile;

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
  
  procedure Empty_Proc is
  begin
    null;
  end Empty_Proc;
  
  function Menu_Entries_For_Moves (chosen : Fighter_Options; x_offset : Scalar) return Menu_Entry_Array is
    move_names : constant Fighter_Move_Name_Array := Fighter_Move_Names(chosen);
    ret : Menu_Entry_Array(move_names'Range);
    last_y : Scalar := 10.0;
    me : Menu_Entry;
  begin
    for I in ret'Range loop
      me := ret(I);
      me.operation := Empty_Proc'Access;
      me.text := new String'(move_names(I).all);
      me.offset.X := x_offset;
      me.offset.Y := last_y + 30.0;
      last_y := me.offset.Y;
      ret(I) := me;
    end loop;
    
    return ret;
  end Menu_Entries_For_Moves;
  
  procedure Main_Menu_Go_To_Verses;
  procedure Main_Menu_Quit_Game;
  
  procedure Choose_Stage;
  
  procedure Choose_Character;
  
  procedure Battle_Over_Rematch;
  procedure Battle_Over_Return_Character_Select;
  procedure Battle_Over_Return_Stage_Select;
  procedure Battle_Over_Quit_Menu;
  
  procedure Battle_Paused_Restart;
  procedure Battle_Paused_Go_Character_Select;
  procedure Battle_Paused_Go_Stage_Select;
  procedure Battle_Paused_Go_Menu;
  
  stage_select_row_count : constant Positive := 5;
  char_select_row_count : constant Positive := 5;
  stage_select_background_path : constant String := "assets/stage_select_background.png";
  char_select_background_path : constant String := "assets/character_select_background.png";
  selection_cursor_player_one_path : constant String := "assets/selector_player_one.png";
  selection_cursor_player_two_path : constant String := "assets/selector_player_two.png";
  battle_round_begin_bitmap_path : constant String := "assets/round_begin_countdown.png";
  victory_bitmap_path : constant String := "assets/victory.png";
  title_logo_start_x : constant Scalar := 140.0;
  title_logo_start_y : constant Scalar := -90.0;
  title_background_path : constant String := "assets/mall_warriors_sky_background.png";
  title_logo_path : constant String := "assets/mall_warriors_logo.png";
  title_start_message_path : constant String := "assets/mall_warriors_press_start.png";
  
  type Icon is record
    bitmap : ALLEGRO_BITMAP_ACCESS;
  end record;
  type Icon_Array is array(Natural range <>) of Icon;
  
  type Battle_Sequence is (None, Intro, Round_Start, Round_End);
  
  type Paused_By is (Unpaused, Player_One, Player_Two);
  
  type Who_Won is (Player_One, Player_Two, Tied);
  
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
        tbackground : ALLEGRO_BITMAP_ACCESS := al_load_bitmap(New_String(title_background_path));
        tlogo : ALLEGRO_BITMAP_ACCESS := al_load_bitmap(New_String(title_logo_path));
        tstartmsg : ALLEGRO_BITMAP_ACCESS := al_load_bitmap(New_String(title_start_message_path));
        logo_x : Scalar := title_logo_start_x;
        logo_y : Scalar := title_logo_start_y;
        start_flash_showing : Boolean := true;
        update_title_frames : Boolean := true;
        logo_scale : Scalar := 1.0;
      when Menu =>
        mbackground : ALLEGRO_BITMAP_ACCESS;
        mlogo : ALLEGRO_BITMAP_ACCESS;
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
        stage_select_background : ALLEGRO_BITMAP_ACCESS := al_load_bitmap(New_String(stage_select_background_path));
        stage_selector_player_one : ALLEGRO_BITMAP_ACCESS := al_load_bitmap(New_String(selection_cursor_player_one_path));
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
        char_select_background : ALLEGRO_BITMAP_ACCESS := al_load_bitmap(New_String(char_select_background_path));
        char_selector_player_one : ALLEGRO_BITMAP_ACCESS := al_load_bitmap(New_String(selection_cursor_player_one_path));
        char_selector_player_two : ALLEGRO_BITMAP_ACCESS := al_load_bitmap(New_String(selection_cursor_player_two_path));
      when Battle =>
        player_one : Fighter.Fighter;
        player_two : Fighter.Fighter;
        camera_pos : Position;
        stage : Stage_Assets;
        sequence_playing : Battle_Sequence := Intro;
        paused : Paused_By := Unpaused;
        round : Positive := 1;
        rounds_won_needed_to_win : Positive := 2;
        player_one_won_rounds : Natural := 0;
        player_two_won_rounds : Natural := 0;
        countdown_bitmap : ALLEGRO_BITMAP_ACCESS := al_load_bitmap(New_String(battle_round_begin_bitmap_path));
        player_one_move_list : access Menu_Entry_Array;
        player_two_move_list : access Menu_Entry_Array;
        player_one_fighter_id : Fighter_Options;
        player_two_fighter_id : Fighter_Options;
        current_stage_id : Stage_Options;
        pause_menu_options : access Menu_Entry_Array := new Menu_Entry_Array'(Menu_Entries_Connect_Gridwise(
        Menu_Entry_Array'(
          0 => Menu_Entry'(
            operation => Battle_Paused_Restart'Access,
            text => new String'("Restart"),
            offset => Position'(X => 100.0, Y => 400.0),
            above_move_entry => 0,
            below_move_entry => 0,
            left_move_entry => 0,
            right_move_entry => 0
          ),
          1 => Menu_Entry'(
            operation => Battle_Paused_Go_Character_Select'Access,
            text => new String'("Return to Character Select"),
            offset => Position'(X => 100.0, Y => 420.0),
            above_move_entry => 0,
            below_move_entry => 0,
            left_move_entry => 0,
            right_move_entry => 0
          ),
          2 => Menu_Entry'(
            operation => Battle_Paused_Go_Stage_Select'Access,
            text => new String'("Return to Stage Select"),
            offset => Position'(X => 100.0, Y => 440.0),
            above_move_entry => 0,
            below_move_entry => 0,
            left_move_entry => 0,
            right_move_entry => 0
          ),
          3 => Menu_Entry'(
            operation => Battle_Paused_Go_Menu'Access,
            text => new String'("Quit to Menu"),
            offset => Position'(X => 100.0, Y => 460.0),
            above_move_entry => 0,
            below_move_entry => 0,
            left_move_entry => 0,
            right_move_entry => 0
          )
        ),
        1
        ));
        pause_menu_options_index : Natural := 0;
      when Battle_Over =>
        victory_bitmap : ALLEGRO_BITMAP_ACCESS := al_load_bitmap(New_String(victory_bitmap_path));
        winner : Who_Won := Tied;
        after_battle_options : access Menu_Entry_Array := new Menu_Entry_Array'(Menu_Entries_Connect_Gridwise(
        Menu_Entry_Array'(
          0 => Menu_Entry'(
            operation => Battle_Over_Rematch'Access,
            text => new String'("Rematch!"),
            offset => Position'(X => 400.0, Y => 400.0),
            above_move_entry => 0,
            below_move_entry => 0,
            left_move_entry => 0,
            right_move_entry => 0
          ),
          1 => Menu_Entry'(
            operation => Battle_Over_Return_Character_Select'Access,
            text => new String'("Return to Character Select"),
            offset => Position'(X => 400.0, Y => 420.0),
            above_move_entry => 0,
            below_move_entry => 0,
            left_move_entry => 0,
            right_move_entry => 0
          ),
          2 => Menu_Entry'(
            operation => Battle_Over_Return_Stage_Select'Access,
            text => new String'("Return to Stage Select"),
            offset => Position'(X => 400.0, Y => 440.0),
            above_move_entry => 0,
            below_move_entry => 0,
            left_move_entry => 0,
            right_move_entry => 0
          ),
          3 => Menu_Entry'(
            operation => Battle_Over_Quit_Menu'Access,
            text => new String'("Quit to Menu"),
            offset => Position'(X => 400.0, Y => 460.0),
            above_move_entry => 0,
            below_move_entry => 0,
            left_move_entry => 0,
            right_move_entry => 0
          )
        ),
        1
        ));
        after_battle_index : Natural := 0;
        previous_stage_id : Stage_Options;
        previous_player_one_fighter_id : Fighter_Options;
        previous_player_two_fighter_id : Fighter_Options;
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
  draw_general_option_x_offset : constant Scalar := -5.0;
  title_logo_slide_frames : constant Natural := 120;
  title_start_flash_on_frames : constant Natural := 60;
  title_start_flash_off_frames : constant Natural := 30;
  title_start_msg_x : constant Float := 280.0;
  title_start_msg_y : constant Float := 300.0;
  title_logo_y_move_by : constant Scalar := 2.0;
  title_logo_slide_final_y : constant Scalar := (title_logo_slide_frames * title_logo_y_move_by) + title_logo_start_x;
  title_transition_to_menu_title_slide_frames : constant Natural := 60;
  title_transition_scale_amount : constant Scalar := -0.01;
  title_transition_move_x_amount : constant Scalar := 5.0;
  title_transition_move_y_amount : constant Scalar := -1.0;
  title_transition_scale_final : constant Scalar := 1.0 + (title_transition_to_menu_title_slide_frames * title_transition_scale_amount);
  title_transition_move_x_final : constant Scalar := title_logo_start_x + (title_transition_to_menu_title_slide_frames * title_transition_move_x_amount);
  title_transition_move_y_final : constant Scalar := title_logo_slide_final_y + (title_transition_to_menu_title_slide_frames * title_transition_move_y_amount);
  menu_text_zoom : constant Float := 2.0;
  menu_sound_path : constant String := "assets/menu_move_pop.flac";
  player_assign_background_path : constant String := "assets/player_assign_background.png";
  player_assign_controller_icon_path : constant String := "assets/controller_icon.png";
  player_assign_keyboard_icon_path : constant String := "assets/keyboard_icon.png";
  player_assign_player_one_path : constant String := "assets/assignment_player_one.png";
  player_assign_player_two_path : constant String := "assets/assignment_player_two.png";
  camera_scroll_threshold : constant Scalar := half_screen_width / 2.0;
  camera_scroll_amount : constant Scalar := 1.0;
  battle_intro_duration : constant Natural := 120;
  battle_round_celebration_duration : constant Natural := 120;
  round_start_countdown_show_three_duration : constant Natural := 60;
  round_start_countdown_show_two_duration : constant Natural := 60;
  round_start_countdown_show_one_duration : constant Natural := 60;
  round_start_countdown_show_go_duration : constant Natural := 45;
  battle_round_countdown_duration : constant Natural := round_start_countdown_show_three_duration + round_start_countdown_show_two_duration + round_start_countdown_show_one_duration + round_start_countdown_show_go_duration;
  battle_player_one_starting_pos : constant Position := Position'(200.0, 400.0);
  battle_player_two_starting_pos : constant Position := Position'(600.0, 400.0);
  battle_player_starting_health : constant Integer := 100;
  battle_pause_movelist_x_offset : constant Scalar := 300.0;
  battle_pause_music_lower_volume : constant Float := 0.4;
  battle_unpause_music_increase_volume : constant Float := 1.0;
  
  frame_start_time : Time := Clock;
  Color_Black : ALLEGRO_COLOR;
  Text_Color : ALLEGRO_COLOR;
  basic_font : access ALLEGRO_FONT;
  transform : access ALLEGRO_TRANSFORM := new ALLEGRO_TRANSFORM;
  state : Game_State_Data_Access;
  Unselected_Text_Color : ALLEGRO_COLOR;
  Selected_Text_Color : ALLEGRO_COLOR;
  menu_move_sound : access ALLEGRO_SAMPLE;
  player_assign_background_bitmap: ALLEGRO_BITMAP_ACCESS;
  player_assign_controller_icon_bitmap : ALLEGRO_BITMAP_ACCESS;
  player_assign_keyboard_icon_bitmap : ALLEGRO_BITMAP_ACCESS;
  player_assign_player_one_icon_bitmap : ALLEGRO_BITMAP_ACCESS;
  player_assign_player_two_icon_bitmap : ALLEGRO_BITMAP_ACCESS;
  
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
        temp_state : constant Game_State_Data_Access := state;
      begin
        state := new Game_State_Data(Stage_Select);
        Game_State_Pass_Player_Inputs(temp_state, state);
      end Go_To_Stage_Select;
  end Main_Menu_Go_To_Verses;
  
  procedure Go_Back_To_Character_Select (stage : Stage_Options);
  
  procedure Main_Menu_Quit_Game is
  begin
    state.should_exit := true;
  end Main_Menu_Quit_Game;
  
  procedure Choose_Stage is
  begin
    Go_To_Character_Select:
      declare
        temp_state : constant Game_State_Data_Access := state;
      begin
        Go_Back_To_Character_Select(Stage_Options'Val(temp_state.p1_stage_index));
      end Go_To_Character_Select;
  end Choose_Stage;
  
  procedure Go_To_Start_Battle (choosen_stage : Stage_Options; p1_fighter_id : Fighter_Options; p2_fighter_id : Fighter_Options) is
  begin
    Go_To_Battle:
      declare
        function Generate_Movelist (fighter_id : Fighter_Options; x_offset : Scalar) return Menu_Entry_Array is
        begin
          return Menu_Entries_Connect_Gridwise(Menu_Entries_For_Moves(fighter_id, x_offset), 1);
        end Generate_Movelist;
        
        temp_state : constant access Game_State_Data := state;
      begin
        state := new Game_State_Data(Battle);
        state.player_one := Load_Fighter(p1_fighter_id);
        state.player_two := Load_Fighter(p2_fighter_id);
        state.stage := Load_Stage(choosen_stage);
        state.player_one.pos := battle_player_one_starting_pos;
        state.player_two.pos := battle_player_two_starting_pos;
        state.player_one.hitpoints := battle_player_starting_health;
        state.player_two.hitpoints := battle_player_starting_health;
        Game_State_Pass_Player_Inputs(temp_state, state);
        state.player_one_move_list := new Menu_Entry_Array'(Generate_Movelist(p1_fighter_id, battle_pause_movelist_x_offset));
        state.player_two_move_list := new Menu_Entry_Array'(Generate_Movelist(p2_fighter_id, battle_pause_movelist_x_offset));
        state.player_one_fighter_id := p1_fighter_id;
        state.player_two_fighter_id := p2_fighter_id;
        state.current_stage_id := choosen_stage;
        state.frame := 0;
      end Go_To_Battle;
  end Go_To_Start_Battle;
  
  procedure Choose_Character is
  begin
    Go_To_Start_Battle(state.choosen_stage, Fighter_Options'Val(state.p1_char_index), Fighter_Options'Val(state.p2_char_index));
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
      proj_index : Fighter.Active_Projectiles_List.Cursor := Fighter.Active_Projectiles_List.First(Attacker.active_projectiles);
      proj_elem : Projectile.Projectile;
      
      procedure Mark_Matching_As_Hit (hit_id : Integer) is
        cursor : Fighter.Active_Hitboxes.Cursor := Fighter.Active_Hitboxes.First(Attacker.attack_hitboxes);
        temp_hitbox : Hitbox;
        proj_cursor : Fighter.Active_Projectiles_List.Cursor := Fighter.Active_Projectiles_List.First(Attacker.active_projectiles);
        temp_phbs : Projectile.Projectile_Hitboxes.List;
      begin
        while Fighter.Active_Hitboxes.Has_Element(cursor) loop
          temp_hitbox := Fighter.Active_Hitboxes.Element(cursor);
          
          if temp_hitbox.identity = hit_id then
            temp_hitbox.hit := true;
            Fighter.Active_Hitboxes.Replace_Element(Attacker.attack_hitboxes, cursor, temp_hitbox);
          end if;
          
          cursor := Fighter.Active_Hitboxes.Next(cursor);
        end loop;
        
        while Fighter.Active_Projectiles_List.Has_Element(proj_cursor) loop
          temp_phbs := Fighter.Active_Projectiles_List.Element(proj_cursor).hitboxes;
          
          Iterate_Over_Projectile_Hitboxes:
            declare
              PHB_Cursor : Projectile.Projectile_Hitboxes.Cursor := Projectile.Projectile_Hitboxes.First(temp_phbs);
              PHB_Elem : Hitbox;
            begin
              while Projectile.Projectile_Hitboxes.Has_Element(PHB_Cursor) loop
                PHB_Elem := Projectile.Projectile_Hitboxes.Element(PHB_Cursor);
                
                if PHB_Elem.identity = hit_id then
                  Projectile.Projectile_Hitboxes.Delete(temp_phbs, PHB_Cursor);
                end if;
                
                PHB_Cursor := Projectile.Projectile_Hitboxes.Next(PHB_Cursor);
              end loop;
            end Iterate_Over_Projectile_Hitboxes;
          
          proj_cursor := Fighter.Active_Projectiles_List.Next(proj_cursor);
        end loop;
      end Mark_Matching_As_Hit;
      
      procedure On_Hit (hit_with : Hitbox) is
      begin
        if Defender.armor > 0 then
          Defender.armor := Defender.armor - 1;
        else
          Defender.hitpoints := Defender.hitpoints - hit_with.damage;
          Defender.hitstun_duration := hit_with.hitstun_duration;
          Defender.knockback_velocity_vertical := hit_with.knockback_vertical;
          Defender.knockback_velocity_horizontal := hit_with.knockback_horizontal;
          Defender.knockback_duration := hit_with.knockback_duration;
          Defender.dash_duration := 0;
          Fighter.Execute_Move(Defender, Defender.on_hit_steps, Hit_By_Attack);
        end if;
      end On_Hit;
      
      procedure On_Block is
      begin
        Defender.blockstun_duration := universal_blockstun;
        if Defender.crouching then
          Fighter.Execute_Move(Defender, Defender.crouching_block_steps, Blocked_Attack);
        else
          Fighter.Execute_Move(Defender, Defender.standing_block_steps, Blocked_Attack);
        end if;
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
      
      function Check_Attacker_Hitbox (atk_hb : Hitbox) return Boolean is
        touches_upper : constant Boolean := Collides(atk_hb.shape, Defender.upper_hitbox + Defender.pos + Defender.upper_hitbox_temp_offset);
        touches_lower : constant Boolean := Collides(atk_hb.shape, Defender.lower_hitbox + Defender.pos + Defender.lower_hitbox_temp_offset);
      begin
        if not atk_hb.hit then
          if touches_upper or touches_lower then
            case atk_hb.effect is
              when Attack =>
                if Defender.blocking and ((touches_upper and not Defender.crouching) or (touches_lower and Defender.crouching)) then
                  On_Block;
                else
                  On_Hit(atk_hb);
                end if;
              when Grab =>
                On_Grab;
            end case;
            
            Mark_Matching_As_Hit(atk_hb.identity);
            return true;
          end if;
        end if;
        
        return false;
      end Check_Attacker_Hitbox;
      
    begin
      while Fighter.Active_Hitboxes.Has_Element(index) loop
        elem := Fighter.Active_Hitboxes.Element(index);
        
        if not Attacker.facing_right then
          elem.shape.pos.X := -elem.shape.pos.X;
        end if;
        
        Active_Hitbox_Check:
          declare
            hit : Boolean := false;
          begin
            elem.shape.pos := elem.shape.pos + Attacker.pos;
            hit := Check_Attacker_Hitbox(elem);
          end Active_Hitbox_Check;
        
        index := Fighter.Active_Hitboxes.Next(index);
      end loop;
      
      while Fighter.Active_Projectiles_List.Has_Element(proj_index) loop
        proj_elem := Fighter.Active_Projectiles_List.Element(proj_index);
        
        Iterate_Through_Projectile_Hitboxes:
          declare
            proj_hb_index : Projectile.Projectile_Hitboxes.Cursor := Projectile.Projectile_Hitboxes.First(proj_elem.hitboxes);
          begin
            while Projectile.Projectile_Hitboxes.Has_Element(proj_hb_index) loop
              Projectile_Hitbox_Check:
                declare
                  HB : Hitbox := Projectile.Projectile_Hitboxes.Element(proj_hb_index);
                begin
                  HB.shape.pos := HB.shape.pos + proj_elem.pos;
                  
                  if Check_Attacker_Hitbox(HB) then
                    Projectile.Projectile_Hitboxes.Delete(proj_elem.hitboxes, proj_hb_index);
                    Fighter.Active_Projectiles_List.Replace_Element(Attacker.active_projectiles, proj_index, proj_elem);
                    
                    -- exit when first hitbox of projectile makes contact so that multi-hit projectiles won't hit all on the same frame
                    exit;
                  end if;
                end Projectile_Hitbox_Check;
                
                proj_hb_index := Projectile.Projectile_Hitboxes.Next(proj_hb_index);
            end loop;
          end Iterate_Through_Projectile_Hitboxes;
        
        proj_index := Fighter.Active_Projectiles_List.Next(proj_index);
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
  
  procedure Transition_To_Menu_State (tbackground : ALLEGRO_BITMAP_ACCESS; tlogo : ALLEGRO_BITMAP_ACCESS; logo_scale : Scalar; logo_pos : Position; prev_state : access Game_State_Data) is
  begin
    state := new Game_State_Data(Menu);
    state.mbackground := tbackground;
    state.mlogo := tlogo;
    state.mlogo_scale := logo_scale;
    state.mlogo_pos := logo_pos;
    Game_State_Pass_Player_Inputs(prev_state, state);
  end Transition_To_Menu_State;
  
  procedure Go_Back_To_Menu is
  begin
    Transition_To_Menu_State(al_load_bitmap(New_String(title_background_path)), al_load_bitmap(New_String(title_logo_path)), title_transition_scale_final, Position'(X => title_transition_move_x_final, Y => title_transition_move_y_final), state);
  end Go_Back_To_Menu;
  
  procedure Go_Back_To_Character_Select (stage : Stage_Options) is
    temp_state : constant Game_State_Data_Access := state;
  begin
    state := new Game_State_Data(Character_Select);
    state.choosen_stage := stage;
    Game_State_Pass_Player_Inputs(temp_state, state);
  end Go_Back_To_Character_Select;
  
  procedure Battle_Over_Rematch is
  begin
    Go_To_Start_Battle(state.previous_stage_id, state.previous_player_one_fighter_id, state.previous_player_two_fighter_id);
  end Battle_Over_Rematch;
  
  procedure Battle_Over_Return_Character_Select is
  begin
    Go_Back_To_Character_Select(state.previous_stage_id);
  end Battle_Over_Return_Character_Select;
  
  procedure Battle_Over_Return_Stage_Select is
  begin
    Main_Menu_Go_To_Verses;
  end Battle_Over_Return_Stage_Select;
  
  procedure Battle_Over_Quit_Menu is
  begin
    Go_Back_To_Menu;
  end Battle_Over_Quit_Menu;
  
  procedure Battle_Stop_Sounds_Music is
    stop_music_success : constant Boolean := Boolean(al_set_audio_stream_playing(state.stage.music, false));
  begin
    al_stop_samples;
  end Battle_Stop_Sounds_Music;
  
  procedure Battle_Paused_Restart is
  begin
    Battle_Stop_Sounds_Music;
    Go_To_Start_Battle(state.current_stage_id, state.player_one_fighter_id, state.player_two_fighter_id);
  end Battle_Paused_Restart;
  
  procedure Battle_Paused_Go_Character_Select is
  begin
    Battle_Stop_Sounds_Music;
    Go_Back_To_Character_Select(state.current_stage_id);
  end Battle_Paused_Go_Character_Select;
  
  procedure Battle_Paused_Go_Stage_Select is
  begin
    Battle_Stop_Sounds_Music;
    Main_Menu_Go_To_Verses;
  end Battle_Paused_Go_Stage_Select;
  
  procedure Battle_Paused_Go_Menu is
  begin
    Battle_Stop_Sounds_Music;
    Go_Back_To_Menu;
  end Battle_Paused_Go_Menu;
  
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
                        when controller_start_id =>-- start button
                          Connect_Player(default_joystick_translation, new Opt_Joy_Handle'(J => Joy, handle => Ev.joystick.id));
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
                    state.logo_y := title_logo_slide_final_y;
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
                        if Input_Recognized(Ev, Player_GIS, Start_Press) or Input_Recognized(Ev, Player_GIS, Attack_4_Press) then
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
                
                if Input_Recognized(Ev, state.p1_input_state, Attack_4_Press) then
                  Menu_Select_Entry(state.stage_entries.all, state.p1_stage_index);
                end if;

                if Input_Recognized(Ev, state.p1_input_state, Attack_5_Press) then
                  Go_Back_To_Menu;
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
                      
                      if Input_Recognized(Ev, GIS, Attack_4_Press) then
                        Menu_Select_Entry(menu.all, menu_index);
                      end if;
                      
                      if Input_Recognized(Ev, GIS, Attack_5_Press) then
                        Main_Menu_Go_To_Verses;
                      end if;
                    end Player_Char_Select_Input;
                  begin
                    Player_Char_Select_Input(state.p1_input_state, state.char_entries, state.p1_char_index);
                    if state.GS = Character_Select then
                      Player_Char_Select_Input(state.p2_input_state, state.char_entries, state.p2_char_index);
                    end if;
                  end Char_Select_Input;
              when Battle =>
                if state.paused = Unpaused then
                  case state.sequence_playing is
                    when Intro =>
                      null;
                    when Round_Start =>
                      null;
                    when Round_End =>
                      null;
                    when None =>
                      Battle_Input_Step:
                        declare
                          procedure Player_Battle_Input (GIS : Game_Input_State; F : in out Fighter.Fighter; Player_Pause : Paused_By) is
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
                            
                            if Input_Recognized(Ev, GIS, Start_Press) then
                              state.paused := Player_Pause;
                              Make_Music_Quieter:
                                declare
                                  success : constant Boolean := Boolean(al_set_audio_stream_gain(state.stage.music, battle_pause_music_lower_volume));
                                begin
                                  null;
                                end Make_Music_Quieter;
                            end if;
                          end Player_Battle_Input;
                        begin
                          Player_Battle_Input(state.p1_input_state, state.player_one, Player_One);
                          Player_Battle_Input(state.p2_input_state, state.player_two, Player_Two);
                        end Battle_Input_Step;
                  end case;
                else
                  Pause_Menu_Input:
                    declare
                      pause_player_input_state : constant Game_Input_State := (if state.paused = Player_One then state.p1_input_state else state.p2_input_state);
                    begin
                      if Input_Recognized(Ev, pause_player_input_state, Up_Press) then
                        state.pause_menu_options_index := Menu_Move(state.pause_menu_options.all, state.pause_menu_options_index, Up);
                      elsif Input_Recognized(Ev, pause_player_input_state, Down_Press) then
                        state.pause_menu_options_index := Menu_Move(state.pause_menu_options.all, state.pause_menu_options_index, Down);
                      elsif Input_Recognized(Ev, pause_player_input_state, Attack_4_Press) then
                        Menu_Select_Entry(state.pause_menu_options.all, state.pause_menu_options_index);
                      elsif Input_Recognized(Ev, pause_player_input_state, Start_Press) then
                        state.paused := Unpaused;
                        state.pause_menu_options_index := 0;
                        
                        Increase_Volume_To_Normal:
                          declare
                            success : Boolean := Boolean(al_set_audio_stream_gain(state.stage.music, battle_unpause_music_increase_volume));
                          begin
                            null;
                          end Increase_Volume_To_Normal;
                      end if;
                    end Pause_Menu_Input;
                end if;
              when Battle_Over =>
                Battle_Over_Input:
                  declare
                    procedure Player_Decide_After_Battle (GIS : Game_Input_State) is
                    begin
                      if Input_Recognized(Ev, GIS, Up_Press) then
                        state.after_battle_index := Menu_Move(state.after_battle_options.all, state.after_battle_index, Up);
                      elsif Input_Recognized(Ev, GIS, Down_Press) then
                        state.after_battle_index := Menu_Move(state.after_battle_options.all, state.after_battle_index, Down);
                      elsif Input_Recognized(Ev, GIS, Attack_4_Press) then
                        Menu_Select_Entry(state.after_battle_options.all, state.after_battle_index);
                      end if;
                    end Player_Decide_After_Battle;
                  begin
                    Player_Decide_After_Battle(state.p1_input_state);
                    if state.GS = Battle_Over then
                      Player_Decide_After_Battle(state.p2_input_state);
                    end if;
                  end Battle_Over_Input;
            end case;
          end if;
      end case;

      Refresh_Last_If_Connected(state.p1_connected, state.p1_input_state);
      Refresh_Last_If_Connected(state.p2_connected, state.p2_input_state);
    end loop;
  end State_Input_Step;
  
  procedure State_Draw_Step is
  
    type General_Option_State is (Selected, Unselected);
    
    procedure Draw_General_Option (option_text : String; option_pos : Position; option_state : General_Option_State) is
      color : ALLEGRO_COLOR;
      x_coord : Scalar;
    begin
      case option_state is
        when Selected =>
          color := Selected_Text_Color;
          x_coord := option_pos.X + draw_general_option_x_offset;
        when Unselected =>
          color := Unselected_Text_Color;
          x_coord := option_pos.X;
      end case;
      
      al_draw_text(basic_font, color, Float(x_coord), Float(option_pos.Y), 0, New_String(option_text));
    end Draw_General_Option;
    
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
          
          function Icon_Bitmap (GIS : Game_Input_State) return ALLEGRO_BITMAP_ACCESS is
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
                  Draw_General_Option(elem.text.all, elem.offset, Selected);
                else
                  Draw_General_Option(elem.text.all, elem.offset, Unselected);
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
          
          if state.paused = Unpaused then
            
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
            al_draw_text(basic_font, Text_Color, 300.0, 10.0, 0, New_String("Round #: " & state.round'Image));
            al_draw_text(basic_font, Text_Color, 100.0, 20.0, 0, New_String("Rounds Won: " & state.player_one_won_rounds'Image));
            al_draw_text(basic_font, Text_Color, 500.0, 20.0, 0, New_String("Rounds Won: " & state.player_two_won_rounds'Image));
            
            case state.sequence_playing is
              when Intro =>
                null;
              when Round_Start =>
                Draw_Countdown:
                  declare
                    procedure Draw_Countdown_Region (offset_x : Float; offset_y : Float) is
                    begin
                      al_draw_bitmap_region(state.countdown_bitmap, offset_x, offset_y, 200.0, 200.0, 300.0, 100.0, 0);
                    end Draw_Countdown_Region;
                  begin
                    if state.frame <= round_start_countdown_show_three_duration then
                      Draw_Countdown_Region(0.0, 0.0);
                    elsif state.frame <= (round_start_countdown_show_two_duration + round_start_countdown_show_three_duration) then
                      Draw_Countdown_Region(200.0, 0.0);
                    elsif state.frame <= (round_start_countdown_show_one_duration + round_start_countdown_show_two_duration + round_start_countdown_show_three_duration) then
                      Draw_Countdown_Region(0.0, 200.0);
                    else
                      Draw_Countdown_Region(200.0, 200.0);
                    end if;
                  end Draw_Countdown;
              when Round_End =>
                null;
              when None =>
                null;
            end case;
          else
            Draw_Pause_Menu:
              declare
                procedure Show_Player_Who_Paused (Paused_By_Text : String) is
                begin
                  al_draw_text(basic_font, Text_Color, 10.0, 10.0, 0, New_String("Paused by " & Paused_By_Text));
                end Show_Player_Who_Paused;
                
                procedure Show_Move_Inputs (moves_entries : access Menu_Entry_Array; player_moves_col : Fighter.Moves_Collection_Access; fo : Fighter_Options) is
                  function Move_Inputs_Text (at_ind : Natural) return String is
                    move_we_want : constant Move.Move := player_moves_col(Fighter_Move_Indexes(fo)(at_ind));
                    ret : Unbounded_String := To_Unbounded_String("");
                    cmd : Input_Tree_Node_Access;
                  begin
                    for I in move_we_want.command.all'Range loop
                      cmd := move_we_want.command.all(I);
                      if cmd.ID /= tree_end then
                        ret := ret & (if I /= move_we_want.command.all'First then ", " else "") & cmd.ID'Image;
                      end if;
                    end loop;
                    
                    return To_String(ret);
                  end Move_Inputs_Text;
                  current_entry : Menu_Entry;
                begin
                  for I in moves_entries.all'Range loop
                    current_entry := moves_entries(I);
                    al_draw_text(basic_font, Text_Color, Float(current_entry.offset.X), Float(current_entry.offset.Y), 0, New_String(current_entry.text.all & " -->  " & Move_Inputs_Text(I)));
                  end loop;
                end Show_Move_Inputs;
                
              begin
                if state.paused = Player_One then
                  Show_Player_Who_Paused("Player One");
                  Show_Move_Inputs(state.player_one_move_list, state.player_one.moves, state.player_one_fighter_id);
                elsif state.paused = Player_Two then
                  Show_Player_Who_Paused("Player Two");
                  Show_Move_Inputs(state.player_two_move_list, state.player_two.moves, state.player_two_fighter_id);
                end if;
                
                for I in state.pause_menu_options.all'Range loop
                  Draw_Pause_Menu_Option:
                    declare
                      mi : constant Menu_Entry := state.pause_menu_options(I);
                    begin
                      Draw_General_Option(mi.text.all, mi.offset, (if I = state.pause_menu_options_index then Selected else Unselected));
                    end Draw_Pause_Menu_Option;
                end loop;
              end Draw_Pause_Menu;
          end if;
        when Battle_Over =>
          Draw_Victory_Screen:
            declare
              procedure Show_Winner (bitmap : ALLEGRO_BITMAP_ACCESS) is
              begin
                al_draw_bitmap(bitmap, 600.0, 250.0, 0);
              end Show_Winner;
            begin
              al_draw_bitmap(state.victory_bitmap, 0.0, 0.0, 0);
              
              if state.winner = Player_One then
                Show_Winner(player_assign_player_one_icon_bitmap);
              elsif state.winner = Player_Two then
                Show_Winner(player_assign_player_two_icon_bitmap);
              end if;
              
              for I in state.after_battle_options'Range loop
                Draw_After_Battle_Options:
                  declare
                    mi : constant Menu_Entry := state.after_battle_options(I);
                    gos : constant General_Option_State := (if I = state.after_battle_index then Selected else Unselected);
                  begin
                    Draw_General_Option(mi.text.all, mi.offset, gos);
                  end Draw_After_Battle_Options;
              end loop;
            end Draw_Victory_Screen;
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
                      temp_state : constant access Game_State_Data := state;
                    begin
                      Transition_To_Menu_State(temp_state.tbackground, temp_state.tlogo, temp_state.logo_scale, Position'(X => temp_state.logo_x, Y => temp_state.logo_y), temp_state);
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
            if state.paused = Unpaused then
              case state.sequence_playing is
                when Intro =>
                  if state.frame >= battle_intro_duration then
                    state.sequence_playing := Round_Start;
                    state.frame := 0;
                  end if;
                when Round_Start =>
                  if state.frame >= battle_round_countdown_duration then
                    state.sequence_playing := None;
                  end if;
                when Round_End =>
                  if state.frame >= battle_round_celebration_duration then
                    End_Of_Round:
                      declare
                        function Player_Won (player_num_wins : Natural) return Boolean is
                        begin
                          return player_num_wins >= Natural(state.rounds_won_needed_to_win);
                        end Player_Won;
                        
                        procedure On_Player_Win (result : Who_Won) is
                          temp_state : constant Game_State_Data_Access := state;
                        begin
                          Battle_Stop_Sounds_Music;
                          state := new Game_State_Data(Battle_Over);
                          state.winner := result;
                          state.previous_stage_id := temp_state.current_stage_id;
                          state.previous_player_one_fighter_id := temp_state.player_one_fighter_id;
                          state.previous_player_two_fighter_id := temp_state.player_two_fighter_id;
                          Game_State_Pass_Player_Inputs(temp_state, state);
                          state.frame := 0;
                        end On_Player_Win;
                        
                        procedure Award_Round_Win_If_Dead (Win_Total : in out Natural; Other_Guy : Fighter.Fighter) is
                        begin
                          if Other_Guy.hitpoints <= 0 then
                            Win_Total := Win_Total + 1;
                          end if;
                        end Award_Round_Win_If_Dead;
                        
                        procedure Reset_Player (Player : in out Fighter.Fighter; ToPos : Position) is
                        begin
                          Player.hitpoints := battle_player_starting_health;
                          Player.pos := ToPos;
                          Player.holding_right := false;
                          Player.holding_left := false;
                          Player.holding_down := false;
                          Player.hitstun_duration := 0;
                          Player.blockstun_duration := 0;
                          Player.grabbed := false;
                          Player.grabbing := false;
                          Player.velocity_horizontal := 0.0;
                          Player.velocity_vertical := 0.0;
                          Player.knockback_velocity_vertical := 0.0;
                          Player.knockback_velocity_horizontal := 0.0;
                          Player.knockback_duration := 0;
                          Player.dash_velocity_vertical := 0.0;
                          Player.dash_velocity_horizontal := 0.0;
                          Player.dash_duration := 0;
                          Player.upper_hitbox_temp_offset := Position'(X => 0.0, Y => 0.0);
                          Player.lower_hitbox_temp_offset := Position'(X => 0.0, Y => 0.0);
                          
                          for EB of Player.extended_bitmaps.all loop
                            EB.shown := false;
                            EB.anim_index := 0;
                            EB.anim_frame := 0;
                          end loop;
                          
                          Fighter.Active_Hitboxes.Clear(Player.attack_hitboxes);
                          Fighter.Active_Projectiles_List.Clear(Player.active_projectiles);
                          
                          Fighter.Execute_Move(Player, Player.idle_stand_steps, Idle);
                        end Reset_Player;
                        
                      begin
                        Award_Round_Win_If_Dead(state.player_one_won_rounds, state.player_two);
                        Award_Round_Win_If_Dead(state.player_two_won_rounds, state.player_one);
                        
                        if Player_Won(state.player_one_won_rounds) then
                          On_Player_Win(Player_One);
                        elsif Player_Won(state.player_two_won_rounds) then
                          On_Player_Win(Player_Two);
                        else
                          state.sequence_playing := Round_Start;
                          state.round := state.round + 1;
                          Reset_Player(state.player_one, battle_player_one_starting_pos);
                          Reset_Player(state.player_two, battle_player_two_starting_pos);
                          state.camera_pos := Position'(0.0, 0.0);
                          state.frame := 0;
                        end if;
                      end End_Of_Round;
                  end if;
                when None =>
                  null;
              end case;
              
              if state.GS = Battle then
                if state.player_one.pos.X < state.player_two.pos.X then
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
                
                -- collide projectiles with other projectiles here
                Projectile_On_Projectile_Collision:
                  declare
                    p1_proj_cursor : Fighter.Active_Projectiles_List.Cursor := Fighter.Active_Projectiles_List.First(state.player_one.active_projectiles);
                    p2_proj_cursor : Fighter.Active_Projectiles_List.Cursor := Fighter.Active_Projectiles_List.First(state.player_two.active_projectiles);
                  begin
                    while Fighter.Active_Projectiles_List.Has_Element(p1_proj_cursor) loop
                      while Fighter.Active_Projectiles_List.Has_Element(p2_proj_cursor) loop
                        Projectile_Hitboxes_Collide:
                          declare
                            procedure Destroy_Projectile_Check (list : in out Fighter.Active_Projectiles_List.List; cursor : in out Fighter.Active_Projectiles_List.Cursor; cur_projectile : Projectile.Projectile) is
                            begin
                              if Projectile.Projectile_Hitboxes.Is_Empty(cur_projectile.hitboxes) then
                                Fighter.Active_Projectiles_List.Delete(list, cursor);
                              end if;
                            end Destroy_Projectile_Check;
                            
                            first_projectile : Projectile.Projectile := Fighter.Active_Projectiles_List.Element(p1_proj_cursor);
                            second_projectile : Projectile.Projectile := Fighter.Active_Projectiles_List.Element(p2_proj_cursor);
                            first_proj_hb_cursor : Projectile.Projectile_Hitboxes.Cursor := Projectile.Projectile_Hitboxes.First(first_projectile.hitboxes);
                            second_proj_hb_cursor : Projectile.Projectile_Hitboxes.Cursor := Projectile.Projectile_Hitboxes.First(second_projectile.hitboxes);
                          begin
                            while Projectile.Projectile_Hitboxes.Has_Element(first_proj_hb_cursor) loop
                              while Projectile.Projectile_Hitboxes.Has_Element(second_proj_hb_cursor) loop
                                if Collides((Projectile.Projectile_Hitboxes.Element(first_proj_hb_cursor).shape + first_projectile.pos), (Projectile.Projectile_Hitboxes.Element(second_proj_hb_cursor).shape) + second_projectile.pos) then
                                  Projectile.Projectile_Hitboxes.Delete(first_projectile.hitboxes, first_proj_hb_cursor);
                                  Projectile.Projectile_Hitboxes.Delete(second_projectile.hitboxes, second_proj_hb_cursor);
                                end if;
                                
                                second_proj_hb_cursor := Projectile.Projectile_Hitboxes.Next(second_proj_hb_cursor);
                              end loop;
                              
                              first_proj_hb_cursor := Projectile.Projectile_Hitboxes.Next(first_proj_hb_cursor);
                            end loop;
                            
                            Destroy_Projectile_Check(state.player_one.active_projectiles, p1_proj_cursor, first_projectile);
                            Destroy_Projectile_Check(state.player_two.active_projectiles, p2_proj_cursor, second_projectile);
                          end Projectile_Hitboxes_Collide;
                        
                        p2_proj_cursor := Fighter.Active_Projectiles_List.Next(p2_proj_cursor);
                      end loop;
                      
                      p1_proj_cursor := Fighter.Active_Projectiles_List.Next(p1_proj_cursor);
                    end loop;
                  end Projectile_On_Projectile_Collision;
                
                -- move camera here
                MoveCamera:
                  declare
                    cam_middle_relative_to_players : constant Scalar := -(state.camera_pos.X - half_screen_width);
                    left_threshold : constant Scalar := cam_middle_relative_to_players - camera_scroll_threshold;
                    right_threshold : constant Scalar := cam_middle_relative_to_players + camera_scroll_threshold;
                    left_threshold_passed : constant Boolean := (state.player_one.pos.X <= left_threshold) or (state.player_two.pos.X <= left_threshold);
                    right_threshold_passed : constant Boolean := (state.player_one.pos.X >= right_threshold) or (state.player_two.pos.X >= right_threshold);
                  begin
                    if (state.camera_pos.X - half_screen_width) <= -(half_stage_width) then
                      state.camera_pos.X := -(half_stage_width) + half_screen_width;
                    elsif (state.camera_pos.X + half_screen_width) >= half_stage_width then
                      state.camera_pos.X := half_stage_width - half_screen_width;
                    else
                      if not (left_threshold_passed and right_threshold_passed) then
                        if left_threshold_passed then
                          state.camera_pos.X := state.camera_pos.X + camera_scroll_amount;
                        elsif right_threshold_passed then
                          state.camera_pos.X := state.camera_pos.X - camera_scroll_amount;
                        end if;
                      end if;
                    end if;
                  end MoveCamera;
                
                if not (state.sequence_playing = Round_End) and (state.player_one.hitpoints <= 0 or state.player_two.hitpoints <= 0) then
                  state.sequence_playing := Round_End;
                  state.frame := 0;
                else
                  state.frame := state.frame + 1;
                end if;
              end if;
            else
              null;
            end if;
          
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

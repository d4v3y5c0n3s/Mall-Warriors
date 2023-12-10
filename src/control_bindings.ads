with allegro5_events_h; use allegro5_events_h;
with Interfaces.C; use Interfaces.C;
with System; use System;
with System.Address_To_Access_Conversions;

package Control_Bindings is
  
  type Controls is (Joystick, Keyboard);
  type Controls_Joystick is (Axis_Press, Axis_Release, Press, Release);
  type Controls_Axis_Dir is (High, Deadzone, Low);
  type Controls_Joystick_Data (J : Controls_Joystick) is record
    case J is
      when Axis_Press | Axis_Release =>
        axis_num : int;
        stick_num : int;
        direction : Controls_Axis_Dir;
      when Press | Release =>
        button : int;
    end case;
  end record;
  type Controls_Keyboard is (Press, Release);
  type Controls_Keyboard_Data is record
    state : Controls_Keyboard;
    key : int;
  end record;
  type Event_Input (C : Controls) is record
    case C is
      when Joystick =>
        joy_data : access Controls_Joystick_Data;
      when Keyboard =>
        key_data : Controls_Keyboard_Data;
    end case;
  end record;
  
  type Opt_Joy is (No_Joy, Joy);
  type Opt_Joy_Handle (J : Opt_Joy) is record
    case J is
      when No_Joy =>
        null;
      when Joy =>
        handle : access ALLEGRO_JOYSTICK;
    end case;
  end record;
  
  type Game_Input is (Up_Press, Down_Press, Left_Press, Right_Press, Attack_1_Press, Attack_2_Press, Attack_3_Press, Attack_4_Press, Attack_5_Press, Attack_6_Press, Start_Press, Up_Release, Down_Release, Left_Release, Right_Release, Attack_1_Release, Attack_2_Release, Attack_3_Release, Attack_4_Release, Attack_5_Release, Attack_6_Release, Start_Release);
  type Input_Translation is record
    ev : access Event_Input;
    gi : Game_Input;
  end record;
  type Game_Input_Translations is array(Natural range <>) of Input_Translation;
  type StickDirUpDown is (Neither, Up, Down);
  type StickDirLeftRight is (Neither, Left, Right);
  type Game_Input_State is record
    LastDirUpDown : StickDirUpDown;
    LastDirLeftRight : StickDirLeftRight;
    CurDirUpDown : StickDirUpDown;
    CurDirLeftRight : StickDirLeftRight;
    translations : access Game_Input_Translations;
    optional_joystick_handle : access Opt_Joy_Handle;
  end record;
  
  package Joy_Access_Conversions is new System.Address_To_Access_Conversions(ALLEGRO_JOYSTICK);
  
  deadzone_radius : constant Float := 0.2;
  
  default_keyboard_translation : constant access Game_Input_Translations := new Game_Input_Translations'(
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Press, key => 23)), gi => Up_Press),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Press, key => 19)), gi => Down_Press),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Press, key => 1)), gi => Left_Press),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Press, key => 4)), gi => Right_Press),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Press, key => 21)), gi => Attack_1_Press),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Press, key => 9)), gi => Attack_2_Press),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Press, key => 15)), gi => Attack_3_Press),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Press, key => 10)), gi => Attack_4_Press),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Press, key => 11)), gi => Attack_5_Press),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Press, key => 12)), gi => Attack_6_Press),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Press, key => 67)), gi => Start_Press),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Release, key => 23)), gi => Up_Release),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Release, key => 19)), gi => Down_Release),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Release, key => 1)), gi => Left_Release),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Release, key => 4)), gi => Right_Release),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Release, key => 21)), gi => Attack_1_Release),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Release, key => 9)), gi => Attack_2_Release),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Release, key => 15)), gi => Attack_3_Release),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Release, key => 10)), gi => Attack_4_Release),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Release, key => 11)), gi => Attack_5_Release),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Release, key => 12)), gi => Attack_6_Release),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(state => Release, key => 67)), gi => Start_Release)
  );
  default_joystick_translation : constant access Game_Input_Translations := new Game_Input_Translations'(
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Axis_Press, axis_num => 1, stick_num => 0, direction => Low)), gi => Up_Press),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Axis_Press, axis_num => 1, stick_num => 0, direction => High)), gi => Down_Press),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Axis_Press, axis_num => 0, stick_num => 0, direction => Low)), gi => Left_Press),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Axis_Press, axis_num => 0, stick_num => 0, direction => High)), gi => Right_Press),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Press, button => 1)), gi => Attack_1_Press),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Press, button => 2)), gi => Attack_2_Press),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Press, button => 3)), gi => Attack_3_Press),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Press, button => 4)), gi => Attack_4_Press),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Press, button => 5)), gi => Attack_5_Press),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Press, button => 6)), gi => Attack_6_Press),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Press, button => 7)), gi => Start_Press),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Axis_Release, axis_num => 1, stick_num => 0, direction => Low)), gi => Up_Release),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Axis_Release, axis_num => 1, stick_num => 0, direction => High)), gi => Down_Release),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Axis_Release, axis_num => 0, stick_num => 0, direction => Low)), gi => Left_Release),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Axis_Release, axis_num => 0, stick_num => 0, direction => High)), gi => Right_Release),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Release, button => 1)), gi => Attack_1_Release),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Release, button => 2)), gi => Attack_2_Release),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Release, button => 3)), gi => Attack_3_Release),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Release, button => 4)), gi => Attack_4_Release),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Release, button => 5)), gi => Attack_5_Release),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Release, button => 6)), gi => Attack_6_Release),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Release, button => 7)), gi => Start_Release)
  );
  
  function Event_Input_Matches (Ev : access ALLEGRO_EVENT; InpEv : access Event_Input) return Boolean;
  
  function Input_Recognized (Ev : access ALLEGRO_EVENT; GIS : in out Game_Input_State; GI : Game_Input) return Boolean;

  procedure Refresh_Cur_Direction (GIS : in out Game_Input_State; Ev : access ALLEGRO_EVENT);
  
  procedure Refresh_Last_Direction (GIS : in out Game_Input_State);
  
end Control_Bindings;

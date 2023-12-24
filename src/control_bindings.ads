with allegro5_events_h; use allegro5_events_h;
with Interfaces.C; use Interfaces.C;
with System; use System;
with System.Address_To_Access_Conversions;

package Control_Bindings is
  
  type Controls is (Joystick, Keyboard);
  type Controls_Joystick is (Axis, Button);
  type Controls_Joystick_Data (J : Controls_Joystick) is record
    case J is
      when Axis =>
        axis_num : int;
        stick_num : int;
        min : Float;
        max : Float;
      when Button =>
        button : int;
    end case;
  end record;
  type Controls_Keyboard_Data is record
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
  type Opt_Joy_Handle_Access is access Opt_Joy_Handle;
  
  max_stick : constant Natural := 16;
  max_axis : constant Natural := 3;
  
  type Stick_Axis_Values is array(0 .. max_stick, 0 .. max_axis) of Float;
  
  type Game_Input is (Up_Press, Down_Press, Left_Press, Right_Press, Attack_1_Press, Attack_2_Press, Attack_3_Press, Attack_4_Press, Attack_5_Press, Attack_6_Press, Start_Press, Up_Release, Down_Release, Left_Release, Right_Release, Attack_1_Release, Attack_2_Release, Attack_3_Release, Attack_4_Release, Attack_5_Release, Attack_6_Release, Start_Release);
  subtype GI_Press is Game_Input range Up_Press .. Start_Press;
  subtype GI_Release is Game_Input range Up_Release .. Start_Release;
  
  type Input_Translation is record
    ev : access Event_Input;
    gi : GI_Press;
  end record;
  type Game_Input_Translations is array(Natural range <>) of Input_Translation;
  type StickDirUpDown is (Neither, Up, Down);
  type StickDirLeftRight is (Neither, Left, Right);
  type Game_Input_State is record
    last : Stick_Axis_Values := (others => (others => 0.0));
    cur : Stick_Axis_Values := (others => (others => 0.0));
    translations : access Game_Input_Translations;
    optional_joystick_handle : Opt_Joy_Handle_Access;
  end record;
  
  package Joy_Access_Conversions is new System.Address_To_Access_Conversions(ALLEGRO_JOYSTICK);
  
  default_joystick_axis_min : constant Float := 0.3;
  default_joystick_axis_max : constant Float := 1.0;
  
  default_trigger_axis_min : constant Float := -0.2;
  default_trigger_axis_max : constant Float := 1.0;
  
  default_keyboard_translation : constant access Game_Input_Translations := new Game_Input_Translations'(
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(key => 23)), gi => Up_Press),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(key => 19)), gi => Down_Press),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(key => 1)), gi => Left_Press),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(key => 4)), gi => Right_Press),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(key => 21)), gi => Attack_1_Press),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(key => 9)), gi => Attack_2_Press),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(key => 15)), gi => Attack_3_Press),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(key => 10)), gi => Attack_4_Press),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(key => 11)), gi => Attack_5_Press),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(key => 12)), gi => Attack_6_Press),
    Input_Translation'(ev => new Event_Input'(C => Keyboard, key_data => Controls_Keyboard_Data'(key => 67)), gi => Start_Press)
  );
  
  default_joystick_translation : constant access Game_Input_Translations := new Game_Input_Translations'(
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Axis, axis_num => 1, stick_num => 0, min => -default_joystick_axis_min, max => -default_joystick_axis_max)), gi => Up_Press),-- Left Stick directions
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Axis, axis_num => 1, stick_num => 0, min => default_joystick_axis_min, max => default_joystick_axis_max)), gi => Down_Press),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Axis, axis_num => 0, stick_num => 0, min => -default_joystick_axis_min, max => -default_joystick_axis_max)), gi => Left_Press),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Axis, axis_num => 0, stick_num => 0, min => default_joystick_axis_min, max => default_joystick_axis_max)), gi => Right_Press),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Axis, axis_num => 1, stick_num => 3, min => -default_joystick_axis_min, max => -default_joystick_axis_max)), gi => Up_Press),-- DPad directions
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Axis, axis_num => 1, stick_num => 3, min => default_joystick_axis_min, max => default_joystick_axis_max)), gi => Down_Press),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Axis, axis_num => 0, stick_num => 3, min => -default_joystick_axis_min, max => -default_joystick_axis_max)), gi => Left_Press),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Axis, axis_num => 0, stick_num => 3, min => default_joystick_axis_min, max => default_joystick_axis_max)), gi => Right_Press),
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Button, button => 2)), gi => Attack_1_Press),-- X button
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Button, button => 3)), gi => Attack_2_Press),-- Y button
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Button, button => 5)), gi => Attack_3_Press),-- RB button
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Button, button => 0)), gi => Attack_4_Press),-- A button
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Button, button => 1)), gi => Attack_5_Press),-- B button
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Axis, axis_num => 1, stick_num => 2, min => default_trigger_axis_min, max => default_trigger_axis_max)), gi => Attack_6_Press),-- RT
    Input_Translation'(ev => new Event_Input'(C => Joystick, joy_data => new Controls_Joystick_Data'(J => Button, button => 7)), gi => Start_Press)-- Start button
  );
  
  function Input_Recognized (Ev : access ALLEGRO_EVENT; GIS : Game_Input_State; GI : Game_Input) return Boolean;

  procedure Refresh_Cur_Direction (GIS : in out Game_Input_State; Ev : access ALLEGRO_EVENT);
  
  procedure Refresh_Last_Direction (GIS : in out Game_Input_State);
  
end Control_Bindings;

with Globals; use Globals;

package Control_Bindings_Controller_Defaults is
  default_joystick : constant access Game_Input_Translations := new Game_Input_Translations'(
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
end Control_Bindings_Controller_Defaults;

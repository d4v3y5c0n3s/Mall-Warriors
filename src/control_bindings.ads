with allegro5_events_h; use allegro5_events_h;
with Interfaces.C; use Interfaces.C;
with System; use System;
with System.Address_To_Access_Conversions;
with Control_Bindings_Controller_Defaults; use Control_Bindings_Controller_Defaults;
with Globals; use Globals;

package Control_Bindings is
  
  package Joy_Access_Conversions is new System.Address_To_Access_Conversions(ALLEGRO_JOYSTICK);
  
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
  
  default_joystick_translation : constant access Game_Input_Translations := default_joystick;
  
  function Input_Recognized (Ev : access ALLEGRO_EVENT; GIS : Game_Input_State; GI : Game_Input) return Boolean;

  procedure Refresh_Cur_Direction (GIS : in out Game_Input_State; Ev : access ALLEGRO_EVENT);
  
  procedure Refresh_Last_Direction (GIS : in out Game_Input_State);
  
  subtype GI_Press_No_Start is GI_Press range Up_Press .. Attack_6_Press;
  type Input_Snapshot is array(GI_Press_No_Start) of Boolean;
  
  function Snapshot_Input (GIS : Game_Input_State) return Input_Snapshot;
  
  function Input_Recognized_Since_Snapshot (old_snapshot : Input_Snapshot; new_snapshot : Input_Snapshot; GI : Game_Input) return Boolean;
  
end Control_Bindings;

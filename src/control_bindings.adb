with allegro5_keyboard_h; use allegro5_keyboard_h;
with allegro5_joystick_h; use allegro5_joystick_h;

package body Control_Bindings is

  function Value_In_Range (Value : Float; Min : Float; Max : Float) return Boolean is
  begin
    return (Value in Max .. Min) or (Value in Min .. Max);
  end Value_In_Range;
  
  function GI_opposites (GI_1 : Game_Input; GI_2 : Game_Input) return Boolean is
    subtype GI_Up is Game_Input with Static_Predicate => GI_Up in Up_Press | Up_Release;
    subtype GI_Down is Game_Input with Static_Predicate => GI_Down in Down_Press | Down_Release;
    subtype GI_Left is Game_Input with Static_Predicate => GI_Left in Left_Press | Left_Release;
    subtype GI_Right is Game_Input with Static_Predicate => GI_Right in Right_Press | Right_Release;
    subtype GI_Attack_1 is Game_Input with Static_Predicate => GI_Attack_1 in Attack_1_Press | Attack_1_Release;
    subtype GI_Attack_2 is Game_Input with Static_Predicate => GI_Attack_2 in Attack_2_Press | Attack_2_Release;
    subtype GI_Attack_3 is Game_Input with Static_Predicate => GI_Attack_3 in Attack_3_Press | Attack_3_Release;
    subtype GI_Attack_4 is Game_Input with Static_Predicate => GI_Attack_4 in Attack_4_Press | Attack_4_Release;
    subtype GI_Attack_5 is Game_Input with Static_Predicate => GI_Attack_5 in Attack_5_Press | Attack_5_Release;
    subtype GI_Attack_6 is Game_Input with Static_Predicate => GI_Attack_6 in Attack_6_Press | Attack_6_Release;
    subtype GI_Start is Game_Input with Static_Predicate => GI_Start in Start_Press | Start_Release;
    
    Have_Press_And_Release : constant Boolean := (GI_1 in GI_Press and GI_2 in GI_Release) or (GI_1 in GI_Release and GI_2 in GI_Press);
    
    Corresponding_Inputs : constant Boolean := (GI_1 in GI_Up and GI_2 in GI_Up) or (GI_1 in GI_Down and GI_2 in GI_Down) or (GI_1 in GI_Left and GI_2 in GI_Left) or (GI_1 in GI_Right and GI_2 in GI_Right) or (GI_1 in GI_Attack_1 and GI_2 in GI_Attack_1) or (GI_1 in GI_Attack_2 and GI_2 in GI_Attack_2) or (GI_1 in GI_Attack_3 and GI_2 in GI_Attack_3) or (GI_1 in GI_Attack_4 and GI_2 in GI_Attack_4) or (GI_1 in GI_Attack_5 and GI_2 in GI_Attack_5) or (GI_1 in GI_Attack_6 and GI_2 in GI_Attack_6) or (GI_1 in GI_Start and GI_2 in GI_Start);
    
  begin
    if Have_Press_And_Release and Corresponding_Inputs then
      return true;
    else
      return false;
    end if;
  end GI_opposites;
  
  function Input_Recognized (Ev : access ALLEGRO_EVENT; GIS : Game_Input_State; GI : Game_Input) return Boolean is
    recognized : Boolean := false;
    
    function Joystick_Handle_Matches (Ev : access ALLEGRO_EVENT) return Boolean is
    begin
      if (Ev.c_type = 1 or Ev.c_type = 2 or Ev.c_type = 3) and GIS.optional_joystick_handle.J = Joy then
        if Joy_Access_Conversions.To_Address(Ev.joystick.id) = Joy_Access_Conversions.To_Address(GIS.optional_joystick_handle.handle) then
          return true;
        else
          return false;
        end if;
      else
        return true;
      end if;
    end Joystick_Handle_Matches;
    
    function Event_Input_Matches (Ev : access ALLEGRO_EVENT; InpEv : access Event_Input; Cur_GI : Game_Input) return Boolean is
      matches : Boolean := false;
    begin
      if InpEv.C = Joystick then
        case Ev.c_type is
          when 1 =>-- joystick axis
            if InpEv.joy_data.J = Axis then
              if InpEv.joy_data.axis_num = Ev.joystick.axis and InpEv.joy_data.stick_num = Ev.joystick.stick then
                if GI = Cur_GI then
                  matches := Value_In_Range(Ev.joystick.pos, InpEv.joy_data.min, InpEv.joy_data.max);
                elsif GI_opposites(GI, Cur_GI) then
                  matches := not Value_In_Range(Ev.joystick.pos, InpEv.joy_data.min, InpEv.joy_data.max);
                end if;
              end if;
            end if;
          when 2 =>-- joystick button down
            if InpEv.joy_data.J = Button then
              if InpEv.joy_data.button = Ev.joystick.button and GI = Cur_GI then
                matches := true;
              end if;
            end if;
          when 3 =>-- joystick button up
            if InpEv.joy_data.J = Button then
              if InpEv.joy_data.button = Ev.joystick.button and GI_opposites(GI, Cur_GI) then
                matches := true;
              end if;
            end if;
          when others =>
            null;
        end case;
      else
        case Ev.c_type is
          when 10 =>-- key down
            if InpEv.key_data.key = Ev.keyboard.keycode and GI = Cur_GI then
              matches := true;
            end if;
          when 12 =>-- key up
            if InpEv.key_data.key = Ev.keyboard.keycode and GI_opposites(GI, Cur_GI) then
              matches := true;
            end if;
          when others =>
            null;
        end case;
      end if;
      
      return matches;
    end Event_Input_Matches;
    
  begin
    for translation of GIS.translations.all loop
      if Event_Input_Matches(Ev, translation.ev, translation.gi) and Joystick_Handle_Matches(Ev) then
        recognized := true;
        
        if translation.ev.C = Joystick then
          if translation.ev.joy_data.J = Axis then
            Check_Cur_With_Last:
              declare
                
                function Cur_In_Range_Of_Last (JDMin : Float; JDMax : Float) return Boolean is
                  subtype Joy_Data_Range is Float range JDMin .. JDMax;
                begin
                  return GIS.last(Integer(translation.ev.joy_data.stick_num), Integer(translation.ev.joy_data.axis_num)) in Joy_Data_Range and GIS.cur(Integer(translation.ev.joy_data.stick_num), Integer(translation.ev.joy_data.axis_num)) in Joy_Data_Range;
                end Cur_In_Range_Of_Last;
              begin
                if Cur_In_Range_Of_Last(translation.ev.joy_data.min, translation.ev.joy_data.max) or Cur_In_Range_Of_Last(translation.ev.joy_data.max, translation.ev.joy_data.min) then
                  recognized := false;
                end if;
              end Check_Cur_With_Last;
          end if;
        end if;
      end if;
      
      exit when recognized;
    end loop;
    
    return recognized;
  end Input_Recognized;
  
  procedure Refresh_Cur_Direction (GIS : in out Game_Input_State; Ev : access ALLEGRO_EVENT) is
  begin
    if Ev.c_type = 1 then-- joystick axis event type
      GIS.cur(Integer(Ev.joystick.stick), Integer(Ev.joystick.axis)) := Ev.joystick.pos;
    end if;
  end Refresh_Cur_Direction;

  procedure Refresh_Last_Direction (GIS : in out Game_Input_State) is
  begin
    for S in GIS.cur'Range(1) loop
      for A in GIS.cur'Range(2) loop
        GIS.last(S, A) := GIS.cur(S, A);
      end loop;
    end loop;
  end Refresh_Last_Direction;
  
  function Snapshot_Input (GIS : Game_Input_State) return Input_Snapshot is
    type Optional_Keyboard_State (HasState : Boolean) is record
      case HasState is
        when true =>
          kbs : access ALLEGRO_KEYBOARD_STATE;
        when false =>
          null;
      end case;
    end record;
    type Optional_Joystick_State (HasState : Boolean) is record
      case HasState is
        when true =>
          jss : access ALLEGRO_JOYSTICK_STATE;
        when false =>
          null;
      end case;
    end record;
    
    base_kbs : access ALLEGRO_KEYBOARD_STATE := new ALLEGRO_KEYBOARD_STATE;
    base_jss : access ALLEGRO_JOYSTICK_STATE := new ALLEGRO_JOYSTICK_STATE;
    
    opt_kbs : access Optional_Keyboard_State;
    opt_jss : access Optional_Joystick_State;
    
    ret : Input_Snapshot := Input_Snapshot'(others => false);
    
    function joystick_tranlation_down (tr : Input_Translation) return Boolean is
    begin
      if tr.ev.C = Joystick and opt_jss.HasState then
        case tr.ev.joy_data.J is
          when Axis =>
            return Value_In_Range(opt_jss.jss.stick(Integer(tr.ev.joy_data.stick_num)).axis(Integer(tr.ev.joy_data.axis_num)), tr.ev.joy_data.min, tr.ev.joy_data.max);
          when Button =>
            return (if 0 = opt_jss.jss.button(Integer(tr.ev.joy_data.button)) then false else true);
        end case;
      else
        return false;
      end if;
    end joystick_tranlation_down;
  begin
    
    if GIS.optional_joystick_handle.J = Joy then
      al_get_joystick_state(GIS.optional_joystick_handle.handle, base_jss);
      opt_kbs := new Optional_Keyboard_State'(HasState => false);
      opt_jss := new Optional_Joystick_State'(HasState => true, jss => base_jss);
    else
      al_get_keyboard_state(base_kbs);
      opt_kbs := new Optional_Keyboard_State'(HasState => true, kbs => base_kbs);
      opt_jss := new Optional_Joystick_State'(HasState => false);
    end if;
    
    for translation of GIS.translations.all loop
      case translation.ev.C is
        when Joystick =>
          if opt_jss.HasState then
            if joystick_tranlation_down(translation) and translation.gi /= Start_Press then
              ret(GI_Press_No_Start'(translation.gi)) := true;
            end if;
          end if;
        when Keyboard =>
          if opt_kbs.HasState then
            if Boolean(al_key_down(opt_kbs.kbs, translation.ev.key_data.key)) and translation.gi /= Start_Press then
              ret(GI_Press_No_Start'(translation.gi)) := true;
            end if;
          end if;
      end case;
    end loop;
    
    return ret;
  end Snapshot_Input;
  
  function Input_Recognized_Since_Snapshot (old_snapshot : Input_Snapshot; new_snapshot : Input_Snapshot; GI : Game_Input) return Boolean is
  begin
    if GI /= Start_Press and GI /= Start_Release then
      if GI in GI_Release then
        Index_With_Press_Input:
          declare
            press_form : GI_Press := GI_Press'Val(GI_Release'Pos(GI) - GI_Press'Pos(GI_Release'First));
          begin
            return old_snapshot(GI_Press_No_Start'(press_form)) and not(new_snapshot(GI_Press_No_Start'(press_form)));
          end Index_With_Press_Input;
      else
        return not(old_snapshot(GI_Press_No_Start'(GI))) and new_snapshot(GI_Press_No_Start'(GI));
      end if;
    end if;
    return false;
  end Input_Recognized_Since_Snapshot;
  
end Control_Bindings;

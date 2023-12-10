package body Control_Bindings is
  
  function To_Axis_Dir (value : Float) return Controls_Axis_Dir is
  begin
    if value > deadzone_radius then
      return High;
    elsif value < (-deadzone_radius) then
      return Low;
    else
      return Deadzone;
    end if;
  end To_Axis_Dir;
  
  function Event_Input_Matches (Ev : access ALLEGRO_EVENT; InpEv : access Event_Input) return Boolean is
    matches : Boolean := false;
  begin
    if InpEv.C = Joystick then
      case Ev.c_type is
        when 1 =>-- joystick axis
          if InpEv.joy_data.J = Axis_Press then
            if InpEv.joy_data.axis_num = Ev.joystick.axis and InpEv.joy_data.stick_num = Ev.joystick.stick and InpEv.joy_data.direction = To_Axis_Dir(Ev.joystick.pos) then
              matches := true;
            end if;
          elsif InpEv.joy_data.J = Axis_Release then
            if InpEv.joy_data.axis_num = Ev.joystick.axis and InpEv.joy_data.stick_num = Ev.joystick.stick and InpEv.joy_data.direction /= To_Axis_Dir(Ev.joystick.pos) then
              matches := true;
            end if;
          end if;
        when 2 =>-- joystick button down
          if InpEv.joy_data.J = Press and InpEv.joy_data.button = Ev.joystick.button then
            matches := true;
          end if;
        when 3 =>-- joystick button up
          if InpEv.joy_data.J = Release and InpEv.joy_data.button = Ev.joystick.button then
            matches := true;
          end if;
        when others =>
          null;
      end case;
    else
      case Ev.c_type is
        when 10 =>-- key down
          if InpEv.key_data.state = Press and InpEv.key_data.key = Ev.keyboard.keycode then
            matches := true;
          end if;
        when 12 =>-- key up
          if InpEv.key_data.state = Release and InpEv.key_data.key = Ev.keyboard.keycode then
            matches := true;
          end if;
        when others =>
          null;
      end case;
    end if;
    
    return matches;
  end Event_Input_Matches;
  
  function Input_Recognized (Ev : access ALLEGRO_EVENT; GIS : in out Game_Input_State; GI : Game_Input) return Boolean is
    recognized : Boolean := false;
    
    function If_Joystick_Matches_Handle (Ev : access ALLEGRO_EVENT) return Boolean is
    begin
      if (Ev.c_type = 1 or Ev.c_type = 2 or Ev.c_type = 3) and GIS.optional_joystick_handle.J = Joy then
        if Joy_Access_Conversions.To_Address(Ev.joystick.source) = Joy_Access_Conversions.To_Address(GIS.optional_joystick_handle.handle) then
          return true;
        else
          return false;
        end if;
      else
        return true;
      end if;
    end If_Joystick_Matches_Handle;
    
  begin
    for translation of GIS.translations.all loop
      if Event_Input_Matches(Ev, translation.ev) and translation.gi = GI and If_Joystick_Matches_Handle(Ev) then
        recognized := true;
        
        if translation.ev.C = Joystick then
          if translation.ev.joy_data.J = Axis_Press or translation.ev.joy_data.J = Axis_Release then
            if translation.ev.joy_data.axis_num = 0 then
              if GIS.CurDirLeftRight = GIS.LastDirLeftRight then
                recognized := false;
              end if;
            elsif translation.ev.joy_data.axis_num = 1 then
              if GIS.CurDirUpDown = GIS.LastDirUpDown then
                recognized := false;
              end if;
            end if;
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
      if Ev.joystick.axis = 0 then
        case To_Axis_Dir(Ev.joystick.pos) is
          when High =>
            GIS.CurDirLeftRight := Right;
          when Low =>
            GIS.CurDirLeftRight := Left;
          when Deadzone =>
            GIS.CurDirLeftRight := Neither;
        end case;
      elsif Ev.joystick.axis = 1 then
        case To_Axis_Dir(Ev.joystick.pos) is
          when High =>
            GIS.CurDirUpDown := Down;
          when Low =>
            GIS.CurDirUpDown := Up;
          when Deadzone =>
            GIS.CurDirUpDown := Neither;
        end case;
      end if;
    end if;
  end Refresh_Cur_Direction;

  procedure Refresh_Last_Direction (GIS : in out Game_Input_State) is
  begin
    GIS.LastDirUpDown := GIS.CurDirUpDown;
    GIS.LastDirLeftRight := GIS.CurDirLeftRight;
  end Refresh_Last_Direction;
  
end Control_Bindings;

pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Extensions;
with Interfaces.C.Strings;
limited with allegro5_events_h;

package allegro5_joystick_h is

  --         ______   ___    ___
  -- *        /\  _  \ /\_ \  /\_  *        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
  --_
  -- *         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __` *          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\  *           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
  --__/
  -- *            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
  -- *                                           /\____/
  -- *                                           \_/__/
  -- *
  -- *      Joystick routines.
  -- *
  -- *      See readme.txt for copyright information.
  --  

  -- internal values  
  -- Type: ALLEGRO_JOYSTICK
  --  

     -- Type: ALLEGRO_JOYSTICK_STATE
  --  

   type ALLEGRO_JOYSTICK_STATE;
  -- -1.0 to 1.0  
   type anon2184_array2187 is array (0 .. 2) of aliased float;
   type anon2184_struct2186 is record
      axis : aliased anon2184_array2187;  -- /usr/include/allegro5/joystick.h:46
   end record
   with Convention => C_Pass_By_Copy;
   type anon2184_array2188 is array (0 .. 15) of aliased anon2184_struct2186;
   type anon2184_array1887 is array (0 .. 31) of aliased int;
   type ALLEGRO_JOYSTICK_STATE is record
      stick : aliased anon2184_array2188;  -- /usr/include/allegro5/joystick.h:47
      button : aliased anon2184_array1887;  -- /usr/include/allegro5/joystick.h:48
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/joystick.h:43

  -- 0 to 32767  
  -- Enum: ALLEGRO_JOYFLAGS
  --  

   subtype ALLEGRO_JOYFLAGS is unsigned;
   ALLEGRO_JOYFLAG_DIGITAL : constant unsigned := 1;
   ALLEGRO_JOYFLAG_ANALOGUE : constant unsigned := 2;  -- /usr/include/allegro5/joystick.h:54

   function al_install_joystick return Extensions.bool  -- /usr/include/allegro5/joystick.h:62
   with Import => True, 
        Convention => C, 
        External_Name => "al_install_joystick";

   procedure al_uninstall_joystick  -- /usr/include/allegro5/joystick.h:63
   with Import => True, 
        Convention => C, 
        External_Name => "al_uninstall_joystick";

   function al_is_joystick_installed return Extensions.bool  -- /usr/include/allegro5/joystick.h:64
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_joystick_installed";

   function al_reconfigure_joysticks return Extensions.bool  -- /usr/include/allegro5/joystick.h:65
   with Import => True, 
        Convention => C, 
        External_Name => "al_reconfigure_joysticks";

   function al_get_num_joysticks return int  -- /usr/include/allegro5/joystick.h:67
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_num_joysticks";

   function al_get_joystick (joyn : int) return access ALLEGRO_JOYSTICK  -- /usr/include/allegro5/joystick.h:68
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_joystick";

   procedure al_release_joystick (arg1 : access ALLEGRO_JOYSTICK)  -- /usr/include/allegro5/joystick.h:69
   with Import => True, 
        Convention => C, 
        External_Name => "al_release_joystick";

   function al_get_joystick_active (arg1 : access ALLEGRO_JOYSTICK) return Extensions.bool  -- /usr/include/allegro5/joystick.h:70
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_joystick_active";

   function al_get_joystick_name (arg1 : access ALLEGRO_JOYSTICK) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/joystick.h:71
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_joystick_name";

   function al_get_joystick_num_sticks (arg1 : access ALLEGRO_JOYSTICK) return int  -- /usr/include/allegro5/joystick.h:73
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_joystick_num_sticks";

  -- junk?  
   function al_get_joystick_stick_flags (arg1 : access ALLEGRO_JOYSTICK; stick : int) return int  -- /usr/include/allegro5/joystick.h:74
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_joystick_stick_flags";

   function al_get_joystick_stick_name (arg1 : access ALLEGRO_JOYSTICK; stick : int) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/joystick.h:75
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_joystick_stick_name";

   function al_get_joystick_num_axes (arg1 : access ALLEGRO_JOYSTICK; stick : int) return int  -- /usr/include/allegro5/joystick.h:77
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_joystick_num_axes";

   function al_get_joystick_axis_name
     (arg1 : access ALLEGRO_JOYSTICK;
      stick : int;
      axis : int) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/joystick.h:78
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_joystick_axis_name";

   function al_get_joystick_num_buttons (arg1 : access ALLEGRO_JOYSTICK) return int  -- /usr/include/allegro5/joystick.h:80
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_joystick_num_buttons";

   function al_get_joystick_button_name (arg1 : access ALLEGRO_JOYSTICK; buttonn : int) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/joystick.h:81
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_joystick_button_name";

   procedure al_get_joystick_state (arg1 : access ALLEGRO_JOYSTICK; ret_state : access ALLEGRO_JOYSTICK_STATE)  -- /usr/include/allegro5/joystick.h:83
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_joystick_state";

   function al_get_joystick_event_source return access allegro5_events_h.ALLEGRO_EVENT_SOURCE  -- /usr/include/allegro5/joystick.h:85
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_joystick_event_source";

end allegro5_joystick_h;

pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
limited with allegro5_events_h;
with Interfaces.C.Extensions;
with Interfaces.C.Strings;

package allegro5_keyboard_h is

  --         ______   ___    ___
  -- *        /\  _  \ /\_ \  /\_  *        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
  --_
  -- *         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __` *          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\  *           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
  --__/
  -- *            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
  -- *                                           /\____/
  -- *                                           \_/__/
  -- *
  -- *      Keyboard routines.
  -- *
  -- *      See readme.txt for copyright information.
  --  

     -- Type: ALLEGRO_KEYBOARD_STATE
  --  

   type ALLEGRO_KEYBOARD_STATE;
  -- public  
   type anon2216_array2218 is array (0 .. 7) of aliased unsigned;
   type ALLEGRO_KEYBOARD_STATE is record
      display : access allegro5_events_h.ALLEGRO_DISPLAY;  -- /usr/include/allegro5/keyboard.h:37
      uu_key_down_u_internal_u_u : aliased anon2216_array2218;  -- /usr/include/allegro5/keyboard.h:39
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/keyboard.h:35

  -- internal  
   function al_is_keyboard_installed return Extensions.bool  -- /usr/include/allegro5/keyboard.h:43
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_keyboard_installed";

   function al_install_keyboard return Extensions.bool  -- /usr/include/allegro5/keyboard.h:44
   with Import => True, 
        Convention => C, 
        External_Name => "al_install_keyboard";

   procedure al_uninstall_keyboard  -- /usr/include/allegro5/keyboard.h:45
   with Import => True, 
        Convention => C, 
        External_Name => "al_uninstall_keyboard";

   function al_set_keyboard_leds (leds : int) return Extensions.bool  -- /usr/include/allegro5/keyboard.h:47
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_keyboard_leds";

   function al_keycode_to_name (keycode : int) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/keyboard.h:49
   with Import => True, 
        Convention => C, 
        External_Name => "al_keycode_to_name";

   procedure al_get_keyboard_state (ret_state : access ALLEGRO_KEYBOARD_STATE)  -- /usr/include/allegro5/keyboard.h:51
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_keyboard_state";

   function al_key_down (arg1 : access constant ALLEGRO_KEYBOARD_STATE; keycode : int) return Extensions.bool  -- /usr/include/allegro5/keyboard.h:55
   with Import => True, 
        Convention => C, 
        External_Name => "al_key_down";

   function al_get_keyboard_event_source return access allegro5_events_h.ALLEGRO_EVENT_SOURCE  -- /usr/include/allegro5/keyboard.h:57
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_keyboard_event_source";

  -- * Local Variables:
  -- * c-basic-offset: 3
  -- * indent-tabs-mode: nil
  -- * End:
  --  

end allegro5_keyboard_h;

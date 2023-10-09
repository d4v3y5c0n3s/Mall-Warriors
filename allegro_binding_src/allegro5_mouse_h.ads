pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
limited with allegro5_events_h;
with Interfaces.C.Extensions;

package allegro5_mouse_h is

   ALLEGRO_MOUSE_MAX_EXTRA_AXES : constant := 4;  --  /usr/include/allegro5/mouse.h:27

  --         ______   ___    ___
  -- *        /\  _  \ /\_ \  /\_  *        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
  --_
  -- *         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __` *          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\  *           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
  --__/
  -- *            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
  -- *                                           /\____/
  -- *                                           \_/__/
  -- *
  -- *      Mouse routines.
  -- *
  -- *      See readme.txt for copyright information.
  --  

  -- Allow up to four extra axes for future expansion.  
     -- Type: ALLEGRO_MOUSE_STATE
  --  

   type ALLEGRO_MOUSE_STATE;
  -- (x, y) Primary mouse position
  --    * (z) Mouse wheel position (1D 'wheel'), or,
  --    * (w, z) Mouse wheel position (2D 'ball')
  --    * display - the display the mouse is on (coordinates are relative to this)
  --    * pressure - the pressure applied to the mouse (for stylus/tablet)
  --     

   type anon2231_array2233 is array (0 .. 3) of aliased int;
   type ALLEGRO_MOUSE_STATE is record
      x : aliased int;  -- /usr/include/allegro5/mouse.h:45
      y : aliased int;  -- /usr/include/allegro5/mouse.h:46
      z : aliased int;  -- /usr/include/allegro5/mouse.h:47
      w : aliased int;  -- /usr/include/allegro5/mouse.h:48
      more_axes : aliased anon2231_array2233;  -- /usr/include/allegro5/mouse.h:49
      buttons : aliased int;  -- /usr/include/allegro5/mouse.h:50
      pressure : aliased float;  -- /usr/include/allegro5/mouse.h:51
      display : access allegro5_events_h.ALLEGRO_DISPLAY;  -- /usr/include/allegro5/mouse.h:52
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/mouse.h:37

   function al_is_mouse_installed return Extensions.bool  -- /usr/include/allegro5/mouse.h:56
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_mouse_installed";

   function al_install_mouse return Extensions.bool  -- /usr/include/allegro5/mouse.h:57
   with Import => True, 
        Convention => C, 
        External_Name => "al_install_mouse";

   procedure al_uninstall_mouse  -- /usr/include/allegro5/mouse.h:58
   with Import => True, 
        Convention => C, 
        External_Name => "al_uninstall_mouse";

   function al_get_mouse_num_buttons return unsigned  -- /usr/include/allegro5/mouse.h:59
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_mouse_num_buttons";

   function al_get_mouse_num_axes return unsigned  -- /usr/include/allegro5/mouse.h:60
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_mouse_num_axes";

   function al_set_mouse_xy
     (display : access allegro5_events_h.ALLEGRO_DISPLAY;
      x : int;
      y : int) return Extensions.bool  -- /usr/include/allegro5/mouse.h:61
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_mouse_xy";

   function al_set_mouse_z (z : int) return Extensions.bool  -- /usr/include/allegro5/mouse.h:62
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_mouse_z";

   function al_set_mouse_w (w : int) return Extensions.bool  -- /usr/include/allegro5/mouse.h:63
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_mouse_w";

   function al_set_mouse_axis (axis : int; value : int) return Extensions.bool  -- /usr/include/allegro5/mouse.h:64
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_mouse_axis";

   procedure al_get_mouse_state (ret_state : access ALLEGRO_MOUSE_STATE)  -- /usr/include/allegro5/mouse.h:65
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_mouse_state";

   function al_mouse_button_down (state : access constant ALLEGRO_MOUSE_STATE; button : int) return Extensions.bool  -- /usr/include/allegro5/mouse.h:66
   with Import => True, 
        Convention => C, 
        External_Name => "al_mouse_button_down";

   function al_get_mouse_state_axis (state : access constant ALLEGRO_MOUSE_STATE; axis : int) return int  -- /usr/include/allegro5/mouse.h:67
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_mouse_state_axis";

   function al_get_mouse_cursor_position (ret_x : access int; ret_y : access int) return Extensions.bool  -- /usr/include/allegro5/mouse.h:68
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_mouse_cursor_position";

   function al_grab_mouse (display : access allegro5_events_h.ALLEGRO_DISPLAY) return Extensions.bool  -- /usr/include/allegro5/mouse.h:69
   with Import => True, 
        Convention => C, 
        External_Name => "al_grab_mouse";

   function al_ungrab_mouse return Extensions.bool  -- /usr/include/allegro5/mouse.h:70
   with Import => True, 
        Convention => C, 
        External_Name => "al_ungrab_mouse";

   procedure al_set_mouse_wheel_precision (precision : int)  -- /usr/include/allegro5/mouse.h:71
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_mouse_wheel_precision";

   function al_get_mouse_wheel_precision return int  -- /usr/include/allegro5/mouse.h:72
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_mouse_wheel_precision";

   function al_get_mouse_event_source return access allegro5_events_h.ALLEGRO_EVENT_SOURCE  -- /usr/include/allegro5/mouse.h:74
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_mouse_event_source";

  -- vim: set sts=3 sw=3 et:  
end allegro5_mouse_h;

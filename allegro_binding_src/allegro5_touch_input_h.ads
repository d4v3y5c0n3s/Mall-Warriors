pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Extensions;
limited with allegro5_events_h;

package allegro5_touch_input_h is

   ALLEGRO_TOUCH_INPUT_MAX_TOUCH_COUNT : constant := 16;  --  /usr/include/allegro5/touch_input.h:29

  --         ______   ___    ___
  -- *        /\  _  \ /\_ \  /\_  *        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
  --_
  -- *         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __` *          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\  *           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
  --__/
  -- *            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
  -- *                                           /\____/
  -- *                                           \_/__/
  -- *
  -- *      Touch input routines.
  -- *
  -- *      See readme.txt for copyright information.
  --  

  -- Enum: ALLEGRO_TOUCH_INPUT_MAX_TOUCH_COUNT
  --  

  -- Type: ALLEGRO_TOUCH_INPUT
  --  

     -- Type: ALLEGRO_TOUCH_INPUT_STATE
  --  

   type ALLEGRO_TOUCH_INPUT_STATE;
  -- Type: ALLEGRO_TOUCH_STATE
  --  

   type ALLEGRO_TOUCH_STATE;
  -- (id) An identifier of touch. If touch is valid this number is positive.
  --    * (x, y) Touch position on the screen in 1:1 resolution.
  --    * (dx, dy) Relative touch position.
  --    * (primary) True, if touch is a primary one (usually first one).
  --    * (display) Display at which the touch belong.
  --     

   type ALLEGRO_TOUCH_STATE is record
      id : aliased int;  -- /usr/include/allegro5/touch_input.h:55
      x : aliased float;  -- /usr/include/allegro5/touch_input.h:56
      y : aliased float;  -- /usr/include/allegro5/touch_input.h:56
      dx : aliased float;  -- /usr/include/allegro5/touch_input.h:57
      dy : aliased float;  -- /usr/include/allegro5/touch_input.h:57
      primary : aliased Extensions.bool;  -- /usr/include/allegro5/touch_input.h:58
      display : access allegro5_events_h.ALLEGRO_DISPLAY;  -- /usr/include/allegro5/touch_input.h:59
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/touch_input.h:47

   type anon2249_array2253 is array (0 .. 15) of aliased ALLEGRO_TOUCH_STATE;
   type ALLEGRO_TOUCH_INPUT_STATE is record
      touches : aliased anon2249_array2253;  -- /usr/include/allegro5/touch_input.h:64
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/touch_input.h:62

  -- Enum: ALLEGRO_MOUSE_EMULATION_MODE
  --  

   function al_is_touch_input_installed return Extensions.bool  -- /usr/include/allegro5/touch_input.h:82
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_touch_input_installed";

   function al_install_touch_input return Extensions.bool  -- /usr/include/allegro5/touch_input.h:83
   with Import => True, 
        Convention => C, 
        External_Name => "al_install_touch_input";

   procedure al_uninstall_touch_input  -- /usr/include/allegro5/touch_input.h:84
   with Import => True, 
        Convention => C, 
        External_Name => "al_uninstall_touch_input";

   procedure al_get_touch_input_state (ret_state : access ALLEGRO_TOUCH_INPUT_STATE)  -- /usr/include/allegro5/touch_input.h:85
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_touch_input_state";

   function al_get_touch_input_event_source return access allegro5_events_h.ALLEGRO_EVENT_SOURCE  -- /usr/include/allegro5/touch_input.h:86
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_touch_input_event_source";

end allegro5_touch_input_h;

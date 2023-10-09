pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Extensions;
with x86_64_linux_gnu_bits_stdint_intn_h;
with unistd_h;
limited with allegro5_altime_h;

package allegro5_events_h is

   --  arg-macro: function ALLEGRO_EVENT_TYPE_IS_USER (t)
   --    return (t) >= 512;
   --  arg-macro: procedure ALLEGRO_GET_EVENT_TYPE (a, b, c, d)
   --    AL_ID(a, b, c, d)
  -- Type: ALLEGRO_EVENT_TYPE
  --  

   subtype ALLEGRO_EVENT_TYPE is unsigned;  -- /usr/include/allegro5/events.h:13

  -- Function: ALLEGRO_EVENT_TYPE_IS_USER
  -- *
  -- *    1 <= n < 512  - builtin events
  -- *  512 <= n < 1024 - reserved user events (for addons)
  -- * 1024 <= n        - unreserved user events
  --  

  -- Function: ALLEGRO_GET_EVENT_TYPE
  --  

  -- Type: ALLEGRO_EVENT_SOURCE
  --  

   type ALLEGRO_EVENT_SOURCE;
   type anon1885_array1887 is array (0 .. 31) of aliased int;
   type ALLEGRO_EVENT_SOURCE is record
      uu_pad : aliased anon1885_array1887;  -- /usr/include/allegro5/events.h:76
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/events.h:74

  -- * Event structures
  -- *
  -- * All event types have the following fields in common.
  -- *
  -- *  type      -- the type of event this is
  -- *  timestamp -- when this event was generated
  -- *  source    -- which event source generated this event
  -- *
  -- * For people writing event sources: The common fields must be at the
  -- * very start of each event structure, i.e. put _AL_EVENT_HEADER at the
  -- * front.
  --  

   type ALLEGRO_ANY_EVENT is record
      c_type : aliased ALLEGRO_EVENT_TYPE;  -- /usr/include/allegro5/events.h:103
      source : access ALLEGRO_EVENT_SOURCE;  -- /usr/include/allegro5/events.h:103
      timestamp : aliased double;  -- /usr/include/allegro5/events.h:103
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/events.h:101

   type ALLEGRO_DISPLAY is null record;   -- incomplete struct

   type ALLEGRO_DISPLAY_EVENT is record
      c_type : aliased ALLEGRO_EVENT_TYPE;  -- /usr/include/allegro5/events.h:109
      source : access ALLEGRO_DISPLAY;  -- /usr/include/allegro5/events.h:109
      timestamp : aliased double;  -- /usr/include/allegro5/events.h:109
      x : aliased int;  -- /usr/include/allegro5/events.h:110
      y : aliased int;  -- /usr/include/allegro5/events.h:110
      width : aliased int;  -- /usr/include/allegro5/events.h:111
      height : aliased int;  -- /usr/include/allegro5/events.h:111
      orientation : aliased int;  -- /usr/include/allegro5/events.h:112
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/events.h:107

   type ALLEGRO_JOYSTICK is null record;   -- incomplete struct

   type ALLEGRO_JOYSTICK_EVENT is record
      c_type : aliased ALLEGRO_EVENT_TYPE;  -- /usr/include/allegro5/events.h:118
      source : access ALLEGRO_JOYSTICK;  -- /usr/include/allegro5/events.h:118
      timestamp : aliased double;  -- /usr/include/allegro5/events.h:118
      id : access ALLEGRO_JOYSTICK;  -- /usr/include/allegro5/events.h:119
      stick : aliased int;  -- /usr/include/allegro5/events.h:120
      axis : aliased int;  -- /usr/include/allegro5/events.h:121
      pos : aliased float;  -- /usr/include/allegro5/events.h:122
      button : aliased int;  -- /usr/include/allegro5/events.h:123
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/events.h:116

   type ALLEGRO_KEYBOARD is null record;   -- incomplete struct

   type ALLEGRO_KEYBOARD_EVENT is record
      c_type : aliased ALLEGRO_EVENT_TYPE;  -- /usr/include/allegro5/events.h:130
      source : access ALLEGRO_KEYBOARD;  -- /usr/include/allegro5/events.h:130
      timestamp : aliased double;  -- /usr/include/allegro5/events.h:130
      display : access ALLEGRO_DISPLAY;  -- /usr/include/allegro5/events.h:131
      keycode : aliased int;  -- /usr/include/allegro5/events.h:132
      unichar : aliased int;  -- /usr/include/allegro5/events.h:133
      modifiers : aliased unsigned;  -- /usr/include/allegro5/events.h:134
      repeat : aliased Extensions.bool;  -- /usr/include/allegro5/events.h:135
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/events.h:128

  -- the window the key was pressed in  
  -- the physical key pressed  
  -- unicode character or negative  
  -- bitfield  
  -- auto-repeated or not  
   type ALLEGRO_MOUSE is null record;   -- incomplete struct

   type ALLEGRO_MOUSE_EVENT is record
      c_type : aliased ALLEGRO_EVENT_TYPE;  -- /usr/include/allegro5/events.h:142
      source : access ALLEGRO_MOUSE;  -- /usr/include/allegro5/events.h:142
      timestamp : aliased double;  -- /usr/include/allegro5/events.h:142
      display : access ALLEGRO_DISPLAY;  -- /usr/include/allegro5/events.h:143
      x : aliased int;  -- /usr/include/allegro5/events.h:150
      y : aliased int;  -- /usr/include/allegro5/events.h:150
      z : aliased int;  -- /usr/include/allegro5/events.h:150
      w : aliased int;  -- /usr/include/allegro5/events.h:150
      dx : aliased int;  -- /usr/include/allegro5/events.h:151
      dy : aliased int;  -- /usr/include/allegro5/events.h:151
      dz : aliased int;  -- /usr/include/allegro5/events.h:151
      dw : aliased int;  -- /usr/include/allegro5/events.h:151
      button : aliased unsigned;  -- /usr/include/allegro5/events.h:152
      pressure : aliased float;  -- /usr/include/allegro5/events.h:153
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/events.h:140

  -- (display) Window the event originate from
  --    * (x, y) Primary mouse position
  --    * (z) Mouse wheel position (1D 'wheel'), or,
  --    * (w, z) Mouse wheel position (2D 'ball')
  --    * (pressure) The pressure applied, for stylus (0 or 1 for normal mouse)
  --     

   type ALLEGRO_TIMER is null record;   -- incomplete struct

   type ALLEGRO_TIMER_EVENT is record
      c_type : aliased ALLEGRO_EVENT_TYPE;  -- /usr/include/allegro5/events.h:160
      source : access ALLEGRO_TIMER;  -- /usr/include/allegro5/events.h:160
      timestamp : aliased double;  -- /usr/include/allegro5/events.h:160
      count : aliased x86_64_linux_gnu_bits_stdint_intn_h.int64_t;  -- /usr/include/allegro5/events.h:161
      error : aliased double;  -- /usr/include/allegro5/events.h:162
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/events.h:158

   type ALLEGRO_TOUCH_INPUT is null record;   -- incomplete struct

   type ALLEGRO_TOUCH_EVENT is record
      c_type : aliased ALLEGRO_EVENT_TYPE;  -- /usr/include/allegro5/events.h:169
      source : access ALLEGRO_TOUCH_INPUT;  -- /usr/include/allegro5/events.h:169
      timestamp : aliased double;  -- /usr/include/allegro5/events.h:169
      display : access ALLEGRO_DISPLAY;  -- /usr/include/allegro5/events.h:170
      id : aliased int;  -- /usr/include/allegro5/events.h:176
      x : aliased float;  -- /usr/include/allegro5/events.h:177
      y : aliased float;  -- /usr/include/allegro5/events.h:177
      dx : aliased float;  -- /usr/include/allegro5/events.h:178
      dy : aliased float;  -- /usr/include/allegro5/events.h:178
      primary : aliased Extensions.bool;  -- /usr/include/allegro5/events.h:179
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/events.h:167

  -- (id) Identifier of the event, always positive number.
  --    * (x, y) Touch position on the screen in 1:1 resolution.
  --    * (dx, dy) Relative touch position.
  --    * (primary) True, if touch is a primary one (usually first one).
  --     

  -- Type: ALLEGRO_USER_EVENT
  --  

   type ALLEGRO_USER_EVENT;
   type ALLEGRO_USER_EVENT_DESCRIPTOR is null record;   -- incomplete struct

   type ALLEGRO_USER_EVENT is record
      c_type : aliased ALLEGRO_EVENT_TYPE;  -- /usr/include/allegro5/events.h:190
      source : access ALLEGRO_EVENT_SOURCE;  -- /usr/include/allegro5/events.h:190
      timestamp : aliased double;  -- /usr/include/allegro5/events.h:190
      uu_internal_u_descr : access ALLEGRO_USER_EVENT_DESCRIPTOR;  -- /usr/include/allegro5/events.h:191
      data1 : aliased unistd_h.intptr_t;  -- /usr/include/allegro5/events.h:192
      data2 : aliased unistd_h.intptr_t;  -- /usr/include/allegro5/events.h:193
      data3 : aliased unistd_h.intptr_t;  -- /usr/include/allegro5/events.h:194
      data4 : aliased unistd_h.intptr_t;  -- /usr/include/allegro5/events.h:195
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/events.h:188

  -- Type: ALLEGRO_EVENT
  --  

   type ALLEGRO_EVENT;
  -- This must be the same as the first field of _AL_EVENT_HEADER.   
   type ALLEGRO_EVENT (discr : unsigned := 0) is record
      case discr is
         when 0 =>
            c_type : aliased ALLEGRO_EVENT_TYPE;  -- /usr/include/allegro5/events.h:207
         when 1 =>
            any : aliased ALLEGRO_ANY_EVENT;  -- /usr/include/allegro5/events.h:212
         when 2 =>
            display : aliased ALLEGRO_DISPLAY_EVENT;  -- /usr/include/allegro5/events.h:213
         when 3 =>
            joystick : aliased ALLEGRO_JOYSTICK_EVENT;  -- /usr/include/allegro5/events.h:214
         when 4 =>
            keyboard : aliased ALLEGRO_KEYBOARD_EVENT;  -- /usr/include/allegro5/events.h:215
         when 5 =>
            mouse : aliased ALLEGRO_MOUSE_EVENT;  -- /usr/include/allegro5/events.h:216
         when 6 =>
            timer : aliased ALLEGRO_TIMER_EVENT;  -- /usr/include/allegro5/events.h:217
         when 7 =>
            touch : aliased ALLEGRO_TOUCH_EVENT;  -- /usr/include/allegro5/events.h:218
         when others =>
            user : aliased ALLEGRO_USER_EVENT;  -- /usr/include/allegro5/events.h:219
      end case;
   end record
   with Convention => C_Pass_By_Copy,
        Unchecked_Union => True;  -- /usr/include/allegro5/events.h:204

  -- `any' is to allow the user to access the other fields which are
  --    * common to all event types, without using some specific type
  --    * structure.
  --     

  -- Event sources  
   procedure al_init_user_event_source (arg1 : access ALLEGRO_EVENT_SOURCE)  -- /usr/include/allegro5/events.h:226
   with Import => True, 
        Convention => C, 
        External_Name => "al_init_user_event_source";

   procedure al_destroy_user_event_source (arg1 : access ALLEGRO_EVENT_SOURCE)  -- /usr/include/allegro5/events.h:227
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_user_event_source";

  -- The second argument is ALLEGRO_EVENT instead of ALLEGRO_USER_EVENT
  -- * to prevent users passing a pointer to a too-short structure.
  --  

   function al_emit_user_event
     (arg1 : access ALLEGRO_EVENT_SOURCE;
      arg2 : access ALLEGRO_EVENT;
      dtor : access procedure (arg1 : access ALLEGRO_USER_EVENT)) return Extensions.bool  -- /usr/include/allegro5/events.h:231
   with Import => True, 
        Convention => C, 
        External_Name => "al_emit_user_event";

   procedure al_unref_user_event (arg1 : access ALLEGRO_USER_EVENT)  -- /usr/include/allegro5/events.h:233
   with Import => True, 
        Convention => C, 
        External_Name => "al_unref_user_event";

   procedure al_set_event_source_data (arg1 : access ALLEGRO_EVENT_SOURCE; data : unistd_h.intptr_t)  -- /usr/include/allegro5/events.h:234
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_event_source_data";

   function al_get_event_source_data (arg1 : access constant ALLEGRO_EVENT_SOURCE) return unistd_h.intptr_t  -- /usr/include/allegro5/events.h:235
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_event_source_data";

  -- Event queues  
  -- Type: ALLEGRO_EVENT_QUEUE
  --  

   type ALLEGRO_EVENT_QUEUE is null record;   -- incomplete struct

   function al_create_event_queue return access ALLEGRO_EVENT_QUEUE  -- /usr/include/allegro5/events.h:245
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_event_queue";

   procedure al_destroy_event_queue (arg1 : access ALLEGRO_EVENT_QUEUE)  -- /usr/include/allegro5/events.h:246
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_event_queue";

   function al_is_event_source_registered (arg1 : access ALLEGRO_EVENT_QUEUE; arg2 : access ALLEGRO_EVENT_SOURCE) return Extensions.bool  -- /usr/include/allegro5/events.h:247
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_event_source_registered";

   procedure al_register_event_source (arg1 : access ALLEGRO_EVENT_QUEUE; arg2 : access ALLEGRO_EVENT_SOURCE)  -- /usr/include/allegro5/events.h:249
   with Import => True, 
        Convention => C, 
        External_Name => "al_register_event_source";

   procedure al_unregister_event_source (arg1 : access ALLEGRO_EVENT_QUEUE; arg2 : access ALLEGRO_EVENT_SOURCE)  -- /usr/include/allegro5/events.h:250
   with Import => True, 
        Convention => C, 
        External_Name => "al_unregister_event_source";

   procedure al_pause_event_queue (arg1 : access ALLEGRO_EVENT_QUEUE; arg2 : Extensions.bool)  -- /usr/include/allegro5/events.h:251
   with Import => True, 
        Convention => C, 
        External_Name => "al_pause_event_queue";

   function al_is_event_queue_paused (arg1 : access constant ALLEGRO_EVENT_QUEUE) return Extensions.bool  -- /usr/include/allegro5/events.h:252
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_event_queue_paused";

   function al_is_event_queue_empty (arg1 : access ALLEGRO_EVENT_QUEUE) return Extensions.bool  -- /usr/include/allegro5/events.h:253
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_event_queue_empty";

   function al_get_next_event (arg1 : access ALLEGRO_EVENT_QUEUE; ret_event : access ALLEGRO_EVENT) return Extensions.bool  -- /usr/include/allegro5/events.h:254
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_next_event";

   function al_peek_next_event (arg1 : access ALLEGRO_EVENT_QUEUE; ret_event : access ALLEGRO_EVENT) return Extensions.bool  -- /usr/include/allegro5/events.h:255
   with Import => True, 
        Convention => C, 
        External_Name => "al_peek_next_event";

   function al_drop_next_event (arg1 : access ALLEGRO_EVENT_QUEUE) return Extensions.bool  -- /usr/include/allegro5/events.h:256
   with Import => True, 
        Convention => C, 
        External_Name => "al_drop_next_event";

   procedure al_flush_event_queue (arg1 : access ALLEGRO_EVENT_QUEUE)  -- /usr/include/allegro5/events.h:257
   with Import => True, 
        Convention => C, 
        External_Name => "al_flush_event_queue";

   procedure al_wait_for_event (arg1 : access ALLEGRO_EVENT_QUEUE; ret_event : access ALLEGRO_EVENT)  -- /usr/include/allegro5/events.h:258
   with Import => True, 
        Convention => C, 
        External_Name => "al_wait_for_event";

   function al_wait_for_event_timed
     (arg1 : access ALLEGRO_EVENT_QUEUE;
      ret_event : access ALLEGRO_EVENT;
      secs : float) return Extensions.bool  -- /usr/include/allegro5/events.h:260
   with Import => True, 
        Convention => C, 
        External_Name => "al_wait_for_event_timed";

   function al_wait_for_event_until
     (queue : access ALLEGRO_EVENT_QUEUE;
      ret_event : access ALLEGRO_EVENT;
      timeout : access allegro5_altime_h.ALLEGRO_TIMEOUT) return Extensions.bool  -- /usr/include/allegro5/events.h:263
   with Import => True, 
        Convention => C, 
        External_Name => "al_wait_for_event_until";

  -- vim: set sts=3 sw=3 et:  
end allegro5_events_h;

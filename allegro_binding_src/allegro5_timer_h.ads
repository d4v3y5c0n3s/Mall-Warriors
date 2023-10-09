pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Extensions;
with x86_64_linux_gnu_bits_stdint_intn_h;
limited with allegro5_events_h;

package allegro5_timer_h is

   --  arg-macro: function ALLEGRO_USECS_TO_SECS (x)
   --    return (x) / 1000000.0;
   --  arg-macro: function ALLEGRO_MSECS_TO_SECS (x)
   --    return (x) / 1000.0;
   --  arg-macro: function ALLEGRO_BPS_TO_SECS (x)
   --    return 1.0 / (x);
   --  arg-macro: function ALLEGRO_BPM_TO_SECS (x)
   --    return 60.0 / (x);
  --         ______   ___    ___
  -- *        /\  _  \ /\_ \  /\_  *        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
  --_
  -- *         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __` *          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\  *           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
  --__/
  -- *            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
  -- *                                           /\____/
  -- *                                           \_/__/
  -- *
  -- *      Timer routines.
  -- *
  -- *      See readme.txt for copyright information.
  --  

  -- Function: ALLEGRO_USECS_TO_SECS
  --  

  -- Function: ALLEGRO_MSECS_TO_SECS
  --  

  -- Function: ALLEGRO_BPS_TO_SECS
  --  

  -- Function: ALLEGRO_BPM_TO_SECS
  --  

  -- Type: ALLEGRO_TIMER
  --  

      function al_create_timer (speed_secs : double) return access ALLEGRO_TIMER  -- /usr/include/allegro5/timer.h:49
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_timer";

   procedure al_destroy_timer (timer : access ALLEGRO_TIMER)  -- /usr/include/allegro5/timer.h:50
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_timer";

   procedure al_start_timer (timer : access ALLEGRO_TIMER)  -- /usr/include/allegro5/timer.h:51
   with Import => True, 
        Convention => C, 
        External_Name => "al_start_timer";

   procedure al_stop_timer (timer : access ALLEGRO_TIMER)  -- /usr/include/allegro5/timer.h:52
   with Import => True, 
        Convention => C, 
        External_Name => "al_stop_timer";

   procedure al_resume_timer (timer : access ALLEGRO_TIMER)  -- /usr/include/allegro5/timer.h:53
   with Import => True, 
        Convention => C, 
        External_Name => "al_resume_timer";

   function al_get_timer_started (timer : access constant ALLEGRO_TIMER) return Extensions.bool  -- /usr/include/allegro5/timer.h:54
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_timer_started";

   function al_get_timer_speed (timer : access constant ALLEGRO_TIMER) return double  -- /usr/include/allegro5/timer.h:55
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_timer_speed";

   procedure al_set_timer_speed (timer : access ALLEGRO_TIMER; speed_secs : double)  -- /usr/include/allegro5/timer.h:56
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_timer_speed";

   function al_get_timer_count (timer : access constant ALLEGRO_TIMER) return x86_64_linux_gnu_bits_stdint_intn_h.int64_t  -- /usr/include/allegro5/timer.h:57
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_timer_count";

   procedure al_set_timer_count (timer : access ALLEGRO_TIMER; count : x86_64_linux_gnu_bits_stdint_intn_h.int64_t)  -- /usr/include/allegro5/timer.h:58
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_timer_count";

   procedure al_add_timer_count (timer : access ALLEGRO_TIMER; diff : x86_64_linux_gnu_bits_stdint_intn_h.int64_t)  -- /usr/include/allegro5/timer.h:59
   with Import => True, 
        Convention => C, 
        External_Name => "al_add_timer_count";

   function al_get_timer_event_source (timer : access ALLEGRO_TIMER) return access allegro5_events_h.ALLEGRO_EVENT_SOURCE  -- /usr/include/allegro5/timer.h:60
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_timer_event_source";

end allegro5_timer_h;

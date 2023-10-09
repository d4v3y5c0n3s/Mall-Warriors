pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with System;
with Interfaces.C.Extensions;
limited with allegro5_altime_h;

package allegro5_threads_h is

  --         ______   ___    ___
  -- *        /\  _  \ /\_ \  /\_  *        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
  --_
  -- *         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __` *          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\  *           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
  --__/
  -- *            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
  -- *                                           /\____/
  -- *                                           \_/__/
  -- *
  -- *      Thread routines.
  -- *
  -- *      See readme.txt for copyright information.
  --  

  -- Type: ALLEGRO_THREAD
  --  

   type ALLEGRO_THREAD is null record;   -- incomplete struct

  -- Type: ALLEGRO_MUTEX
  --  

   type ALLEGRO_MUTEX is null record;   -- incomplete struct

  -- Type: ALLEGRO_COND
  --  

   type ALLEGRO_COND is null record;   -- incomplete struct

   function al_create_thread (proc : access function (arg1 : access ALLEGRO_THREAD; arg2 : System.Address) return System.Address; arg : System.Address) return access ALLEGRO_THREAD  -- /usr/include/allegro5/threads.h:38
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_thread";

   procedure al_start_thread (outer : access ALLEGRO_THREAD)  -- /usr/include/allegro5/threads.h:44
   with Import => True, 
        Convention => C, 
        External_Name => "al_start_thread";

   procedure al_join_thread (outer : access ALLEGRO_THREAD; ret_value : System.Address)  -- /usr/include/allegro5/threads.h:45
   with Import => True, 
        Convention => C, 
        External_Name => "al_join_thread";

   procedure al_set_thread_should_stop (outer : access ALLEGRO_THREAD)  -- /usr/include/allegro5/threads.h:46
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_thread_should_stop";

   function al_get_thread_should_stop (outer : access ALLEGRO_THREAD) return Extensions.bool  -- /usr/include/allegro5/threads.h:47
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_thread_should_stop";

   procedure al_destroy_thread (thread : access ALLEGRO_THREAD)  -- /usr/include/allegro5/threads.h:48
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_thread";

   procedure al_run_detached_thread (proc : access function (arg1 : System.Address) return System.Address; arg : System.Address)  -- /usr/include/allegro5/threads.h:49
   with Import => True, 
        Convention => C, 
        External_Name => "al_run_detached_thread";

   function al_create_mutex return access ALLEGRO_MUTEX  -- /usr/include/allegro5/threads.h:51
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_mutex";

   function al_create_mutex_recursive return access ALLEGRO_MUTEX  -- /usr/include/allegro5/threads.h:52
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_mutex_recursive";

   procedure al_lock_mutex (mutex : access ALLEGRO_MUTEX)  -- /usr/include/allegro5/threads.h:53
   with Import => True, 
        Convention => C, 
        External_Name => "al_lock_mutex";

   procedure al_unlock_mutex (mutex : access ALLEGRO_MUTEX)  -- /usr/include/allegro5/threads.h:54
   with Import => True, 
        Convention => C, 
        External_Name => "al_unlock_mutex";

   procedure al_destroy_mutex (mutex : access ALLEGRO_MUTEX)  -- /usr/include/allegro5/threads.h:55
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_mutex";

   function al_create_cond return access ALLEGRO_COND  -- /usr/include/allegro5/threads.h:57
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_cond";

   procedure al_destroy_cond (cond : access ALLEGRO_COND)  -- /usr/include/allegro5/threads.h:58
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_cond";

   procedure al_wait_cond (cond : access ALLEGRO_COND; mutex : access ALLEGRO_MUTEX)  -- /usr/include/allegro5/threads.h:59
   with Import => True, 
        Convention => C, 
        External_Name => "al_wait_cond";

   function al_wait_cond_until
     (cond : access ALLEGRO_COND;
      mutex : access ALLEGRO_MUTEX;
      timeout : access constant allegro5_altime_h.ALLEGRO_TIMEOUT) return int  -- /usr/include/allegro5/threads.h:60
   with Import => True, 
        Convention => C, 
        External_Name => "al_wait_cond_until";

   procedure al_broadcast_cond (cond : access ALLEGRO_COND)  -- /usr/include/allegro5/threads.h:62
   with Import => True, 
        Convention => C, 
        External_Name => "al_broadcast_cond";

   procedure al_signal_cond (cond : access ALLEGRO_COND)  -- /usr/include/allegro5/threads.h:63
   with Import => True, 
        Convention => C, 
        External_Name => "al_signal_cond";

  -- vim: set sts=3 sw=3 et:  
end allegro5_threads_h;

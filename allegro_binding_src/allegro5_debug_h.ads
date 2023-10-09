pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;

package allegro5_debug_h is

   --  arg-macro: procedure ALLEGRO_DEBUG_CHANNEL (x)
   --    static char const *__al_debug_channel __attribute__((unused)) := x;
   --  arg-macro: procedure ALLEGRO_TRACE_CHANNEL_LEVEL (channel, level)
   --    not_al_trace_prefix(channel, level, __FILE__, __LINE__, __func__) ? (void)0 : _al_trace_suffix
   --  arg-macro: procedure ALLEGRO_TRACE_LEVEL (x)
   --    ALLEGRO_TRACE_CHANNEL_LEVEL(__al_debug_channel, x)
   --  unsupported macro: ALLEGRO_DEBUG ALLEGRO_TRACE_LEVEL(0)
   --  unsupported macro: ALLEGRO_INFO ALLEGRO_TRACE_LEVEL(1)
   --  unsupported macro: ALLEGRO_WARN ALLEGRO_TRACE_LEVEL(2)
   --  unsupported macro: ALLEGRO_ERROR ALLEGRO_TRACE_LEVEL(3)
   --  unsupported macro: ALLEGRO_ASSERT(e) ((e) ? (void) 0 : (_al_user_assert_handler) ? _al_user_assert_handler(#e, __FILE__, __LINE__, __func__) : assert(e))
   --  unsupported macro: ALLEGRO_ASSERT_CONCAT_(a,b) a ##b
   --  arg-macro: procedure ALLEGRO_ASSERT_CONCAT (a, b)
   --    ALLEGRO_ASSERT_CONCAT_(a, b)
   --  unsupported macro: ALLEGRO_STATIC_ASSERT(module,e) struct ALLEGRO_ASSERT_CONCAT(static_assert_ ##module ##_line_, __LINE__) { unsigned int bf : !!(e); }
  --         ______   ___    ___
  -- *        /\  _  \ /\_ \  /\_  *        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
  --_
  -- *         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __` *          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\  *           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
  --__/
  -- *            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
  -- *                                           /\____/
  -- *                                           \_/__/
  -- *
  -- *      Debug facilities.
  -- *
  -- *      By Shawn Hargreaves.
  -- *
  -- *      See readme.txt for copyright information.
  --  

   --  skipped func _al_trace_prefix

   --  skipped func _al_trace_suffix

  -- Must not be used with a trailing semicolon.  
  -- Run-time assertions.  
   procedure al_register_assert_handler (handler : access procedure
        (arg1 : Interfaces.C.Strings.chars_ptr;
         arg2 : Interfaces.C.Strings.chars_ptr;
         arg3 : int;
         arg4 : Interfaces.C.Strings.chars_ptr))  -- /usr/include/allegro5/debug.h:61
   with Import => True, 
        Convention => C, 
        External_Name => "al_register_assert_handler";

   procedure al_register_trace_handler (handler : access procedure (arg1 : Interfaces.C.Strings.chars_ptr))  -- /usr/include/allegro5/debug.h:64
   with Import => True, 
        Convention => C, 
        External_Name => "al_register_trace_handler";

  -- Clang doesn't understand _al_user_assert_handler, so we simplify the
  --    * definition for analysis purposes.  

  -- Compile time assertions.  
  -- We are lazy and use just ASSERT while Allegro itself is compiled.  
  -- vim: set sts=3 sw=3 et:  
end allegro5_debug_h;

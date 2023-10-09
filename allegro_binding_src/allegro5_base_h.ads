pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with x86_64_linux_gnu_bits_stdint_uintn_h;
with System;

package allegro5_base_h is

   ALLEGRO_VERSION : constant := 5;  --  /usr/include/allegro5/base.h:56
   ALLEGRO_SUB_VERSION : constant := 2;  --  /usr/include/allegro5/base.h:57
   ALLEGRO_WIP_VERSION : constant := 6;  --  /usr/include/allegro5/base.h:58

   ALLEGRO_UNSTABLE_BIT : constant := 0;  --  /usr/include/allegro5/base.h:63

   ALLEGRO_RELEASE_NUMBER : constant := 1;  --  /usr/include/allegro5/base.h:74

   ALLEGRO_VERSION_STR : aliased constant String := "5.2.6" & ASCII.NUL;  --  /usr/include/allegro5/base.h:76
   ALLEGRO_DATE_STR : aliased constant String := "2020" & ASCII.NUL;  --  /usr/include/allegro5/base.h:77
   ALLEGRO_DATE : constant := 20200207;  --  /usr/include/allegro5/base.h:78
   --  unsupported macro: ALLEGRO_VERSION_INT ((ALLEGRO_VERSION << 24) | (ALLEGRO_SUB_VERSION << 16) | (ALLEGRO_WIP_VERSION << 8) | ALLEGRO_RELEASE_NUMBER | ALLEGRO_UNSTABLE_BIT)

   ALLEGRO_PI : constant := 3.14159265358979323846;  --  /usr/include/allegro5/base.h:93
   --  arg-macro: function AL_ID (a, b, c, d)
   --    return ((a)<<24) or ((b)<<16) or ((c)<<8) or (d);

  --         ______   ___    ___
  -- *        /\  _  \ /\_ \  /\_  *        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
  --_
  -- *         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __` *          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\  *           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
  --__/
  -- *            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
  -- *                                           /\____/
  -- *                                           \_/__/
  -- *
  -- *      Base header, defines basic stuff needed by pretty much
  -- *      everything else.
  -- *
  -- *      By Shawn Hargreaves.
  -- *
  -- *      See readme.txt for copyright information.
  --  

  -- enable posix for limits.h and only limits.h
  --         enabling it for all msvc headers will potentially
  --         disable a lot of commonly used msvcrt functions  

  -- Not sure we need it, but since ALLEGRO_VERSION_STR contains it:
  -- * 0 = GIT
  -- * 1 = first release
  -- * 2... = hotfixes?
  -- *
  -- * Note x.y.z (= x.y.z.0) has release number 1, and x.y.z.1 has release
  -- * number 2, just to confuse you.
  --  

   function al_get_allegro_version return x86_64_linux_gnu_bits_stdint_uintn_h.uint32_t  -- /usr/include/allegro5/base.h:84
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_allegro_version";

   function al_run_main
     (argc : int;
      argv : System.Address;
      arg3 : access function (arg1 : int; arg2 : System.Address) return int) return int  -- /usr/include/allegro5/base.h:85
   with Import => True, 
        Convention => C, 
        External_Name => "al_run_main";

  --***************************************** 
  --*********** Some global stuff *********** 
  --***************************************** 
  -- Type: ALLEGRO_PI
  --  

end allegro5_base_h;

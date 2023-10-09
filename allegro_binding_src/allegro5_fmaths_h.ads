pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with allegro5_fixed_h;

package allegro5_fmaths_h is

  --         ______   ___    ___
  -- *        /\  _  \ /\_ \  /\_  *        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
  --_
  -- *         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __` *          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\  *           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
  --__/
  -- *            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
  -- *                                           /\____/
  -- *                                           \_/__/
  -- *
  -- *      Fixed point math routines.
  -- *
  -- *      By Shawn Hargreaves.
  -- *
  -- *      See readme.txt for copyright information.
  --  

   function al_fixsqrt (x : allegro5_fixed_h.al_fixed) return allegro5_fixed_h.al_fixed  -- /usr/include/allegro5/fmaths.h:29
   with Import => True, 
        Convention => C, 
        External_Name => "al_fixsqrt";

   function al_fixhypot (x : allegro5_fixed_h.al_fixed; y : allegro5_fixed_h.al_fixed) return allegro5_fixed_h.al_fixed  -- /usr/include/allegro5/fmaths.h:30
   with Import => True, 
        Convention => C, 
        External_Name => "al_fixhypot";

   function al_fixatan (x : allegro5_fixed_h.al_fixed) return allegro5_fixed_h.al_fixed  -- /usr/include/allegro5/fmaths.h:31
   with Import => True, 
        Convention => C, 
        External_Name => "al_fixatan";

   function al_fixatan2 (y : allegro5_fixed_h.al_fixed; x : allegro5_fixed_h.al_fixed) return allegro5_fixed_h.al_fixed  -- /usr/include/allegro5/fmaths.h:32
   with Import => True, 
        Convention => C, 
        External_Name => "al_fixatan2";

end allegro5_fmaths_h;

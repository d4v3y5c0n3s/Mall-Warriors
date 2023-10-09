pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with x86_64_linux_gnu_bits_stdint_intn_h;

package allegro5_fixed_h is

  --         ______   ___    ___
  -- *        /\  _  \ /\_ \  /\_  *        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
  --_
  -- *         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __` *          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\  *           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
  --__/
  -- *            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
  -- *                                           /\____/
  -- *                                           \_/__/
  -- *
  -- *      Fixed point type.
  -- *
  -- *      By Shawn Hargreaves.
  -- *
  -- *      See readme.txt for copyright information.
  --  

  -- Type: al_fixed
  --  

   subtype al_fixed is x86_64_linux_gnu_bits_stdint_intn_h.int32_t;  -- /usr/include/allegro5/fixed.h:30

   al_fixtorad_r : aliased constant al_fixed  -- /usr/include/allegro5/fixed.h:32
   with Import => True, 
        Convention => C, 
        External_Name => "al_fixtorad_r";

   al_radtofix_r : aliased constant al_fixed  -- /usr/include/allegro5/fixed.h:33
   with Import => True, 
        Convention => C, 
        External_Name => "al_radtofix_r";

end allegro5_fixed_h;

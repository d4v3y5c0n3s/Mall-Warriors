pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package allegro5_cpu_h is

  --         ______   ___    ___
  -- *        /\  _  \ /\_ \  /\_  *        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
  --_
  -- *         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __` *          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\  *           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
  --__/
  -- *            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
  -- *                                           /\____/
  -- *                                           \_/__/
  -- *
  -- *      CPU and system information handling.
  -- *
  -- *      See readme.txt for copyright information.
  --  

   function al_get_cpu_count return int  -- /usr/include/allegro5/cpu.h:25
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_cpu_count";

   function al_get_ram_size return int  -- /usr/include/allegro5/cpu.h:26
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_ram_size";

  -- * Local Variables:
  -- * c-basic-offset: 3
  -- * indent-tabs-mode: nil
  -- * End:
  --  

end allegro5_cpu_h;

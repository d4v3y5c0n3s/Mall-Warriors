pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package allegro5_error_h is

  --         ______   ___    ___
  -- *        /\  _  \ /\_ \  /\_  *        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
  --_
  -- *         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __` *          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\  *           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
  --__/
  -- *            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
  -- *                                           /\____/
  -- *                                           \_/__/
  -- *
  -- *      Error handling.
  -- *
  -- *      See readme.txt for copyright information.
  --  

   function al_get_errno return int  -- /usr/include/allegro5/error.h:25
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_errno";

   procedure al_set_errno (errnum : int)  -- /usr/include/allegro5/error.h:26
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_errno";

  -- * Local Variables:
  -- * c-basic-offset: 3
  -- * indent-tabs-mode: nil
  -- * End:
  --  

end allegro5_error_h;

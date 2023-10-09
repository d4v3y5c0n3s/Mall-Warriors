pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package allegro5_keycodes_h is

  --         ______   ___    ___
  -- *        /\  _  \ /\_ \  /\_  *        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
  --_
  -- *         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __` *          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\  *           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
  --__/
  -- *            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
  -- *                                           /\____/
  -- *                                           \_/__/
  -- *
  -- *      Keycode constants.
  -- *
  -- *      See readme.txt for copyright information.
  --  

  -- Note these values are deliberately the same as in Allegro 4.1.x  
  -- DirectInput calls this DIK_OEM_102: "< > | on UK/Germany keyboards"  
  -- MacOS X  
  -- MacOS X  
  -- MacOS X -- TODO: ask lillo what this should be  
  -- MacOS X  
  -- Android back key  
  -- Android game keys  
  -- All codes up to before ALLEGRO_KEY_MODIFIERS can be freely
  --    * assignedas additional unknown keys, like various multimedia
  --    * and application keys keyboards may have.
  --     

end allegro5_keycodes_h;

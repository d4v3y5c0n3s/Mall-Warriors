pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
limited with allegro5_display_h;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;

package allegro5_clipboard_h is

  --         ______   ___    ___
  -- *        /\  _  \ /\_ \  /\_  *        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
  --_
  -- *         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __` *          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\  *           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
  --__/
  -- *            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
  -- *                                           /\____/
  -- *                                           \_/__/
  -- *
  -- *      Clipboard handling.
  -- *
  -- *      See readme.txt for copyright information.
  --  

   function al_get_clipboard_text (display : access allegro5_display_h.ALLEGRO_DISPLAY) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/clipboard.h:27
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_clipboard_text";

   function al_set_clipboard_text (display : access allegro5_display_h.ALLEGRO_DISPLAY; text : Interfaces.C.Strings.chars_ptr) return Extensions.bool  -- /usr/include/allegro5/clipboard.h:28
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_clipboard_text";

   function al_clipboard_has_text (display : access allegro5_display_h.ALLEGRO_DISPLAY) return Extensions.bool  -- /usr/include/allegro5/clipboard.h:29
   with Import => True, 
        Convention => C, 
        External_Name => "al_clipboard_has_text";

  -- * Local Variables:
  -- * c-basic-offset: 3
  -- * indent-tabs-mode: nil
  -- * End:
  --  

end allegro5_clipboard_h;

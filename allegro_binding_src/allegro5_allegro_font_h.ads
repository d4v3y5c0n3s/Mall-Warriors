pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;
limited with allegro5_bitmap_h;
with allegro5_color_h;
limited with allegro5_utf8_h;
with x86_64_linux_gnu_bits_stdint_uintn_h;
with System;

package allegro5_allegro_font_h is

   --  unsupported macro: ALLEGRO_FONT_FUNC AL_FUNC
   --  unsupported macro: ALLEGRO_FONT_METHOD AL_METHOD
   --  unsupported macro: ALLEGRO_FONT_FUNCPTR AL_FUNCPTR
   --  unsupported macro: ALLEGRO_FONT_PRINTFUNC AL_PRINTFUNC
  -- Type: ALLEGRO_FONT
  -- 

   type ALLEGRO_FONT is null record;   -- incomplete struct

  -- Type: ALLEGRO_GLYPH
  -- 

   function al_register_font_loader (ext : Interfaces.C.Strings.chars_ptr; load : access function
        (arg1 : Interfaces.C.Strings.chars_ptr;
         arg2 : int;
         arg3 : int) return access ALLEGRO_FONT) return Extensions.bool  -- /usr/include/allegro5/allegro_font.h:78
   with Import => True, 
        Convention => C, 
        External_Name => "al_register_font_loader";

   function al_load_bitmap_font (filename : Interfaces.C.Strings.chars_ptr) return access ALLEGRO_FONT  -- /usr/include/allegro5/allegro_font.h:79
   with Import => True, 
        Convention => C, 
        External_Name => "al_load_bitmap_font";

   function al_load_bitmap_font_flags (filename : Interfaces.C.Strings.chars_ptr; flags : int) return access ALLEGRO_FONT  -- /usr/include/allegro5/allegro_font.h:80
   with Import => True, 
        Convention => C, 
        External_Name => "al_load_bitmap_font_flags";

   function al_load_font
     (filename : Interfaces.C.Strings.chars_ptr;
      size : int;
      flags : int) return access ALLEGRO_FONT  -- /usr/include/allegro5/allegro_font.h:81
   with Import => True, 
        Convention => C, 
        External_Name => "al_load_font";

   function al_grab_font_from_bitmap
     (bmp : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      n : int;
      ranges : access int) return access ALLEGRO_FONT  -- /usr/include/allegro5/allegro_font.h:83
   with Import => True, 
        Convention => C, 
        External_Name => "al_grab_font_from_bitmap";

   function al_create_builtin_font return access ALLEGRO_FONT  -- /usr/include/allegro5/allegro_font.h:84
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_builtin_font";

   procedure al_draw_ustr
     (font : access constant ALLEGRO_FONT;
      color : allegro5_color_h.ALLEGRO_COLOR;
      x : float;
      y : float;
      flags : int;
      ustr : access constant allegro5_utf8_h.ALLEGRO_USTR)  -- /usr/include/allegro5/allegro_font.h:86
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_ustr";

   procedure al_draw_text
     (font : access constant ALLEGRO_FONT;
      color : allegro5_color_h.ALLEGRO_COLOR;
      x : float;
      y : float;
      flags : int;
      text : Interfaces.C.Strings.chars_ptr)  -- /usr/include/allegro5/allegro_font.h:87
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_text";

   procedure al_draw_justified_text
     (font : access constant ALLEGRO_FONT;
      color : allegro5_color_h.ALLEGRO_COLOR;
      x1 : float;
      x2 : float;
      y : float;
      diff : float;
      flags : int;
      text : Interfaces.C.Strings.chars_ptr)  -- /usr/include/allegro5/allegro_font.h:88
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_justified_text";

   procedure al_draw_justified_ustr
     (font : access constant ALLEGRO_FONT;
      color : allegro5_color_h.ALLEGRO_COLOR;
      x1 : float;
      x2 : float;
      y : float;
      diff : float;
      flags : int;
      text : access constant allegro5_utf8_h.ALLEGRO_USTR)  -- /usr/include/allegro5/allegro_font.h:89
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_justified_ustr";

   procedure al_draw_textf
     (font : access constant ALLEGRO_FONT;
      color : allegro5_color_h.ALLEGRO_COLOR;
      x : float;
      y : float;
      flags : int;
      format : Interfaces.C.Strings.chars_ptr  -- , ...
      )  -- /usr/include/allegro5/allegro_font.h:90
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_textf";

   procedure al_draw_justified_textf
     (font : access constant ALLEGRO_FONT;
      color : allegro5_color_h.ALLEGRO_COLOR;
      x1 : float;
      x2 : float;
      y : float;
      diff : float;
      flags : int;
      format : Interfaces.C.Strings.chars_ptr  -- , ...
      )  -- /usr/include/allegro5/allegro_font.h:91
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_justified_textf";

   function al_get_text_width (f : access constant ALLEGRO_FONT; str : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/allegro5/allegro_font.h:92
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_text_width";

   function al_get_ustr_width (f : access constant ALLEGRO_FONT; ustr : access constant allegro5_utf8_h.ALLEGRO_USTR) return int  -- /usr/include/allegro5/allegro_font.h:93
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_ustr_width";

   function al_get_font_line_height (f : access constant ALLEGRO_FONT) return int  -- /usr/include/allegro5/allegro_font.h:94
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_font_line_height";

   function al_get_font_ascent (f : access constant ALLEGRO_FONT) return int  -- /usr/include/allegro5/allegro_font.h:95
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_font_ascent";

   function al_get_font_descent (f : access constant ALLEGRO_FONT) return int  -- /usr/include/allegro5/allegro_font.h:96
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_font_descent";

   procedure al_destroy_font (f : access ALLEGRO_FONT)  -- /usr/include/allegro5/allegro_font.h:97
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_font";

   procedure al_get_ustr_dimensions
     (f : access constant ALLEGRO_FONT;
      text : access constant allegro5_utf8_h.ALLEGRO_USTR;
      bbx : access int;
      bby : access int;
      bbw : access int;
      bbh : access int)  -- /usr/include/allegro5/allegro_font.h:98
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_ustr_dimensions";

   procedure al_get_text_dimensions
     (f : access constant ALLEGRO_FONT;
      text : Interfaces.C.Strings.chars_ptr;
      bbx : access int;
      bby : access int;
      bbw : access int;
      bbh : access int)  -- /usr/include/allegro5/allegro_font.h:101
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_text_dimensions";

   function al_init_font_addon return Extensions.bool  -- /usr/include/allegro5/allegro_font.h:104
   with Import => True, 
        Convention => C, 
        External_Name => "al_init_font_addon";

   function al_is_font_addon_initialized return Extensions.bool  -- /usr/include/allegro5/allegro_font.h:105
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_font_addon_initialized";

   procedure al_shutdown_font_addon  -- /usr/include/allegro5/allegro_font.h:106
   with Import => True, 
        Convention => C, 
        External_Name => "al_shutdown_font_addon";

   function al_get_allegro_font_version return x86_64_linux_gnu_bits_stdint_uintn_h.uint32_t  -- /usr/include/allegro5/allegro_font.h:107
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_allegro_font_version";

   function al_get_font_ranges
     (font : access ALLEGRO_FONT;
      ranges_count : int;
      ranges : access int) return int  -- /usr/include/allegro5/allegro_font.h:108
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_font_ranges";

   procedure al_draw_glyph
     (font : access constant ALLEGRO_FONT;
      color : allegro5_color_h.ALLEGRO_COLOR;
      x : float;
      y : float;
      codepoint : int)  -- /usr/include/allegro5/allegro_font.h:111
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_glyph";

   function al_get_glyph_width (f : access constant ALLEGRO_FONT; codepoint : int) return int  -- /usr/include/allegro5/allegro_font.h:113
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_glyph_width";

   function al_get_glyph_dimensions
     (f : access constant ALLEGRO_FONT;
      codepoint : int;
      bbx : access int;
      bby : access int;
      bbw : access int;
      bbh : access int) return Extensions.bool  -- /usr/include/allegro5/allegro_font.h:115
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_glyph_dimensions";

   function al_get_glyph_advance
     (f : access constant ALLEGRO_FONT;
      codepoint1 : int;
      codepoint2 : int) return int  -- /usr/include/allegro5/allegro_font.h:117
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_glyph_advance";

   procedure al_draw_multiline_text
     (font : access constant ALLEGRO_FONT;
      color : allegro5_color_h.ALLEGRO_COLOR;
      x : float;
      y : float;
      max_width : float;
      line_height : float;
      flags : int;
      text : Interfaces.C.Strings.chars_ptr)  -- /usr/include/allegro5/allegro_font.h:123
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_multiline_text";

   procedure al_draw_multiline_textf
     (font : access constant ALLEGRO_FONT;
      color : allegro5_color_h.ALLEGRO_COLOR;
      x : float;
      y : float;
      max_width : float;
      line_height : float;
      flags : int;
      format : Interfaces.C.Strings.chars_ptr  -- , ...
      )  -- /usr/include/allegro5/allegro_font.h:124
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_multiline_textf";

   procedure al_draw_multiline_ustr
     (font : access constant ALLEGRO_FONT;
      color : allegro5_color_h.ALLEGRO_COLOR;
      x : float;
      y : float;
      max_width : float;
      line_height : float;
      flags : int;
      text : access constant allegro5_utf8_h.ALLEGRO_USTR)  -- /usr/include/allegro5/allegro_font.h:125
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_multiline_ustr";

   procedure al_do_multiline_text
     (font : access constant ALLEGRO_FONT;
      max_width : float;
      text : Interfaces.C.Strings.chars_ptr;
      cb : access function
        (arg1 : int;
         arg2 : Interfaces.C.Strings.chars_ptr;
         arg3 : int;
         arg4 : System.Address) return Extensions.bool;
      extra : System.Address)  -- /usr/include/allegro5/allegro_font.h:127
   with Import => True, 
        Convention => C, 
        External_Name => "al_do_multiline_text";

   procedure al_do_multiline_ustr
     (font : access constant ALLEGRO_FONT;
      max_width : float;
      ustr : access constant allegro5_utf8_h.ALLEGRO_USTR;
      cb : access function
        (arg1 : int;
         arg2 : access constant allegro5_utf8_h.ALLEGRO_USTR;
         arg3 : System.Address) return Extensions.bool;
      extra : System.Address)  -- /usr/include/allegro5/allegro_font.h:132
   with Import => True, 
        Convention => C, 
        External_Name => "al_do_multiline_ustr";

   procedure al_set_fallback_font (font : access ALLEGRO_FONT; fallback : access ALLEGRO_FONT)  -- /usr/include/allegro5/allegro_font.h:137
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_fallback_font";

   function al_get_fallback_font (font : access ALLEGRO_FONT) return access ALLEGRO_FONT  -- /usr/include/allegro5/allegro_font.h:139
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_fallback_font";

end allegro5_allegro_font_h;

pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with x86_64_linux_gnu_bits_stdint_uintn_h;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;
with allegro5_color_h;

package allegro_color_h is

   --  unsupported macro: ALLEGRO_COLOR_FUNC AL_FUNC
   function al_get_allegro_color_version return x86_64_linux_gnu_bits_stdint_uintn_h.uint32_t  -- addons/color/allegro5/allegro_color.h:32
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_allegro_color_version";

   procedure al_color_hsv_to_rgb
     (hue : float;
      saturation : float;
      value : float;
      red : access float;
      green : access float;
      blue : access float)  -- addons/color/allegro5/allegro_color.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_hsv_to_rgb";

   procedure al_color_rgb_to_hsl
     (red : float;
      green : float;
      blue : float;
      hue : access float;
      saturation : access float;
      lightness : access float)  -- addons/color/allegro5/allegro_color.h:36
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_rgb_to_hsl";

   procedure al_color_rgb_to_hsv
     (red : float;
      green : float;
      blue : float;
      hue : access float;
      saturation : access float;
      value : access float)  -- addons/color/allegro5/allegro_color.h:38
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_rgb_to_hsv";

   procedure al_color_hsl_to_rgb
     (hue : float;
      saturation : float;
      lightness : float;
      red : access float;
      green : access float;
      blue : access float)  -- addons/color/allegro5/allegro_color.h:40
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_hsl_to_rgb";

   function al_color_name_to_rgb
     (name : Interfaces.C.Strings.chars_ptr;
      r : access float;
      g : access float;
      b : access float) return Extensions.bool  -- addons/color/allegro5/allegro_color.h:42
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_name_to_rgb";

   function al_color_rgb_to_name
     (r : float;
      g : float;
      b : float) return Interfaces.C.Strings.chars_ptr  -- addons/color/allegro5/allegro_color.h:44
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_rgb_to_name";

   procedure al_color_cmyk_to_rgb
     (cyan : float;
      magenta : float;
      yellow : float;
      key : float;
      red : access float;
      green : access float;
      blue : access float)  -- addons/color/allegro5/allegro_color.h:45
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_cmyk_to_rgb";

   procedure al_color_rgb_to_cmyk
     (red : float;
      green : float;
      blue : float;
      cyan : access float;
      magenta : access float;
      yellow : access float;
      key : access float)  -- addons/color/allegro5/allegro_color.h:47
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_rgb_to_cmyk";

   procedure al_color_yuv_to_rgb
     (y : float;
      u : float;
      v : float;
      red : access float;
      green : access float;
      blue : access float)  -- addons/color/allegro5/allegro_color.h:49
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_yuv_to_rgb";

   procedure al_color_rgb_to_yuv
     (red : float;
      green : float;
      blue : float;
      y : access float;
      u : access float;
      v : access float)  -- addons/color/allegro5/allegro_color.h:51
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_rgb_to_yuv";

   procedure al_color_rgb_to_html
     (red : float;
      green : float;
      blue : float;
      string : Interfaces.C.Strings.chars_ptr)  -- addons/color/allegro5/allegro_color.h:53
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_rgb_to_html";

   function al_color_html_to_rgb
     (string : Interfaces.C.Strings.chars_ptr;
      red : access float;
      green : access float;
      blue : access float) return Extensions.bool  -- addons/color/allegro5/allegro_color.h:55
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_html_to_rgb";

   function al_color_yuv
     (y : float;
      u : float;
      v : float) return allegro5_color_h.ALLEGRO_COLOR  -- addons/color/allegro5/allegro_color.h:57
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_yuv";

   function al_color_cmyk
     (c : float;
      m : float;
      y : float;
      k : float) return allegro5_color_h.ALLEGRO_COLOR  -- addons/color/allegro5/allegro_color.h:58
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_cmyk";

   function al_color_hsl
     (h : float;
      s : float;
      l : float) return allegro5_color_h.ALLEGRO_COLOR  -- addons/color/allegro5/allegro_color.h:59
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_hsl";

   function al_color_hsv
     (h : float;
      s : float;
      v : float) return allegro5_color_h.ALLEGRO_COLOR  -- addons/color/allegro5/allegro_color.h:60
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_hsv";

   function al_color_name (name : Interfaces.C.Strings.chars_ptr) return allegro5_color_h.ALLEGRO_COLOR  -- addons/color/allegro5/allegro_color.h:61
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_name";

   function al_color_html (string : Interfaces.C.Strings.chars_ptr) return allegro5_color_h.ALLEGRO_COLOR  -- addons/color/allegro5/allegro_color.h:62
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_html";

   procedure al_color_xyz_to_rgb
     (x : float;
      y : float;
      z : float;
      red : access float;
      green : access float;
      blue : access float)  -- addons/color/allegro5/allegro_color.h:63
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_xyz_to_rgb";

   procedure al_color_rgb_to_xyz
     (red : float;
      green : float;
      blue : float;
      x : access float;
      y : access float;
      z : access float)  -- addons/color/allegro5/allegro_color.h:65
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_rgb_to_xyz";

   function al_color_xyz
     (x : float;
      y : float;
      z : float) return allegro5_color_h.ALLEGRO_COLOR  -- addons/color/allegro5/allegro_color.h:67
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_xyz";

   procedure al_color_lab_to_rgb
     (l : float;
      a : float;
      b : float;
      red : access float;
      green : access float;
      blue : access float)  -- addons/color/allegro5/allegro_color.h:68
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_lab_to_rgb";

   procedure al_color_rgb_to_lab
     (red : float;
      green : float;
      blue : float;
      l : access float;
      a : access float;
      b : access float)  -- addons/color/allegro5/allegro_color.h:70
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_rgb_to_lab";

   function al_color_lab
     (l : float;
      a : float;
      b : float) return allegro5_color_h.ALLEGRO_COLOR  -- addons/color/allegro5/allegro_color.h:72
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_lab";

   procedure al_color_xyy_to_rgb
     (x : float;
      y : float;
      y2 : float;
      red : access float;
      green : access float;
      blue : access float)  -- addons/color/allegro5/allegro_color.h:73
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_xyy_to_rgb";

   procedure al_color_rgb_to_xyy
     (red : float;
      green : float;
      blue : float;
      x : access float;
      y : access float;
      y2 : access float)  -- addons/color/allegro5/allegro_color.h:75
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_rgb_to_xyy";

   function al_color_xyy
     (x : float;
      y : float;
      y2 : float) return allegro5_color_h.ALLEGRO_COLOR  -- addons/color/allegro5/allegro_color.h:77
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_xyy";

   function al_color_distance_ciede2000 (c1 : allegro5_color_h.ALLEGRO_COLOR; c2 : allegro5_color_h.ALLEGRO_COLOR) return double  -- addons/color/allegro5/allegro_color.h:78
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_distance_ciede2000";

   procedure al_color_lch_to_rgb
     (l : float;
      c : float;
      h : float;
      red : access float;
      green : access float;
      blue : access float)  -- addons/color/allegro5/allegro_color.h:79
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_lch_to_rgb";

   procedure al_color_rgb_to_lch
     (red : float;
      green : float;
      blue : float;
      l : access float;
      c : access float;
      h : access float)  -- addons/color/allegro5/allegro_color.h:81
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_rgb_to_lch";

   function al_color_lch
     (l : float;
      c : float;
      h : float) return allegro5_color_h.ALLEGRO_COLOR  -- addons/color/allegro5/allegro_color.h:83
   with Import => True, 
        Convention => C, 
        External_Name => "al_color_lch";

   function al_is_color_valid (color : allegro5_color_h.ALLEGRO_COLOR) return Extensions.bool  -- addons/color/allegro5/allegro_color.h:84
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_color_valid";

end allegro_color_h;

pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package allegro5_color_h is

  -- Type: ALLEGRO_COLOR
  --  

   type ALLEGRO_COLOR;
   type ALLEGRO_COLOR is record
      r : aliased float;  -- /usr/include/allegro5/color.h:17
      g : aliased float;  -- /usr/include/allegro5/color.h:17
      b : aliased float;  -- /usr/include/allegro5/color.h:17
      a : aliased float;  -- /usr/include/allegro5/color.h:17
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/color.h:15

  -- Enum: ALLEGRO_PIXEL_FORMAT
  --  

   type ALLEGRO_PIXEL_FORMAT is 
     (ALLEGRO_PIXEL_FORMAT_ANY,
      ALLEGRO_PIXEL_FORMAT_ANY_NO_ALPHA,
      ALLEGRO_PIXEL_FORMAT_ANY_WITH_ALPHA,
      ALLEGRO_PIXEL_FORMAT_ANY_15_NO_ALPHA,
      ALLEGRO_PIXEL_FORMAT_ANY_16_NO_ALPHA,
      ALLEGRO_PIXEL_FORMAT_ANY_16_WITH_ALPHA,
      ALLEGRO_PIXEL_FORMAT_ANY_24_NO_ALPHA,
      ALLEGRO_PIXEL_FORMAT_ANY_32_NO_ALPHA,
      ALLEGRO_PIXEL_FORMAT_ANY_32_WITH_ALPHA,
      ALLEGRO_PIXEL_FORMAT_ARGB_8888,
      ALLEGRO_PIXEL_FORMAT_RGBA_8888,
      ALLEGRO_PIXEL_FORMAT_ARGB_4444,
      ALLEGRO_PIXEL_FORMAT_RGB_888,
      ALLEGRO_PIXEL_FORMAT_RGB_565,
      ALLEGRO_PIXEL_FORMAT_RGB_555,
      ALLEGRO_PIXEL_FORMAT_RGBA_5551,
      ALLEGRO_PIXEL_FORMAT_ARGB_1555,
      ALLEGRO_PIXEL_FORMAT_ABGR_8888,
      ALLEGRO_PIXEL_FORMAT_XBGR_8888,
      ALLEGRO_PIXEL_FORMAT_BGR_888,
      ALLEGRO_PIXEL_FORMAT_BGR_565,
      ALLEGRO_PIXEL_FORMAT_BGR_555,
      ALLEGRO_PIXEL_FORMAT_RGBX_8888,
      ALLEGRO_PIXEL_FORMAT_XRGB_8888,
      ALLEGRO_PIXEL_FORMAT_ABGR_F32,
      ALLEGRO_PIXEL_FORMAT_ABGR_8888_LE,
      ALLEGRO_PIXEL_FORMAT_RGBA_4444,
      ALLEGRO_PIXEL_FORMAT_SINGLE_CHANNEL_8,
      ALLEGRO_PIXEL_FORMAT_COMPRESSED_RGBA_DXT1,
      ALLEGRO_PIXEL_FORMAT_COMPRESSED_RGBA_DXT3,
      ALLEGRO_PIXEL_FORMAT_COMPRESSED_RGBA_DXT5,
      ALLEGRO_NUM_PIXEL_FORMATS)
   with Convention => C;  -- /usr/include/allegro5/color.h:23

  -- 24 bit format  
  -- 24 bit format  
  -- Pixel mapping  
   function al_map_rgb
     (r : unsigned_char;
      g : unsigned_char;
      b : unsigned_char) return ALLEGRO_COLOR  -- /usr/include/allegro5/color.h:61
   with Import => True, 
        Convention => C, 
        External_Name => "al_map_rgb";

   function al_map_rgba
     (r : unsigned_char;
      g : unsigned_char;
      b : unsigned_char;
      a : unsigned_char) return ALLEGRO_COLOR  -- /usr/include/allegro5/color.h:62
   with Import => True, 
        Convention => C, 
        External_Name => "al_map_rgba";

   function al_map_rgb_f
     (r : float;
      g : float;
      b : float) return ALLEGRO_COLOR  -- /usr/include/allegro5/color.h:63
   with Import => True, 
        Convention => C, 
        External_Name => "al_map_rgb_f";

   function al_map_rgba_f
     (r : float;
      g : float;
      b : float;
      a : float) return ALLEGRO_COLOR  -- /usr/include/allegro5/color.h:64
   with Import => True, 
        Convention => C, 
        External_Name => "al_map_rgba_f";

   function al_premul_rgba
     (r : unsigned_char;
      g : unsigned_char;
      b : unsigned_char;
      a : unsigned_char) return ALLEGRO_COLOR  -- /usr/include/allegro5/color.h:65
   with Import => True, 
        Convention => C, 
        External_Name => "al_premul_rgba";

   function al_premul_rgba_f
     (r : float;
      g : float;
      b : float;
      a : float) return ALLEGRO_COLOR  -- /usr/include/allegro5/color.h:67
   with Import => True, 
        Convention => C, 
        External_Name => "al_premul_rgba_f";

  -- Pixel unmapping  
   procedure al_unmap_rgb
     (color : ALLEGRO_COLOR;
      r : access unsigned_char;
      g : access unsigned_char;
      b : access unsigned_char)  -- /usr/include/allegro5/color.h:71
   with Import => True, 
        Convention => C, 
        External_Name => "al_unmap_rgb";

   procedure al_unmap_rgba
     (color : ALLEGRO_COLOR;
      r : access unsigned_char;
      g : access unsigned_char;
      b : access unsigned_char;
      a : access unsigned_char)  -- /usr/include/allegro5/color.h:72
   with Import => True, 
        Convention => C, 
        External_Name => "al_unmap_rgba";

   procedure al_unmap_rgb_f
     (color : ALLEGRO_COLOR;
      r : access float;
      g : access float;
      b : access float)  -- /usr/include/allegro5/color.h:73
   with Import => True, 
        Convention => C, 
        External_Name => "al_unmap_rgb_f";

   procedure al_unmap_rgba_f
     (color : ALLEGRO_COLOR;
      r : access float;
      g : access float;
      b : access float;
      a : access float)  -- /usr/include/allegro5/color.h:74
   with Import => True, 
        Convention => C, 
        External_Name => "al_unmap_rgba_f";

  -- Pixel formats  
   function al_get_pixel_size (format : int) return int  -- /usr/include/allegro5/color.h:77
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_pixel_size";

   function al_get_pixel_format_bits (format : int) return int  -- /usr/include/allegro5/color.h:78
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_pixel_format_bits";

   function al_get_pixel_block_size (format : int) return int  -- /usr/include/allegro5/color.h:79
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_pixel_block_size";

   function al_get_pixel_block_width (format : int) return int  -- /usr/include/allegro5/color.h:80
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_pixel_block_width";

   function al_get_pixel_block_height (format : int) return int  -- /usr/include/allegro5/color.h:81
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_pixel_block_height";

  -- vim: set ts=8 sts=3 sw=3 et:  
end allegro5_color_h;

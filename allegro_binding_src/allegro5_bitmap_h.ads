pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with allegro5_color_h;
with Interfaces.C.Extensions;

package allegro5_bitmap_h is

  -- Type: ALLEGRO_BITMAP
  --  

   type ALLEGRO_BITMAP is null record;   -- incomplete struct

  -- * Bitmap flags
  --  

  -- now a bitmap loader flag  
  -- no longer honoured  
  -- now a render state flag  
  -- now a bitmap loader flag  
   procedure al_set_new_bitmap_format (format : int)  -- /usr/include/allegro5/bitmap.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_new_bitmap_format";

   procedure al_set_new_bitmap_flags (flags : int)  -- /usr/include/allegro5/bitmap.h:35
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_new_bitmap_flags";

   function al_get_new_bitmap_format return int  -- /usr/include/allegro5/bitmap.h:36
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_new_bitmap_format";

   function al_get_new_bitmap_flags return int  -- /usr/include/allegro5/bitmap.h:37
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_new_bitmap_flags";

   procedure al_add_new_bitmap_flag (flag : int)  -- /usr/include/allegro5/bitmap.h:38
   with Import => True, 
        Convention => C, 
        External_Name => "al_add_new_bitmap_flag";

   function al_get_bitmap_width (bitmap : access ALLEGRO_BITMAP) return int  -- /usr/include/allegro5/bitmap.h:47
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_bitmap_width";

   function al_get_bitmap_height (bitmap : access ALLEGRO_BITMAP) return int  -- /usr/include/allegro5/bitmap.h:48
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_bitmap_height";

   function al_get_bitmap_format (bitmap : access ALLEGRO_BITMAP) return int  -- /usr/include/allegro5/bitmap.h:49
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_bitmap_format";

   function al_get_bitmap_flags (bitmap : access ALLEGRO_BITMAP) return int  -- /usr/include/allegro5/bitmap.h:50
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_bitmap_flags";

   function al_create_bitmap (w : int; h : int) return access ALLEGRO_BITMAP  -- /usr/include/allegro5/bitmap.h:57
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_bitmap";

   procedure al_destroy_bitmap (bitmap : access ALLEGRO_BITMAP)  -- /usr/include/allegro5/bitmap.h:58
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_bitmap";

   procedure al_put_pixel
     (x : int;
      y : int;
      color : allegro5_color_h.ALLEGRO_COLOR)  -- /usr/include/allegro5/bitmap.h:60
   with Import => True, 
        Convention => C, 
        External_Name => "al_put_pixel";

   procedure al_put_blended_pixel
     (x : int;
      y : int;
      color : allegro5_color_h.ALLEGRO_COLOR)  -- /usr/include/allegro5/bitmap.h:61
   with Import => True, 
        Convention => C, 
        External_Name => "al_put_blended_pixel";

   function al_get_pixel
     (bitmap : access ALLEGRO_BITMAP;
      x : int;
      y : int) return allegro5_color_h.ALLEGRO_COLOR  -- /usr/include/allegro5/bitmap.h:62
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_pixel";

  -- Masking  
   procedure al_convert_mask_to_alpha (bitmap : access ALLEGRO_BITMAP; mask_color : allegro5_color_h.ALLEGRO_COLOR)  -- /usr/include/allegro5/bitmap.h:65
   with Import => True, 
        Convention => C, 
        External_Name => "al_convert_mask_to_alpha";

  -- Blending  
  -- Clipping  
   procedure al_set_clipping_rectangle
     (x : int;
      y : int;
      width : int;
      height : int)  -- /usr/include/allegro5/bitmap.h:79
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_clipping_rectangle";

   procedure al_reset_clipping_rectangle  -- /usr/include/allegro5/bitmap.h:80
   with Import => True, 
        Convention => C, 
        External_Name => "al_reset_clipping_rectangle";

   procedure al_get_clipping_rectangle
     (x : access int;
      y : access int;
      w : access int;
      h : access int)  -- /usr/include/allegro5/bitmap.h:81
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_clipping_rectangle";

  -- Sub bitmaps  
   function al_create_sub_bitmap
     (parent : access ALLEGRO_BITMAP;
      x : int;
      y : int;
      w : int;
      h : int) return access ALLEGRO_BITMAP  -- /usr/include/allegro5/bitmap.h:84
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_sub_bitmap";

   function al_is_sub_bitmap (bitmap : access ALLEGRO_BITMAP) return Extensions.bool  -- /usr/include/allegro5/bitmap.h:85
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_sub_bitmap";

   function al_get_parent_bitmap (bitmap : access ALLEGRO_BITMAP) return access ALLEGRO_BITMAP  -- /usr/include/allegro5/bitmap.h:86
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_parent_bitmap";

   function al_get_bitmap_x (bitmap : access ALLEGRO_BITMAP) return int  -- /usr/include/allegro5/bitmap.h:87
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_bitmap_x";

   function al_get_bitmap_y (bitmap : access ALLEGRO_BITMAP) return int  -- /usr/include/allegro5/bitmap.h:88
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_bitmap_y";

   procedure al_reparent_bitmap
     (bitmap : access ALLEGRO_BITMAP;
      parent : access ALLEGRO_BITMAP;
      x : int;
      y : int;
      w : int;
      h : int)  -- /usr/include/allegro5/bitmap.h:89
   with Import => True, 
        Convention => C, 
        External_Name => "al_reparent_bitmap";

  -- Miscellaneous  
   function al_clone_bitmap (bitmap : access ALLEGRO_BITMAP) return access ALLEGRO_BITMAP  -- /usr/include/allegro5/bitmap.h:93
   with Import => True, 
        Convention => C, 
        External_Name => "al_clone_bitmap";

   procedure al_convert_bitmap (bitmap : access ALLEGRO_BITMAP)  -- /usr/include/allegro5/bitmap.h:94
   with Import => True, 
        Convention => C, 
        External_Name => "al_convert_bitmap";

   procedure al_convert_memory_bitmaps  -- /usr/include/allegro5/bitmap.h:95
   with Import => True, 
        Convention => C, 
        External_Name => "al_convert_memory_bitmaps";

end allegro5_bitmap_h;

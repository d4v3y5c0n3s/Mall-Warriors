pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
limited with allegro5_bitmap_h;
with allegro5_color_h;

package allegro5_bitmap_draw_h is

  -- Flags for the blitting functions  
  -- Blitting  
   procedure al_draw_bitmap
     (bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      dx : float;
      dy : float;
      flags : int)  -- /usr/include/allegro5/bitmap_draw.h:18
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_bitmap";

   procedure al_draw_bitmap_region
     (bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      sx : float;
      sy : float;
      sw : float;
      sh : float;
      dx : float;
      dy : float;
      flags : int)  -- /usr/include/allegro5/bitmap_draw.h:19
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_bitmap_region";

   procedure al_draw_scaled_bitmap
     (bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      sx : float;
      sy : float;
      sw : float;
      sh : float;
      dx : float;
      dy : float;
      dw : float;
      dh : float;
      flags : int)  -- /usr/include/allegro5/bitmap_draw.h:20
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_scaled_bitmap";

   procedure al_draw_rotated_bitmap
     (bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      cx : float;
      cy : float;
      dx : float;
      dy : float;
      angle : float;
      flags : int)  -- /usr/include/allegro5/bitmap_draw.h:21
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_rotated_bitmap";

   procedure al_draw_scaled_rotated_bitmap
     (bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      cx : float;
      cy : float;
      dx : float;
      dy : float;
      xscale : float;
      yscale : float;
      angle : float;
      flags : int)  -- /usr/include/allegro5/bitmap_draw.h:22
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_scaled_rotated_bitmap";

  -- Tinted blitting  
   procedure al_draw_tinted_bitmap
     (bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      tint : allegro5_color_h.ALLEGRO_COLOR;
      dx : float;
      dy : float;
      flags : int)  -- /usr/include/allegro5/bitmap_draw.h:25
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_tinted_bitmap";

   procedure al_draw_tinted_bitmap_region
     (bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      tint : allegro5_color_h.ALLEGRO_COLOR;
      sx : float;
      sy : float;
      sw : float;
      sh : float;
      dx : float;
      dy : float;
      flags : int)  -- /usr/include/allegro5/bitmap_draw.h:26
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_tinted_bitmap_region";

   procedure al_draw_tinted_scaled_bitmap
     (bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      tint : allegro5_color_h.ALLEGRO_COLOR;
      sx : float;
      sy : float;
      sw : float;
      sh : float;
      dx : float;
      dy : float;
      dw : float;
      dh : float;
      flags : int)  -- /usr/include/allegro5/bitmap_draw.h:27
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_tinted_scaled_bitmap";

   procedure al_draw_tinted_rotated_bitmap
     (bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      tint : allegro5_color_h.ALLEGRO_COLOR;
      cx : float;
      cy : float;
      dx : float;
      dy : float;
      angle : float;
      flags : int)  -- /usr/include/allegro5/bitmap_draw.h:28
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_tinted_rotated_bitmap";

   procedure al_draw_tinted_scaled_rotated_bitmap
     (bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      tint : allegro5_color_h.ALLEGRO_COLOR;
      cx : float;
      cy : float;
      dx : float;
      dy : float;
      xscale : float;
      yscale : float;
      angle : float;
      flags : int)  -- /usr/include/allegro5/bitmap_draw.h:29
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_tinted_scaled_rotated_bitmap";

   procedure al_draw_tinted_scaled_rotated_bitmap_region
     (bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      sx : float;
      sy : float;
      sw : float;
      sh : float;
      tint : allegro5_color_h.ALLEGRO_COLOR;
      cx : float;
      cy : float;
      dx : float;
      dy : float;
      xscale : float;
      yscale : float;
      angle : float;
      flags : int)  -- /usr/include/allegro5/bitmap_draw.h:30
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_tinted_scaled_rotated_bitmap_region";

end allegro5_bitmap_draw_h;

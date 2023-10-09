pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with System;
limited with allegro5_bitmap_h;
with Interfaces.C.Extensions;

package allegro5_bitmap_lock_h is

  -- * Locking flags
  --  

  -- Type: ALLEGRO_LOCKED_REGION
  --  

   type ALLEGRO_LOCKED_REGION;
   type ALLEGRO_LOCKED_REGION is record
      data : System.Address;  -- /usr/include/allegro5/bitmap_lock.h:25
      format : aliased int;  -- /usr/include/allegro5/bitmap_lock.h:26
      pitch : aliased int;  -- /usr/include/allegro5/bitmap_lock.h:27
      pixel_size : aliased int;  -- /usr/include/allegro5/bitmap_lock.h:28
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/bitmap_lock.h:24

   function al_lock_bitmap
     (bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      format : int;
      flags : int) return access ALLEGRO_LOCKED_REGION  -- /usr/include/allegro5/bitmap_lock.h:32
   with Import => True, 
        Convention => C, 
        External_Name => "al_lock_bitmap";

   function al_lock_bitmap_region
     (bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      x : int;
      y : int;
      width : int;
      height : int;
      format : int;
      flags : int) return access ALLEGRO_LOCKED_REGION  -- /usr/include/allegro5/bitmap_lock.h:33
   with Import => True, 
        Convention => C, 
        External_Name => "al_lock_bitmap_region";

   function al_lock_bitmap_blocked (bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP; flags : int) return access ALLEGRO_LOCKED_REGION  -- /usr/include/allegro5/bitmap_lock.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "al_lock_bitmap_blocked";

   function al_lock_bitmap_region_blocked
     (bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      x_block : int;
      y_block : int;
      width_block : int;
      height_block : int;
      flags : int) return access ALLEGRO_LOCKED_REGION  -- /usr/include/allegro5/bitmap_lock.h:35
   with Import => True, 
        Convention => C, 
        External_Name => "al_lock_bitmap_region_blocked";

   procedure al_unlock_bitmap (bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP)  -- /usr/include/allegro5/bitmap_lock.h:37
   with Import => True, 
        Convention => C, 
        External_Name => "al_unlock_bitmap";

   function al_is_bitmap_locked (bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP) return Extensions.bool  -- /usr/include/allegro5/bitmap_lock.h:38
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_bitmap_locked";

end allegro5_bitmap_lock_h;

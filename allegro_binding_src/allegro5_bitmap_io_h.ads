pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
limited with allegro5_bitmap_h;
limited with allegro5_file_h;
with Interfaces.C.Extensions;

package allegro5_bitmap_io_h is

  -- * Bitmap loader flag
  --  

  -- was a bitmap flag in 5.0  
  -- was a bitmap flag in 5.0  
   type ALLEGRO_IIO_LOADER_FUNCTION is access function (arg1 : Interfaces.C.Strings.chars_ptr; arg2 : int) return access allegro5_bitmap_h.ALLEGRO_BITMAP
   with Convention => C;  -- /usr/include/allegro5/bitmap_io.h:20

   type ALLEGRO_IIO_FS_LOADER_FUNCTION is access function (arg1 : access allegro5_file_h.ALLEGRO_FILE; arg2 : int) return access allegro5_bitmap_h.ALLEGRO_BITMAP
   with Convention => C;  -- /usr/include/allegro5/bitmap_io.h:21

   type ALLEGRO_IIO_SAVER_FUNCTION is access function (arg1 : Interfaces.C.Strings.chars_ptr; arg2 : access allegro5_bitmap_h.ALLEGRO_BITMAP) return Extensions.bool
   with Convention => C;  -- /usr/include/allegro5/bitmap_io.h:22

   type ALLEGRO_IIO_FS_SAVER_FUNCTION is access function (arg1 : access allegro5_file_h.ALLEGRO_FILE; arg2 : access allegro5_bitmap_h.ALLEGRO_BITMAP) return Extensions.bool
   with Convention => C;  -- /usr/include/allegro5/bitmap_io.h:23

   type ALLEGRO_IIO_IDENTIFIER_FUNCTION is access function (arg1 : access allegro5_file_h.ALLEGRO_FILE) return Extensions.bool
   with Convention => C;  -- /usr/include/allegro5/bitmap_io.h:24

   function al_register_bitmap_loader (ext : Interfaces.C.Strings.chars_ptr; loader : ALLEGRO_IIO_LOADER_FUNCTION) return Extensions.bool  -- /usr/include/allegro5/bitmap_io.h:26
   with Import => True, 
        Convention => C, 
        External_Name => "al_register_bitmap_loader";

   function al_register_bitmap_saver (ext : Interfaces.C.Strings.chars_ptr; saver : ALLEGRO_IIO_SAVER_FUNCTION) return Extensions.bool  -- /usr/include/allegro5/bitmap_io.h:27
   with Import => True, 
        Convention => C, 
        External_Name => "al_register_bitmap_saver";

   function al_register_bitmap_loader_f (ext : Interfaces.C.Strings.chars_ptr; fs_loader : ALLEGRO_IIO_FS_LOADER_FUNCTION) return Extensions.bool  -- /usr/include/allegro5/bitmap_io.h:28
   with Import => True, 
        Convention => C, 
        External_Name => "al_register_bitmap_loader_f";

   function al_register_bitmap_saver_f (ext : Interfaces.C.Strings.chars_ptr; fs_saver : ALLEGRO_IIO_FS_SAVER_FUNCTION) return Extensions.bool  -- /usr/include/allegro5/bitmap_io.h:29
   with Import => True, 
        Convention => C, 
        External_Name => "al_register_bitmap_saver_f";

   function al_register_bitmap_identifier (ext : Interfaces.C.Strings.chars_ptr; identifier : ALLEGRO_IIO_IDENTIFIER_FUNCTION) return Extensions.bool  -- /usr/include/allegro5/bitmap_io.h:30
   with Import => True, 
        Convention => C, 
        External_Name => "al_register_bitmap_identifier";

   function al_load_bitmap (filename : Interfaces.C.Strings.chars_ptr) return access allegro5_bitmap_h.ALLEGRO_BITMAP  -- /usr/include/allegro5/bitmap_io.h:32
   with Import => True, 
        Convention => C, 
        External_Name => "al_load_bitmap";

   function al_load_bitmap_flags (filename : Interfaces.C.Strings.chars_ptr; flags : int) return access allegro5_bitmap_h.ALLEGRO_BITMAP  -- /usr/include/allegro5/bitmap_io.h:33
   with Import => True, 
        Convention => C, 
        External_Name => "al_load_bitmap_flags";

   function al_load_bitmap_f (fp : access allegro5_file_h.ALLEGRO_FILE; ident : Interfaces.C.Strings.chars_ptr) return access allegro5_bitmap_h.ALLEGRO_BITMAP  -- /usr/include/allegro5/bitmap_io.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "al_load_bitmap_f";

   function al_load_bitmap_flags_f
     (fp : access allegro5_file_h.ALLEGRO_FILE;
      ident : Interfaces.C.Strings.chars_ptr;
      flags : int) return access allegro5_bitmap_h.ALLEGRO_BITMAP  -- /usr/include/allegro5/bitmap_io.h:35
   with Import => True, 
        Convention => C, 
        External_Name => "al_load_bitmap_flags_f";

   function al_save_bitmap (filename : Interfaces.C.Strings.chars_ptr; bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP) return Extensions.bool  -- /usr/include/allegro5/bitmap_io.h:36
   with Import => True, 
        Convention => C, 
        External_Name => "al_save_bitmap";

   function al_save_bitmap_f
     (fp : access allegro5_file_h.ALLEGRO_FILE;
      ident : Interfaces.C.Strings.chars_ptr;
      bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP) return Extensions.bool  -- /usr/include/allegro5/bitmap_io.h:37
   with Import => True, 
        Convention => C, 
        External_Name => "al_save_bitmap_f";

   function al_identify_bitmap_f (fp : access allegro5_file_h.ALLEGRO_FILE) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/bitmap_io.h:38
   with Import => True, 
        Convention => C, 
        External_Name => "al_identify_bitmap_f";

   function al_identify_bitmap (filename : Interfaces.C.Strings.chars_ptr) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/bitmap_io.h:39
   with Import => True, 
        Convention => C, 
        External_Name => "al_identify_bitmap";

  -- vim: set sts=3 sw=3 et:  
end allegro5_bitmap_io_h;

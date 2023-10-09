pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;
with allegro5_utf8_h;

package allegro5_path_h is

   ALLEGRO_NATIVE_PATH_SEP : aliased constant Character := '/';  --  /usr/include/allegro5/path.h:16
   ALLEGRO_NATIVE_DRIVE_SEP : aliased constant Character := Character'Val (0);  --  /usr/include/allegro5/path.h:17

   type ALLEGRO_PATH is null record;   -- incomplete struct

   function al_create_path (str : Interfaces.C.Strings.chars_ptr) return access ALLEGRO_PATH  -- /usr/include/allegro5/path.h:22
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_path";

   function al_create_path_for_directory (str : Interfaces.C.Strings.chars_ptr) return access ALLEGRO_PATH  -- /usr/include/allegro5/path.h:23
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_path_for_directory";

   function al_clone_path (path : access constant ALLEGRO_PATH) return access ALLEGRO_PATH  -- /usr/include/allegro5/path.h:24
   with Import => True, 
        Convention => C, 
        External_Name => "al_clone_path";

   function al_get_path_num_components (path : access constant ALLEGRO_PATH) return int  -- /usr/include/allegro5/path.h:26
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_path_num_components";

   function al_get_path_component (path : access constant ALLEGRO_PATH; i : int) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/path.h:27
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_path_component";

   procedure al_replace_path_component
     (path : access ALLEGRO_PATH;
      i : int;
      s : Interfaces.C.Strings.chars_ptr)  -- /usr/include/allegro5/path.h:28
   with Import => True, 
        Convention => C, 
        External_Name => "al_replace_path_component";

   procedure al_remove_path_component (path : access ALLEGRO_PATH; i : int)  -- /usr/include/allegro5/path.h:29
   with Import => True, 
        Convention => C, 
        External_Name => "al_remove_path_component";

   procedure al_insert_path_component
     (path : access ALLEGRO_PATH;
      i : int;
      s : Interfaces.C.Strings.chars_ptr)  -- /usr/include/allegro5/path.h:30
   with Import => True, 
        Convention => C, 
        External_Name => "al_insert_path_component";

   function al_get_path_tail (path : access constant ALLEGRO_PATH) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/path.h:31
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_path_tail";

   procedure al_drop_path_tail (path : access ALLEGRO_PATH)  -- /usr/include/allegro5/path.h:32
   with Import => True, 
        Convention => C, 
        External_Name => "al_drop_path_tail";

   procedure al_append_path_component (path : access ALLEGRO_PATH; s : Interfaces.C.Strings.chars_ptr)  -- /usr/include/allegro5/path.h:33
   with Import => True, 
        Convention => C, 
        External_Name => "al_append_path_component";

   function al_join_paths (path : access ALLEGRO_PATH; tail : access constant ALLEGRO_PATH) return Extensions.bool  -- /usr/include/allegro5/path.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "al_join_paths";

   function al_rebase_path (head : access constant ALLEGRO_PATH; tail : access ALLEGRO_PATH) return Extensions.bool  -- /usr/include/allegro5/path.h:35
   with Import => True, 
        Convention => C, 
        External_Name => "al_rebase_path";

   function al_path_cstr (path : access constant ALLEGRO_PATH; delim : char) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/path.h:36
   with Import => True, 
        Convention => C, 
        External_Name => "al_path_cstr";

   function al_path_ustr (path : access constant ALLEGRO_PATH; delim : char) return access constant allegro5_utf8_h.ALLEGRO_USTR  -- /usr/include/allegro5/path.h:37
   with Import => True, 
        Convention => C, 
        External_Name => "al_path_ustr";

   procedure al_destroy_path (path : access ALLEGRO_PATH)  -- /usr/include/allegro5/path.h:38
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_path";

   procedure al_set_path_drive (path : access ALLEGRO_PATH; drive : Interfaces.C.Strings.chars_ptr)  -- /usr/include/allegro5/path.h:40
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_path_drive";

   function al_get_path_drive (path : access constant ALLEGRO_PATH) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/path.h:41
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_path_drive";

   procedure al_set_path_filename (path : access ALLEGRO_PATH; filename : Interfaces.C.Strings.chars_ptr)  -- /usr/include/allegro5/path.h:43
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_path_filename";

   function al_get_path_filename (path : access constant ALLEGRO_PATH) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/path.h:44
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_path_filename";

   function al_get_path_extension (path : access constant ALLEGRO_PATH) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/path.h:46
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_path_extension";

   function al_set_path_extension (path : access ALLEGRO_PATH; extension : Interfaces.C.Strings.chars_ptr) return Extensions.bool  -- /usr/include/allegro5/path.h:47
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_path_extension";

   function al_get_path_basename (path : access constant ALLEGRO_PATH) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/path.h:48
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_path_basename";

   function al_make_path_canonical (path : access ALLEGRO_PATH) return Extensions.bool  -- /usr/include/allegro5/path.h:50
   with Import => True, 
        Convention => C, 
        External_Name => "al_make_path_canonical";

end allegro5_path_h;

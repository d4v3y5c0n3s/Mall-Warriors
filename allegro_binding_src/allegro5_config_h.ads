pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
limited with allegro5_file_h;
with Interfaces.C.Extensions;
with System;

package allegro5_config_h is

  -- Type: ALLEGRO_CONFIG
  --  

   type ALLEGRO_CONFIG is null record;   -- incomplete struct

  -- Type: ALLEGRO_CONFIG_SECTION
  --  

   type ALLEGRO_CONFIG_SECTION is null record;   -- incomplete struct

  -- Type: ALLEGRO_CONFIG_ENTRY
  --  

   type ALLEGRO_CONFIG_ENTRY is null record;   -- incomplete struct

   function al_create_config return access ALLEGRO_CONFIG  -- /usr/include/allegro5/config.h:22
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_config";

   procedure al_add_config_section (config : access ALLEGRO_CONFIG; name : Interfaces.C.Strings.chars_ptr)  -- /usr/include/allegro5/config.h:23
   with Import => True, 
        Convention => C, 
        External_Name => "al_add_config_section";

   procedure al_set_config_value
     (config : access ALLEGRO_CONFIG;
      section : Interfaces.C.Strings.chars_ptr;
      key : Interfaces.C.Strings.chars_ptr;
      value : Interfaces.C.Strings.chars_ptr)  -- /usr/include/allegro5/config.h:24
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_config_value";

   procedure al_add_config_comment
     (config : access ALLEGRO_CONFIG;
      section : Interfaces.C.Strings.chars_ptr;
      comment : Interfaces.C.Strings.chars_ptr)  -- /usr/include/allegro5/config.h:25
   with Import => True, 
        Convention => C, 
        External_Name => "al_add_config_comment";

   function al_get_config_value
     (config : access constant ALLEGRO_CONFIG;
      section : Interfaces.C.Strings.chars_ptr;
      key : Interfaces.C.Strings.chars_ptr) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/config.h:26
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_config_value";

   function al_load_config_file (filename : Interfaces.C.Strings.chars_ptr) return access ALLEGRO_CONFIG  -- /usr/include/allegro5/config.h:27
   with Import => True, 
        Convention => C, 
        External_Name => "al_load_config_file";

   function al_load_config_file_f (filename : access allegro5_file_h.ALLEGRO_FILE) return access ALLEGRO_CONFIG  -- /usr/include/allegro5/config.h:28
   with Import => True, 
        Convention => C, 
        External_Name => "al_load_config_file_f";

   function al_save_config_file (filename : Interfaces.C.Strings.chars_ptr; config : access constant ALLEGRO_CONFIG) return Extensions.bool  -- /usr/include/allegro5/config.h:29
   with Import => True, 
        Convention => C, 
        External_Name => "al_save_config_file";

   function al_save_config_file_f (file : access allegro5_file_h.ALLEGRO_FILE; config : access constant ALLEGRO_CONFIG) return Extensions.bool  -- /usr/include/allegro5/config.h:30
   with Import => True, 
        Convention => C, 
        External_Name => "al_save_config_file_f";

   procedure al_merge_config_into (master : access ALLEGRO_CONFIG; add : access constant ALLEGRO_CONFIG)  -- /usr/include/allegro5/config.h:31
   with Import => True, 
        Convention => C, 
        External_Name => "al_merge_config_into";

   function al_merge_config (cfg1 : access constant ALLEGRO_CONFIG; cfg2 : access constant ALLEGRO_CONFIG) return access ALLEGRO_CONFIG  -- /usr/include/allegro5/config.h:32
   with Import => True, 
        Convention => C, 
        External_Name => "al_merge_config";

   procedure al_destroy_config (config : access ALLEGRO_CONFIG)  -- /usr/include/allegro5/config.h:33
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_config";

   function al_remove_config_section (config : access ALLEGRO_CONFIG; section : Interfaces.C.Strings.chars_ptr) return Extensions.bool  -- /usr/include/allegro5/config.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "al_remove_config_section";

   function al_remove_config_key
     (config : access ALLEGRO_CONFIG;
      section : Interfaces.C.Strings.chars_ptr;
      key : Interfaces.C.Strings.chars_ptr) return Extensions.bool  -- /usr/include/allegro5/config.h:36
   with Import => True, 
        Convention => C, 
        External_Name => "al_remove_config_key";

   function al_get_first_config_section (config : access constant ALLEGRO_CONFIG; iterator : System.Address) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/config.h:39
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_first_config_section";

   function al_get_next_config_section (iterator : System.Address) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/config.h:40
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_next_config_section";

   function al_get_first_config_entry
     (config : access constant ALLEGRO_CONFIG;
      section : Interfaces.C.Strings.chars_ptr;
      iterator : System.Address) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/config.h:41
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_first_config_entry";

   function al_get_next_config_entry (iterator : System.Address) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/config.h:43
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_next_config_entry";

end allegro5_config_h;

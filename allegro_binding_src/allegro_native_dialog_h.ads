pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with x86_64_linux_gnu_bits_stdint_uintn_h;
limited with allegro5_bitmap_h;
with Interfaces.C.Extensions;
limited with allegro5_display_h;
with stddef_h;
limited with allegro5_events_h;
with System;

package allegro_native_dialog_h is

   --  unsupported macro: ALLEGRO_DIALOG_FUNC AL_FUNC
   --  unsupported macro: ALLEGRO_GTK_TOPLEVEL ALLEGRO_GTK_TOPLEVEL_INTERNAL
   --  unsupported macro: ALLEGRO_MENU_SEPARATOR { NULL, -1, 0, NULL }
   --  arg-macro: procedure ALLEGRO_START_OF_MENU (caption, id)
   --    { caption "->", id, 0, NULL }
   --  unsupported macro: ALLEGRO_END_OF_MENU { NULL, 0, 0, NULL }
  -- Type: ALLEGRO_FILECHOOSER
  --  

   type ALLEGRO_FILECHOOSER is null record;   -- incomplete struct

  -- Type: ALLEGRO_TEXTLOG
  --  

   type ALLEGRO_TEXTLOG is null record;   -- incomplete struct

  -- Type: ALLEGRO_MENU
  --  

   type ALLEGRO_MENU is null record;   -- incomplete struct

  -- Type: ALLEGRO_MENU_INFO
  --  

   type ALLEGRO_MENU_INFO is record
      caption : Interfaces.C.Strings.chars_ptr;  -- addons/native_dialog/allegro5/allegro_native_dialog.h:51
      id : aliased x86_64_linux_gnu_bits_stdint_uintn_h.uint16_t;  -- addons/native_dialog/allegro5/allegro_native_dialog.h:52
      flags : aliased int;  -- addons/native_dialog/allegro5/allegro_native_dialog.h:53
      icon : access allegro5_bitmap_h.ALLEGRO_BITMAP;  -- addons/native_dialog/allegro5/allegro_native_dialog.h:54
   end record
   with Convention => C_Pass_By_Copy;  -- addons/native_dialog/allegro5/allegro_native_dialog.h:50

   function al_init_native_dialog_addon return Extensions.bool  -- addons/native_dialog/allegro5/allegro_native_dialog.h:61
   with Import => True, 
        Convention => C, 
        External_Name => "al_init_native_dialog_addon";

   function al_is_native_dialog_addon_initialized return Extensions.bool  -- addons/native_dialog/allegro5/allegro_native_dialog.h:62
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_native_dialog_addon_initialized";

   procedure al_shutdown_native_dialog_addon  -- addons/native_dialog/allegro5/allegro_native_dialog.h:63
   with Import => True, 
        Convention => C, 
        External_Name => "al_shutdown_native_dialog_addon";

   function al_create_native_file_dialog
     (initial_path : Interfaces.C.Strings.chars_ptr;
      title : Interfaces.C.Strings.chars_ptr;
      patterns : Interfaces.C.Strings.chars_ptr;
      mode : int) return access ALLEGRO_FILECHOOSER  -- addons/native_dialog/allegro5/allegro_native_dialog.h:65
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_native_file_dialog";

   function al_show_native_file_dialog (display : access allegro5_display_h.ALLEGRO_DISPLAY; dialog : access ALLEGRO_FILECHOOSER) return Extensions.bool  -- addons/native_dialog/allegro5/allegro_native_dialog.h:67
   with Import => True, 
        Convention => C, 
        External_Name => "al_show_native_file_dialog";

   function al_get_native_file_dialog_count (dialog : access constant ALLEGRO_FILECHOOSER) return int  -- addons/native_dialog/allegro5/allegro_native_dialog.h:68
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_native_file_dialog_count";

   function al_get_native_file_dialog_path (dialog : access constant ALLEGRO_FILECHOOSER; index : stddef_h.size_t) return Interfaces.C.Strings.chars_ptr  -- addons/native_dialog/allegro5/allegro_native_dialog.h:69
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_native_file_dialog_path";

   procedure al_destroy_native_file_dialog (dialog : access ALLEGRO_FILECHOOSER)  -- addons/native_dialog/allegro5/allegro_native_dialog.h:71
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_native_file_dialog";

   function al_show_native_message_box
     (display : access allegro5_display_h.ALLEGRO_DISPLAY;
      title : Interfaces.C.Strings.chars_ptr;
      heading : Interfaces.C.Strings.chars_ptr;
      text : Interfaces.C.Strings.chars_ptr;
      buttons : Interfaces.C.Strings.chars_ptr;
      flags : int) return int  -- addons/native_dialog/allegro5/allegro_native_dialog.h:73
   with Import => True, 
        Convention => C, 
        External_Name => "al_show_native_message_box";

   function al_open_native_text_log (title : Interfaces.C.Strings.chars_ptr; flags : int) return access ALLEGRO_TEXTLOG  -- addons/native_dialog/allegro5/allegro_native_dialog.h:76
   with Import => True, 
        Convention => C, 
        External_Name => "al_open_native_text_log";

   procedure al_close_native_text_log (textlog : access ALLEGRO_TEXTLOG)  -- addons/native_dialog/allegro5/allegro_native_dialog.h:77
   with Import => True, 
        Convention => C, 
        External_Name => "al_close_native_text_log";

   procedure al_append_native_text_log (textlog : access ALLEGRO_TEXTLOG; format : Interfaces.C.Strings.chars_ptr  -- , ...
      )  -- addons/native_dialog/allegro5/allegro_native_dialog.h:78
   with Import => True, 
        Convention => C, 
        External_Name => "al_append_native_text_log";

   function al_get_native_text_log_event_source (textlog : access ALLEGRO_TEXTLOG) return access allegro5_events_h.ALLEGRO_EVENT_SOURCE  -- addons/native_dialog/allegro5/allegro_native_dialog.h:79
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_native_text_log_event_source";

  -- creating/modifying menus  
   function al_create_menu return access ALLEGRO_MENU  -- addons/native_dialog/allegro5/allegro_native_dialog.h:82
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_menu";

   function al_create_popup_menu return access ALLEGRO_MENU  -- addons/native_dialog/allegro5/allegro_native_dialog.h:83
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_popup_menu";

   function al_build_menu (info : access ALLEGRO_MENU_INFO) return access ALLEGRO_MENU  -- addons/native_dialog/allegro5/allegro_native_dialog.h:84
   with Import => True, 
        Convention => C, 
        External_Name => "al_build_menu";

   function al_append_menu_item
     (parent : access ALLEGRO_MENU;
      title : Interfaces.C.Strings.chars_ptr;
      id : x86_64_linux_gnu_bits_stdint_uintn_h.uint16_t;
      flags : int;
      icon : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      submenu : access ALLEGRO_MENU) return int  -- addons/native_dialog/allegro5/allegro_native_dialog.h:85
   with Import => True, 
        Convention => C, 
        External_Name => "al_append_menu_item";

   function al_insert_menu_item
     (parent : access ALLEGRO_MENU;
      pos : int;
      title : Interfaces.C.Strings.chars_ptr;
      id : x86_64_linux_gnu_bits_stdint_uintn_h.uint16_t;
      flags : int;
      icon : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      submenu : access ALLEGRO_MENU) return int  -- addons/native_dialog/allegro5/allegro_native_dialog.h:87
   with Import => True, 
        Convention => C, 
        External_Name => "al_insert_menu_item";

   function al_remove_menu_item (menu : access ALLEGRO_MENU; pos : int) return Extensions.bool  -- addons/native_dialog/allegro5/allegro_native_dialog.h:89
   with Import => True, 
        Convention => C, 
        External_Name => "al_remove_menu_item";

   function al_clone_menu (menu : access ALLEGRO_MENU) return access ALLEGRO_MENU  -- addons/native_dialog/allegro5/allegro_native_dialog.h:90
   with Import => True, 
        Convention => C, 
        External_Name => "al_clone_menu";

   function al_clone_menu_for_popup (menu : access ALLEGRO_MENU) return access ALLEGRO_MENU  -- addons/native_dialog/allegro5/allegro_native_dialog.h:91
   with Import => True, 
        Convention => C, 
        External_Name => "al_clone_menu_for_popup";

   procedure al_destroy_menu (menu : access ALLEGRO_MENU)  -- addons/native_dialog/allegro5/allegro_native_dialog.h:92
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_menu";

  -- properties  
   function al_get_menu_item_caption (menu : access ALLEGRO_MENU; pos : int) return Interfaces.C.Strings.chars_ptr  -- addons/native_dialog/allegro5/allegro_native_dialog.h:95
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_menu_item_caption";

   procedure al_set_menu_item_caption
     (menu : access ALLEGRO_MENU;
      pos : int;
      caption : Interfaces.C.Strings.chars_ptr)  -- addons/native_dialog/allegro5/allegro_native_dialog.h:96
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_menu_item_caption";

   function al_get_menu_item_flags (menu : access ALLEGRO_MENU; pos : int) return int  -- addons/native_dialog/allegro5/allegro_native_dialog.h:97
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_menu_item_flags";

   procedure al_set_menu_item_flags
     (menu : access ALLEGRO_MENU;
      pos : int;
      flags : int)  -- addons/native_dialog/allegro5/allegro_native_dialog.h:98
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_menu_item_flags";

   function al_get_menu_item_icon (menu : access ALLEGRO_MENU; pos : int) return access allegro5_bitmap_h.ALLEGRO_BITMAP  -- addons/native_dialog/allegro5/allegro_native_dialog.h:99
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_menu_item_icon";

   procedure al_set_menu_item_icon
     (menu : access ALLEGRO_MENU;
      pos : int;
      icon : access allegro5_bitmap_h.ALLEGRO_BITMAP)  -- addons/native_dialog/allegro5/allegro_native_dialog.h:100
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_menu_item_icon";

  -- querying menus  
   function al_find_menu (haystack : access ALLEGRO_MENU; id : x86_64_linux_gnu_bits_stdint_uintn_h.uint16_t) return access ALLEGRO_MENU  -- addons/native_dialog/allegro5/allegro_native_dialog.h:107
   with Import => True, 
        Convention => C, 
        External_Name => "al_find_menu";

   function al_find_menu_item
     (haystack : access ALLEGRO_MENU;
      id : x86_64_linux_gnu_bits_stdint_uintn_h.uint16_t;
      menu : System.Address;
      index : access int) return Extensions.bool  -- addons/native_dialog/allegro5/allegro_native_dialog.h:108
   with Import => True, 
        Convention => C, 
        External_Name => "al_find_menu_item";

  -- menu events  
   function al_get_default_menu_event_source return access allegro5_events_h.ALLEGRO_EVENT_SOURCE  -- addons/native_dialog/allegro5/allegro_native_dialog.h:111
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_default_menu_event_source";

   function al_enable_menu_event_source (menu : access ALLEGRO_MENU) return access allegro5_events_h.ALLEGRO_EVENT_SOURCE  -- addons/native_dialog/allegro5/allegro_native_dialog.h:112
   with Import => True, 
        Convention => C, 
        External_Name => "al_enable_menu_event_source";

   procedure al_disable_menu_event_source (menu : access ALLEGRO_MENU)  -- addons/native_dialog/allegro5/allegro_native_dialog.h:113
   with Import => True, 
        Convention => C, 
        External_Name => "al_disable_menu_event_source";

  -- displaying menus  
   function al_get_display_menu (display : access allegro5_display_h.ALLEGRO_DISPLAY) return access ALLEGRO_MENU  -- addons/native_dialog/allegro5/allegro_native_dialog.h:116
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_display_menu";

   function al_set_display_menu (display : access allegro5_display_h.ALLEGRO_DISPLAY; menu : access ALLEGRO_MENU) return Extensions.bool  -- addons/native_dialog/allegro5/allegro_native_dialog.h:117
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_display_menu";

   function al_popup_menu (popup : access ALLEGRO_MENU; display : access allegro5_display_h.ALLEGRO_DISPLAY) return Extensions.bool  -- addons/native_dialog/allegro5/allegro_native_dialog.h:118
   with Import => True, 
        Convention => C, 
        External_Name => "al_popup_menu";

   function al_remove_display_menu (display : access allegro5_display_h.ALLEGRO_DISPLAY) return access ALLEGRO_MENU  -- addons/native_dialog/allegro5/allegro_native_dialog.h:119
   with Import => True, 
        Convention => C, 
        External_Name => "al_remove_display_menu";

   function al_get_allegro_native_dialog_version return x86_64_linux_gnu_bits_stdint_uintn_h.uint32_t  -- addons/native_dialog/allegro5/allegro_native_dialog.h:121
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_allegro_native_dialog_version";

  -- vim: set sts=3 sw=3 et:  
end allegro_native_dialog_h;

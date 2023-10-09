pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;
with x86_64_linux_gnu_bits_stdint_uintn_h;
with x86_64_linux_gnu_bits_types_time_t_h;
with x86_64_linux_gnu_sys_types_h;
limited with allegro5_file_h;
with System;

package allegro5_fshook_h is

   EOF : constant := (-1);  --  /usr/include/allegro5/fshook.h:58

  --         ______   ___    ___
  -- *        /\  _  \ /\_ \  /\_  *        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
  --_
  -- *         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __` *          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\  *           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
  --__/
  -- *            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
  -- *                                           /\____/
  -- *                                           \_/__/
  -- *
  -- *      File System Hooks.
  -- *
  -- *      See readme.txt for copyright information.
  --  

  -- 4 Gig max offsets if sys/types doesn't exist.  
  -- Type: ALLEGRO_FS_ENTRY
  --  

   type ALLEGRO_FS_ENTRY;
   type ALLEGRO_FS_INTERFACE;
   type ALLEGRO_FS_ENTRY is record
      vtable : access constant ALLEGRO_FS_INTERFACE;  -- /usr/include/allegro5/fshook.h:40
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/fshook.h:39

  -- Enum: ALLEGRO_FILE_MODE
  --  

   subtype ALLEGRO_FILE_MODE is unsigned;
   ALLEGRO_FILEMODE_READ : constant unsigned := 1;
   ALLEGRO_FILEMODE_WRITE : constant unsigned := 2;
   ALLEGRO_FILEMODE_EXECUTE : constant unsigned := 4;
   ALLEGRO_FILEMODE_HIDDEN : constant unsigned := 8;
   ALLEGRO_FILEMODE_ISFILE : constant unsigned := 16;
   ALLEGRO_FILEMODE_ISDIR : constant unsigned := 32;  -- /usr/include/allegro5/fshook.h:46

  -- Type: ALLEGRO_FS_INTERFACE
  --  

   type ALLEGRO_FS_INTERFACE is record
      fs_create_entry : access function (arg1 : Interfaces.C.Strings.chars_ptr) return access ALLEGRO_FS_ENTRY;  -- /usr/include/allegro5/fshook.h:67
      fs_destroy_entry : access procedure (arg1 : access ALLEGRO_FS_ENTRY);  -- /usr/include/allegro5/fshook.h:68
      fs_entry_name : access function (arg1 : access ALLEGRO_FS_ENTRY) return Interfaces.C.Strings.chars_ptr;  -- /usr/include/allegro5/fshook.h:69
      fs_update_entry : access function (arg1 : access ALLEGRO_FS_ENTRY) return Extensions.bool;  -- /usr/include/allegro5/fshook.h:70
      fs_entry_mode : access function (arg1 : access ALLEGRO_FS_ENTRY) return x86_64_linux_gnu_bits_stdint_uintn_h.uint32_t;  -- /usr/include/allegro5/fshook.h:71
      fs_entry_atime : access function (arg1 : access ALLEGRO_FS_ENTRY) return x86_64_linux_gnu_bits_types_time_t_h.time_t;  -- /usr/include/allegro5/fshook.h:72
      fs_entry_mtime : access function (arg1 : access ALLEGRO_FS_ENTRY) return x86_64_linux_gnu_bits_types_time_t_h.time_t;  -- /usr/include/allegro5/fshook.h:73
      fs_entry_ctime : access function (arg1 : access ALLEGRO_FS_ENTRY) return x86_64_linux_gnu_bits_types_time_t_h.time_t;  -- /usr/include/allegro5/fshook.h:74
      fs_entry_size : access function (arg1 : access ALLEGRO_FS_ENTRY) return x86_64_linux_gnu_sys_types_h.off_t;  -- /usr/include/allegro5/fshook.h:75
      fs_entry_exists : access function (arg1 : access ALLEGRO_FS_ENTRY) return Extensions.bool;  -- /usr/include/allegro5/fshook.h:76
      fs_remove_entry : access function (arg1 : access ALLEGRO_FS_ENTRY) return Extensions.bool;  -- /usr/include/allegro5/fshook.h:77
      fs_open_directory : access function (arg1 : access ALLEGRO_FS_ENTRY) return Extensions.bool;  -- /usr/include/allegro5/fshook.h:79
      fs_read_directory : access function (arg1 : access ALLEGRO_FS_ENTRY) return access ALLEGRO_FS_ENTRY;  -- /usr/include/allegro5/fshook.h:80
      fs_close_directory : access function (arg1 : access ALLEGRO_FS_ENTRY) return Extensions.bool;  -- /usr/include/allegro5/fshook.h:81
      fs_filename_exists : access function (arg1 : Interfaces.C.Strings.chars_ptr) return Extensions.bool;  -- /usr/include/allegro5/fshook.h:83
      fs_remove_filename : access function (arg1 : Interfaces.C.Strings.chars_ptr) return Extensions.bool;  -- /usr/include/allegro5/fshook.h:84
      fs_get_current_directory : access function return Interfaces.C.Strings.chars_ptr;  -- /usr/include/allegro5/fshook.h:85
      fs_change_directory : access function (arg1 : Interfaces.C.Strings.chars_ptr) return Extensions.bool;  -- /usr/include/allegro5/fshook.h:86
      fs_make_directory : access function (arg1 : Interfaces.C.Strings.chars_ptr) return Extensions.bool;  -- /usr/include/allegro5/fshook.h:87
      fs_open_file : access function (arg1 : access ALLEGRO_FS_ENTRY; arg2 : Interfaces.C.Strings.chars_ptr) return access allegro5_file_h.ALLEGRO_FILE;  -- /usr/include/allegro5/fshook.h:89
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/fshook.h:66

   function al_create_fs_entry (path : Interfaces.C.Strings.chars_ptr) return access ALLEGRO_FS_ENTRY  -- /usr/include/allegro5/fshook.h:93
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_fs_entry";

   procedure al_destroy_fs_entry (e : access ALLEGRO_FS_ENTRY)  -- /usr/include/allegro5/fshook.h:94
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_fs_entry";

   function al_get_fs_entry_name (e : access ALLEGRO_FS_ENTRY) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/fshook.h:95
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_fs_entry_name";

   function al_update_fs_entry (e : access ALLEGRO_FS_ENTRY) return Extensions.bool  -- /usr/include/allegro5/fshook.h:96
   with Import => True, 
        Convention => C, 
        External_Name => "al_update_fs_entry";

   function al_get_fs_entry_mode (e : access ALLEGRO_FS_ENTRY) return x86_64_linux_gnu_bits_stdint_uintn_h.uint32_t  -- /usr/include/allegro5/fshook.h:97
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_fs_entry_mode";

   function al_get_fs_entry_atime (e : access ALLEGRO_FS_ENTRY) return x86_64_linux_gnu_bits_types_time_t_h.time_t  -- /usr/include/allegro5/fshook.h:98
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_fs_entry_atime";

   function al_get_fs_entry_mtime (e : access ALLEGRO_FS_ENTRY) return x86_64_linux_gnu_bits_types_time_t_h.time_t  -- /usr/include/allegro5/fshook.h:99
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_fs_entry_mtime";

   function al_get_fs_entry_ctime (e : access ALLEGRO_FS_ENTRY) return x86_64_linux_gnu_bits_types_time_t_h.time_t  -- /usr/include/allegro5/fshook.h:100
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_fs_entry_ctime";

   function al_get_fs_entry_size (e : access ALLEGRO_FS_ENTRY) return x86_64_linux_gnu_sys_types_h.off_t  -- /usr/include/allegro5/fshook.h:101
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_fs_entry_size";

   function al_fs_entry_exists (e : access ALLEGRO_FS_ENTRY) return Extensions.bool  -- /usr/include/allegro5/fshook.h:102
   with Import => True, 
        Convention => C, 
        External_Name => "al_fs_entry_exists";

   function al_remove_fs_entry (e : access ALLEGRO_FS_ENTRY) return Extensions.bool  -- /usr/include/allegro5/fshook.h:103
   with Import => True, 
        Convention => C, 
        External_Name => "al_remove_fs_entry";

   function al_open_directory (e : access ALLEGRO_FS_ENTRY) return Extensions.bool  -- /usr/include/allegro5/fshook.h:105
   with Import => True, 
        Convention => C, 
        External_Name => "al_open_directory";

   function al_read_directory (e : access ALLEGRO_FS_ENTRY) return access ALLEGRO_FS_ENTRY  -- /usr/include/allegro5/fshook.h:106
   with Import => True, 
        Convention => C, 
        External_Name => "al_read_directory";

   function al_close_directory (e : access ALLEGRO_FS_ENTRY) return Extensions.bool  -- /usr/include/allegro5/fshook.h:107
   with Import => True, 
        Convention => C, 
        External_Name => "al_close_directory";

   function al_filename_exists (path : Interfaces.C.Strings.chars_ptr) return Extensions.bool  -- /usr/include/allegro5/fshook.h:109
   with Import => True, 
        Convention => C, 
        External_Name => "al_filename_exists";

   function al_remove_filename (path : Interfaces.C.Strings.chars_ptr) return Extensions.bool  -- /usr/include/allegro5/fshook.h:110
   with Import => True, 
        Convention => C, 
        External_Name => "al_remove_filename";

   function al_get_current_directory return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/fshook.h:111
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_current_directory";

   function al_change_directory (path : Interfaces.C.Strings.chars_ptr) return Extensions.bool  -- /usr/include/allegro5/fshook.h:112
   with Import => True, 
        Convention => C, 
        External_Name => "al_change_directory";

   function al_make_directory (path : Interfaces.C.Strings.chars_ptr) return Extensions.bool  -- /usr/include/allegro5/fshook.h:113
   with Import => True, 
        Convention => C, 
        External_Name => "al_make_directory";

   function al_open_fs_entry (e : access ALLEGRO_FS_ENTRY; mode : Interfaces.C.Strings.chars_ptr) return access allegro5_file_h.ALLEGRO_FILE  -- /usr/include/allegro5/fshook.h:115
   with Import => True, 
        Convention => C, 
        External_Name => "al_open_fs_entry";

  -- Helper function for iterating over a directory using a callback.  
  -- Type: ALLEGRO_FOR_EACH_FS_ENTRY_RESULT
  --  

   subtype ALLEGRO_FOR_EACH_FS_ENTRY_RESULT is int;
   ALLEGRO_FOR_EACH_FS_ENTRY_ERROR : constant int := -1;
   ALLEGRO_FOR_EACH_FS_ENTRY_OK : constant int := 0;
   ALLEGRO_FOR_EACH_FS_ENTRY_SKIP : constant int := 1;
   ALLEGRO_FOR_EACH_FS_ENTRY_STOP : constant int := 2;  -- /usr/include/allegro5/fshook.h:124

   function al_for_each_fs_entry
     (dir : access ALLEGRO_FS_ENTRY;
      callback : access function (arg1 : access ALLEGRO_FS_ENTRY; arg2 : System.Address) return int;
      extra : System.Address) return int  -- /usr/include/allegro5/fshook.h:131
   with Import => True, 
        Convention => C, 
        External_Name => "al_for_each_fs_entry";

  -- Thread-local state.  
   function al_get_fs_interface return access constant ALLEGRO_FS_INTERFACE  -- /usr/include/allegro5/fshook.h:137
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_fs_interface";

   procedure al_set_fs_interface (vtable : access constant ALLEGRO_FS_INTERFACE)  -- /usr/include/allegro5/fshook.h:138
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_fs_interface";

   procedure al_set_standard_fs_interface  -- /usr/include/allegro5/fshook.h:139
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_standard_fs_interface";

  -- vim: set sts=3 sw=3 et:  
end allegro5_fshook_h;

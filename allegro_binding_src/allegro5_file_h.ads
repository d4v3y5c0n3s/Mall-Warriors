pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with System;
with Interfaces.C.Extensions;
with stddef_h;
with x86_64_linux_gnu_bits_stdint_intn_h;
with x86_64_linux_gnu_sys_types_h;
with allegro5_utf8_h;

package allegro5_file_h is

  -- Type: ALLEGRO_FILE
  --  

   type ALLEGRO_FILE is null record;   -- incomplete struct

  -- Type: ALLEGRO_FILE_INTERFACE
  --  

   type ALLEGRO_FILE_INTERFACE is record
      fi_fopen : access function (arg1 : Interfaces.C.Strings.chars_ptr; arg2 : Interfaces.C.Strings.chars_ptr) return System.Address;  -- /usr/include/allegro5/file.h:22
      fi_fclose : access function (arg1 : access ALLEGRO_FILE) return Extensions.bool;  -- /usr/include/allegro5/file.h:23
      fi_fread : access function
           (arg1 : access ALLEGRO_FILE;
            arg2 : System.Address;
            arg3 : stddef_h.size_t) return stddef_h.size_t;  -- /usr/include/allegro5/file.h:24
      fi_fwrite : access function
           (arg1 : access ALLEGRO_FILE;
            arg2 : System.Address;
            arg3 : stddef_h.size_t) return stddef_h.size_t;  -- /usr/include/allegro5/file.h:25
      fi_fflush : access function (arg1 : access ALLEGRO_FILE) return Extensions.bool;  -- /usr/include/allegro5/file.h:26
      fi_ftell : access function (arg1 : access ALLEGRO_FILE) return x86_64_linux_gnu_bits_stdint_intn_h.int64_t;  -- /usr/include/allegro5/file.h:27
      fi_fseek : access function
           (arg1 : access ALLEGRO_FILE;
            arg2 : x86_64_linux_gnu_bits_stdint_intn_h.int64_t;
            arg3 : int) return Extensions.bool;  -- /usr/include/allegro5/file.h:28
      fi_feof : access function (arg1 : access ALLEGRO_FILE) return Extensions.bool;  -- /usr/include/allegro5/file.h:29
      fi_ferror : access function (arg1 : access ALLEGRO_FILE) return int;  -- /usr/include/allegro5/file.h:30
      fi_ferrmsg : access function (arg1 : access ALLEGRO_FILE) return Interfaces.C.Strings.chars_ptr;  -- /usr/include/allegro5/file.h:31
      fi_fclearerr : access procedure (arg1 : access ALLEGRO_FILE);  -- /usr/include/allegro5/file.h:32
      fi_fungetc : access function (arg1 : access ALLEGRO_FILE; arg2 : int) return int;  -- /usr/include/allegro5/file.h:33
      fi_fsize : access function (arg1 : access ALLEGRO_FILE) return x86_64_linux_gnu_sys_types_h.off_t;  -- /usr/include/allegro5/file.h:34
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/file.h:20

  -- Enum: ALLEGRO_SEEK
  --  

   type ALLEGRO_SEEK is 
     (ALLEGRO_SEEK_SET,
      ALLEGRO_SEEK_CUR,
      ALLEGRO_SEEK_END)
   with Convention => C;  -- /usr/include/allegro5/file.h:40

  -- The basic operations.  
   function al_fopen (path : Interfaces.C.Strings.chars_ptr; mode : Interfaces.C.Strings.chars_ptr) return access ALLEGRO_FILE  -- /usr/include/allegro5/file.h:49
   with Import => True, 
        Convention => C, 
        External_Name => "al_fopen";

   function al_fopen_interface
     (vt : access constant ALLEGRO_FILE_INTERFACE;
      path : Interfaces.C.Strings.chars_ptr;
      mode : Interfaces.C.Strings.chars_ptr) return access ALLEGRO_FILE  -- /usr/include/allegro5/file.h:50
   with Import => True, 
        Convention => C, 
        External_Name => "al_fopen_interface";

   function al_create_file_handle (vt : access constant ALLEGRO_FILE_INTERFACE; userdata : System.Address) return access ALLEGRO_FILE  -- /usr/include/allegro5/file.h:51
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_file_handle";

   function al_fclose (f : access ALLEGRO_FILE) return Extensions.bool  -- /usr/include/allegro5/file.h:52
   with Import => True, 
        Convention => C, 
        External_Name => "al_fclose";

   function al_fread
     (f : access ALLEGRO_FILE;
      ptr : System.Address;
      size : stddef_h.size_t) return stddef_h.size_t  -- /usr/include/allegro5/file.h:53
   with Import => True, 
        Convention => C, 
        External_Name => "al_fread";

   function al_fwrite
     (f : access ALLEGRO_FILE;
      ptr : System.Address;
      size : stddef_h.size_t) return stddef_h.size_t  -- /usr/include/allegro5/file.h:54
   with Import => True, 
        Convention => C, 
        External_Name => "al_fwrite";

   function al_fflush (f : access ALLEGRO_FILE) return Extensions.bool  -- /usr/include/allegro5/file.h:55
   with Import => True, 
        Convention => C, 
        External_Name => "al_fflush";

   function al_ftell (f : access ALLEGRO_FILE) return x86_64_linux_gnu_bits_stdint_intn_h.int64_t  -- /usr/include/allegro5/file.h:56
   with Import => True, 
        Convention => C, 
        External_Name => "al_ftell";

   function al_fseek
     (f : access ALLEGRO_FILE;
      offset : x86_64_linux_gnu_bits_stdint_intn_h.int64_t;
      whence : int) return Extensions.bool  -- /usr/include/allegro5/file.h:57
   with Import => True, 
        Convention => C, 
        External_Name => "al_fseek";

   function al_feof (f : access ALLEGRO_FILE) return Extensions.bool  -- /usr/include/allegro5/file.h:58
   with Import => True, 
        Convention => C, 
        External_Name => "al_feof";

   function al_ferror (f : access ALLEGRO_FILE) return int  -- /usr/include/allegro5/file.h:59
   with Import => True, 
        Convention => C, 
        External_Name => "al_ferror";

   function al_ferrmsg (f : access ALLEGRO_FILE) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/file.h:60
   with Import => True, 
        Convention => C, 
        External_Name => "al_ferrmsg";

   procedure al_fclearerr (f : access ALLEGRO_FILE)  -- /usr/include/allegro5/file.h:61
   with Import => True, 
        Convention => C, 
        External_Name => "al_fclearerr";

   function al_fungetc (f : access ALLEGRO_FILE; c : int) return int  -- /usr/include/allegro5/file.h:62
   with Import => True, 
        Convention => C, 
        External_Name => "al_fungetc";

   function al_fsize (f : access ALLEGRO_FILE) return x86_64_linux_gnu_bits_stdint_intn_h.int64_t  -- /usr/include/allegro5/file.h:63
   with Import => True, 
        Convention => C, 
        External_Name => "al_fsize";

  -- Convenience functions.  
   function al_fgetc (f : access ALLEGRO_FILE) return int  -- /usr/include/allegro5/file.h:66
   with Import => True, 
        Convention => C, 
        External_Name => "al_fgetc";

   function al_fputc (f : access ALLEGRO_FILE; c : int) return int  -- /usr/include/allegro5/file.h:67
   with Import => True, 
        Convention => C, 
        External_Name => "al_fputc";

   function al_fread16le (f : access ALLEGRO_FILE) return x86_64_linux_gnu_bits_stdint_intn_h.int16_t  -- /usr/include/allegro5/file.h:68
   with Import => True, 
        Convention => C, 
        External_Name => "al_fread16le";

   function al_fread16be (f : access ALLEGRO_FILE) return x86_64_linux_gnu_bits_stdint_intn_h.int16_t  -- /usr/include/allegro5/file.h:69
   with Import => True, 
        Convention => C, 
        External_Name => "al_fread16be";

   function al_fwrite16le (f : access ALLEGRO_FILE; w : x86_64_linux_gnu_bits_stdint_intn_h.int16_t) return stddef_h.size_t  -- /usr/include/allegro5/file.h:70
   with Import => True, 
        Convention => C, 
        External_Name => "al_fwrite16le";

   function al_fwrite16be (f : access ALLEGRO_FILE; w : x86_64_linux_gnu_bits_stdint_intn_h.int16_t) return stddef_h.size_t  -- /usr/include/allegro5/file.h:71
   with Import => True, 
        Convention => C, 
        External_Name => "al_fwrite16be";

   function al_fread32le (f : access ALLEGRO_FILE) return x86_64_linux_gnu_bits_stdint_intn_h.int32_t  -- /usr/include/allegro5/file.h:72
   with Import => True, 
        Convention => C, 
        External_Name => "al_fread32le";

   function al_fread32be (f : access ALLEGRO_FILE) return x86_64_linux_gnu_bits_stdint_intn_h.int32_t  -- /usr/include/allegro5/file.h:73
   with Import => True, 
        Convention => C, 
        External_Name => "al_fread32be";

   function al_fwrite32le (f : access ALLEGRO_FILE; l : x86_64_linux_gnu_bits_stdint_intn_h.int32_t) return stddef_h.size_t  -- /usr/include/allegro5/file.h:74
   with Import => True, 
        Convention => C, 
        External_Name => "al_fwrite32le";

   function al_fwrite32be (f : access ALLEGRO_FILE; l : x86_64_linux_gnu_bits_stdint_intn_h.int32_t) return stddef_h.size_t  -- /usr/include/allegro5/file.h:75
   with Import => True, 
        Convention => C, 
        External_Name => "al_fwrite32be";

   function al_fgets
     (f : access ALLEGRO_FILE;
      p : Interfaces.C.Strings.chars_ptr;
      max : stddef_h.size_t) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/file.h:76
   with Import => True, 
        Convention => C, 
        External_Name => "al_fgets";

   function al_fget_ustr (f : access ALLEGRO_FILE) return access allegro5_utf8_h.ALLEGRO_USTR  -- /usr/include/allegro5/file.h:77
   with Import => True, 
        Convention => C, 
        External_Name => "al_fget_ustr";

   function al_fputs (f : access ALLEGRO_FILE; p : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/allegro5/file.h:78
   with Import => True, 
        Convention => C, 
        External_Name => "al_fputs";

   function al_fprintf (f : access ALLEGRO_FILE; format : Interfaces.C.Strings.chars_ptr  -- , ...
      ) return int  -- /usr/include/allegro5/file.h:79
   with Import => True, 
        Convention => C, 
        External_Name => "al_fprintf";

   function al_vfprintf
     (f : access ALLEGRO_FILE;
      format : Interfaces.C.Strings.chars_ptr;
      args : access System.Address) return int  -- /usr/include/allegro5/file.h:80
   with Import => True, 
        Convention => C, 
        External_Name => "al_vfprintf";

  -- Specific to stdio backend.  
   function al_fopen_fd (fd : int; mode : Interfaces.C.Strings.chars_ptr) return access ALLEGRO_FILE  -- /usr/include/allegro5/file.h:83
   with Import => True, 
        Convention => C, 
        External_Name => "al_fopen_fd";

   function al_make_temp_file (tmpl : Interfaces.C.Strings.chars_ptr; ret_path : System.Address) return access ALLEGRO_FILE  -- /usr/include/allegro5/file.h:84
   with Import => True, 
        Convention => C, 
        External_Name => "al_make_temp_file";

  -- Specific to slices.  
   function al_fopen_slice
     (fp : access ALLEGRO_FILE;
      initial_size : stddef_h.size_t;
      mode : Interfaces.C.Strings.chars_ptr) return access ALLEGRO_FILE  -- /usr/include/allegro5/file.h:88
   with Import => True, 
        Convention => C, 
        External_Name => "al_fopen_slice";

  -- Thread-local state.  
   function al_get_new_file_interface return access constant ALLEGRO_FILE_INTERFACE  -- /usr/include/allegro5/file.h:92
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_new_file_interface";

   procedure al_set_new_file_interface (file_interface : access constant ALLEGRO_FILE_INTERFACE)  -- /usr/include/allegro5/file.h:93
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_new_file_interface";

   procedure al_set_standard_file_interface  -- /usr/include/allegro5/file.h:95
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_standard_file_interface";

  -- ALLEGRO_FILE field accessors  
   function al_get_file_userdata (f : access ALLEGRO_FILE) return System.Address  -- /usr/include/allegro5/file.h:98
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_file_userdata";

  -- vim: set sts=3 sw=3 et:  
end allegro5_file_h;

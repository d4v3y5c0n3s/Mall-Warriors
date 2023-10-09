pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with stddef_h;
with Interfaces.C.Extensions;
with x86_64_linux_gnu_bits_stdint_intn_h;
with System;
with x86_64_linux_gnu_bits_stdint_uintn_h;

package allegro5_utf8_h is

  -- Type: ALLEGRO_USTR
  --  

   type u_al_tagbstring;
   subtype ALLEGRO_USTR is u_al_tagbstring;  -- /usr/include/allegro5/utf8.h:12

  -- Type: ALLEGRO_USTR_INFO
  --  

   subtype ALLEGRO_USTR_INFO is u_al_tagbstring;  -- /usr/include/allegro5/utf8.h:16

   type u_al_tagbstring is record
      mlen : aliased int;  -- /usr/include/allegro5/utf8.h:21
      slen : aliased int;  -- /usr/include/allegro5/utf8.h:22
      data : access unsigned_char;  -- /usr/include/allegro5/utf8.h:23
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/utf8.h:20

  -- Creating strings  
   function al_ustr_new (s : Interfaces.C.Strings.chars_ptr) return access ALLEGRO_USTR  -- /usr/include/allegro5/utf8.h:28
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_new";

   function al_ustr_new_from_buffer (s : Interfaces.C.Strings.chars_ptr; size : stddef_h.size_t) return access ALLEGRO_USTR  -- /usr/include/allegro5/utf8.h:29
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_new_from_buffer";

   function al_ustr_newf (fmt : Interfaces.C.Strings.chars_ptr  -- , ...
      ) return access ALLEGRO_USTR  -- /usr/include/allegro5/utf8.h:30
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_newf";

   procedure al_ustr_free (us : access ALLEGRO_USTR)  -- /usr/include/allegro5/utf8.h:31
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_free";

   function al_cstr (us : access constant ALLEGRO_USTR) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/utf8.h:32
   with Import => True, 
        Convention => C, 
        External_Name => "al_cstr";

   procedure al_ustr_to_buffer
     (us : access constant ALLEGRO_USTR;
      buffer : Interfaces.C.Strings.chars_ptr;
      size : int)  -- /usr/include/allegro5/utf8.h:33
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_to_buffer";

   function al_cstr_dup (us : access constant ALLEGRO_USTR) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/utf8.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "al_cstr_dup";

   function al_ustr_dup (us : access constant ALLEGRO_USTR) return access ALLEGRO_USTR  -- /usr/include/allegro5/utf8.h:35
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_dup";

   function al_ustr_dup_substr
     (us : access constant ALLEGRO_USTR;
      start_pos : int;
      end_pos : int) return access ALLEGRO_USTR  -- /usr/include/allegro5/utf8.h:36
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_dup_substr";

  -- Predefined string  
   function al_ustr_empty_string return access constant ALLEGRO_USTR  -- /usr/include/allegro5/utf8.h:40
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_empty_string";

  -- Reference strings  
   function al_ref_cstr (info : access ALLEGRO_USTR_INFO; s : Interfaces.C.Strings.chars_ptr) return access constant ALLEGRO_USTR  -- /usr/include/allegro5/utf8.h:43
   with Import => True, 
        Convention => C, 
        External_Name => "al_ref_cstr";

   function al_ref_buffer
     (info : access ALLEGRO_USTR_INFO;
      s : Interfaces.C.Strings.chars_ptr;
      size : stddef_h.size_t) return access constant ALLEGRO_USTR  -- /usr/include/allegro5/utf8.h:44
   with Import => True, 
        Convention => C, 
        External_Name => "al_ref_buffer";

   function al_ref_ustr
     (info : access ALLEGRO_USTR_INFO;
      us : access constant ALLEGRO_USTR;
      start_pos : int;
      end_pos : int) return access constant ALLEGRO_USTR  -- /usr/include/allegro5/utf8.h:46
   with Import => True, 
        Convention => C, 
        External_Name => "al_ref_ustr";

  -- Sizes and offsets  
   function al_ustr_size (us : access constant ALLEGRO_USTR) return stddef_h.size_t  -- /usr/include/allegro5/utf8.h:50
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_size";

   function al_ustr_length (us : access constant ALLEGRO_USTR) return stddef_h.size_t  -- /usr/include/allegro5/utf8.h:51
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_length";

   function al_ustr_offset (us : access constant ALLEGRO_USTR; index : int) return int  -- /usr/include/allegro5/utf8.h:52
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_offset";

   function al_ustr_next (us : access constant ALLEGRO_USTR; pos : access int) return Extensions.bool  -- /usr/include/allegro5/utf8.h:53
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_next";

   function al_ustr_prev (us : access constant ALLEGRO_USTR; pos : access int) return Extensions.bool  -- /usr/include/allegro5/utf8.h:54
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_prev";

  -- Get codepoints  
   function al_ustr_get (us : access constant ALLEGRO_USTR; pos : int) return x86_64_linux_gnu_bits_stdint_intn_h.int32_t  -- /usr/include/allegro5/utf8.h:57
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_get";

   function al_ustr_get_next (us : access constant ALLEGRO_USTR; pos : access int) return x86_64_linux_gnu_bits_stdint_intn_h.int32_t  -- /usr/include/allegro5/utf8.h:58
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_get_next";

   function al_ustr_prev_get (us : access constant ALLEGRO_USTR; pos : access int) return x86_64_linux_gnu_bits_stdint_intn_h.int32_t  -- /usr/include/allegro5/utf8.h:59
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_prev_get";

  -- Insert  
   function al_ustr_insert
     (us1 : access ALLEGRO_USTR;
      pos : int;
      us2 : access constant ALLEGRO_USTR) return Extensions.bool  -- /usr/include/allegro5/utf8.h:62
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_insert";

   function al_ustr_insert_cstr
     (us : access ALLEGRO_USTR;
      pos : int;
      us2 : Interfaces.C.Strings.chars_ptr) return Extensions.bool  -- /usr/include/allegro5/utf8.h:64
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_insert_cstr";

   function al_ustr_insert_chr
     (us : access ALLEGRO_USTR;
      pos : int;
      c : x86_64_linux_gnu_bits_stdint_intn_h.int32_t) return stddef_h.size_t  -- /usr/include/allegro5/utf8.h:66
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_insert_chr";

  -- Append  
   function al_ustr_append (us1 : access ALLEGRO_USTR; us2 : access constant ALLEGRO_USTR) return Extensions.bool  -- /usr/include/allegro5/utf8.h:69
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_append";

   function al_ustr_append_cstr (us : access ALLEGRO_USTR; s : Interfaces.C.Strings.chars_ptr) return Extensions.bool  -- /usr/include/allegro5/utf8.h:70
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_append_cstr";

   function al_ustr_append_chr (us : access ALLEGRO_USTR; c : x86_64_linux_gnu_bits_stdint_intn_h.int32_t) return stddef_h.size_t  -- /usr/include/allegro5/utf8.h:71
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_append_chr";

   function al_ustr_appendf (us : access ALLEGRO_USTR; fmt : Interfaces.C.Strings.chars_ptr  -- , ...
      ) return Extensions.bool  -- /usr/include/allegro5/utf8.h:72
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_appendf";

   function al_ustr_vappendf
     (us : access ALLEGRO_USTR;
      fmt : Interfaces.C.Strings.chars_ptr;
      ap : access System.Address) return Extensions.bool  -- /usr/include/allegro5/utf8.h:74
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_vappendf";

  -- Remove  
   function al_ustr_remove_chr (us : access ALLEGRO_USTR; pos : int) return Extensions.bool  -- /usr/include/allegro5/utf8.h:78
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_remove_chr";

   function al_ustr_remove_range
     (us : access ALLEGRO_USTR;
      start_pos : int;
      end_pos : int) return Extensions.bool  -- /usr/include/allegro5/utf8.h:79
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_remove_range";

   function al_ustr_truncate (us : access ALLEGRO_USTR; start_pos : int) return Extensions.bool  -- /usr/include/allegro5/utf8.h:81
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_truncate";

   function al_ustr_ltrim_ws (us : access ALLEGRO_USTR) return Extensions.bool  -- /usr/include/allegro5/utf8.h:82
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_ltrim_ws";

   function al_ustr_rtrim_ws (us : access ALLEGRO_USTR) return Extensions.bool  -- /usr/include/allegro5/utf8.h:83
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_rtrim_ws";

   function al_ustr_trim_ws (us : access ALLEGRO_USTR) return Extensions.bool  -- /usr/include/allegro5/utf8.h:84
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_trim_ws";

  -- Assign  
   function al_ustr_assign (us1 : access ALLEGRO_USTR; us2 : access constant ALLEGRO_USTR) return Extensions.bool  -- /usr/include/allegro5/utf8.h:87
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_assign";

   function al_ustr_assign_substr
     (us1 : access ALLEGRO_USTR;
      us2 : access constant ALLEGRO_USTR;
      start_pos : int;
      end_pos : int) return Extensions.bool  -- /usr/include/allegro5/utf8.h:88
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_assign_substr";

   function al_ustr_assign_cstr (us1 : access ALLEGRO_USTR; s : Interfaces.C.Strings.chars_ptr) return Extensions.bool  -- /usr/include/allegro5/utf8.h:90
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_assign_cstr";

  -- Replace  
   function al_ustr_set_chr
     (us : access ALLEGRO_USTR;
      pos : int;
      c : x86_64_linux_gnu_bits_stdint_intn_h.int32_t) return stddef_h.size_t  -- /usr/include/allegro5/utf8.h:93
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_set_chr";

   function al_ustr_replace_range
     (us1 : access ALLEGRO_USTR;
      start_pos1 : int;
      end_pos1 : int;
      us2 : access constant ALLEGRO_USTR) return Extensions.bool  -- /usr/include/allegro5/utf8.h:94
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_replace_range";

  -- Searching  
   function al_ustr_find_chr
     (us : access constant ALLEGRO_USTR;
      start_pos : int;
      c : x86_64_linux_gnu_bits_stdint_intn_h.int32_t) return int  -- /usr/include/allegro5/utf8.h:98
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_find_chr";

   function al_ustr_rfind_chr
     (us : access constant ALLEGRO_USTR;
      start_pos : int;
      c : x86_64_linux_gnu_bits_stdint_intn_h.int32_t) return int  -- /usr/include/allegro5/utf8.h:100
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_rfind_chr";

   function al_ustr_find_set
     (us : access constant ALLEGRO_USTR;
      start_pos : int;
      c_accept : access constant ALLEGRO_USTR) return int  -- /usr/include/allegro5/utf8.h:102
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_find_set";

   function al_ustr_find_set_cstr
     (us : access constant ALLEGRO_USTR;
      start_pos : int;
      c_accept : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/allegro5/utf8.h:104
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_find_set_cstr";

   function al_ustr_find_cset
     (us : access constant ALLEGRO_USTR;
      start_pos : int;
      reject : access constant ALLEGRO_USTR) return int  -- /usr/include/allegro5/utf8.h:106
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_find_cset";

   function al_ustr_find_cset_cstr
     (us : access constant ALLEGRO_USTR;
      start_pos : int;
      reject : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/allegro5/utf8.h:108
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_find_cset_cstr";

   function al_ustr_find_str
     (haystack : access constant ALLEGRO_USTR;
      start_pos : int;
      needle : access constant ALLEGRO_USTR) return int  -- /usr/include/allegro5/utf8.h:110
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_find_str";

   function al_ustr_find_cstr
     (haystack : access constant ALLEGRO_USTR;
      start_pos : int;
      needle : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/allegro5/utf8.h:112
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_find_cstr";

   function al_ustr_rfind_str
     (haystack : access constant ALLEGRO_USTR;
      start_pos : int;
      needle : access constant ALLEGRO_USTR) return int  -- /usr/include/allegro5/utf8.h:114
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_rfind_str";

   function al_ustr_rfind_cstr
     (haystack : access constant ALLEGRO_USTR;
      start_pos : int;
      needle : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/allegro5/utf8.h:116
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_rfind_cstr";

   function al_ustr_find_replace
     (us : access ALLEGRO_USTR;
      start_pos : int;
      find : access constant ALLEGRO_USTR;
      replace : access constant ALLEGRO_USTR) return Extensions.bool  -- /usr/include/allegro5/utf8.h:118
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_find_replace";

   function al_ustr_find_replace_cstr
     (us : access ALLEGRO_USTR;
      start_pos : int;
      find : Interfaces.C.Strings.chars_ptr;
      replace : Interfaces.C.Strings.chars_ptr) return Extensions.bool  -- /usr/include/allegro5/utf8.h:120
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_find_replace_cstr";

  -- Compare  
   function al_ustr_equal (us1 : access constant ALLEGRO_USTR; us2 : access constant ALLEGRO_USTR) return Extensions.bool  -- /usr/include/allegro5/utf8.h:124
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_equal";

   function al_ustr_compare (u : access constant ALLEGRO_USTR; v : access constant ALLEGRO_USTR) return int  -- /usr/include/allegro5/utf8.h:125
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_compare";

   function al_ustr_ncompare
     (us1 : access constant ALLEGRO_USTR;
      us2 : access constant ALLEGRO_USTR;
      n : int) return int  -- /usr/include/allegro5/utf8.h:126
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_ncompare";

   function al_ustr_has_prefix (u : access constant ALLEGRO_USTR; v : access constant ALLEGRO_USTR) return Extensions.bool  -- /usr/include/allegro5/utf8.h:128
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_has_prefix";

   function al_ustr_has_prefix_cstr (u : access constant ALLEGRO_USTR; s : Interfaces.C.Strings.chars_ptr) return Extensions.bool  -- /usr/include/allegro5/utf8.h:129
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_has_prefix_cstr";

   function al_ustr_has_suffix (u : access constant ALLEGRO_USTR; v : access constant ALLEGRO_USTR) return Extensions.bool  -- /usr/include/allegro5/utf8.h:130
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_has_suffix";

   function al_ustr_has_suffix_cstr (us1 : access constant ALLEGRO_USTR; s : Interfaces.C.Strings.chars_ptr) return Extensions.bool  -- /usr/include/allegro5/utf8.h:131
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_has_suffix_cstr";

  -- Low level UTF-8 functions  
   function al_utf8_width (c : x86_64_linux_gnu_bits_stdint_intn_h.int32_t) return stddef_h.size_t  -- /usr/include/allegro5/utf8.h:134
   with Import => True, 
        Convention => C, 
        External_Name => "al_utf8_width";

   function al_utf8_encode (s : Interfaces.C.Strings.chars_ptr; c : x86_64_linux_gnu_bits_stdint_intn_h.int32_t) return stddef_h.size_t  -- /usr/include/allegro5/utf8.h:135
   with Import => True, 
        Convention => C, 
        External_Name => "al_utf8_encode";

  -- UTF-16  
   function al_ustr_new_from_utf16 (s : access x86_64_linux_gnu_bits_stdint_uintn_h.uint16_t) return access ALLEGRO_USTR  -- /usr/include/allegro5/utf8.h:138
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_new_from_utf16";

   function al_ustr_size_utf16 (us : access constant ALLEGRO_USTR) return stddef_h.size_t  -- /usr/include/allegro5/utf8.h:139
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_size_utf16";

   function al_ustr_encode_utf16
     (us : access constant ALLEGRO_USTR;
      s : access x86_64_linux_gnu_bits_stdint_uintn_h.uint16_t;
      n : stddef_h.size_t) return stddef_h.size_t  -- /usr/include/allegro5/utf8.h:140
   with Import => True, 
        Convention => C, 
        External_Name => "al_ustr_encode_utf16";

   function al_utf16_width (c : int) return stddef_h.size_t  -- /usr/include/allegro5/utf8.h:141
   with Import => True, 
        Convention => C, 
        External_Name => "al_utf16_width";

   function al_utf16_encode (s : access x86_64_linux_gnu_bits_stdint_uintn_h.uint16_t; c : x86_64_linux_gnu_bits_stdint_intn_h.int32_t) return stddef_h.size_t  -- /usr/include/allegro5/utf8.h:142
   with Import => True, 
        Convention => C, 
        External_Name => "al_utf16_encode";

  -- vim: set sts=3 sw=3 et:  
end allegro5_utf8_h;

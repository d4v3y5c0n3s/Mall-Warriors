pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Strings;
with System;

package allegro5_memory_h is

   --  arg-macro: function al_malloc (n)
   --    return al_malloc_with_context((n), __LINE__, __FILE__, __func__);
   --  arg-macro: function al_free (p)
   --    return al_free_with_context((p), __LINE__, __FILE__, __func__);
   --  arg-macro: function al_realloc (p, n)
   --    return al_realloc_with_context((p), (n), __LINE__, __FILE__, __func__);
   --  arg-macro: function al_calloc (c, n)
   --    return al_calloc_with_context((c), (n), __LINE__, __FILE__, __func__);
  --         ______   ___    ___
  -- *        /\  _  \ /\_ \  /\_  *        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
  --_
  -- *         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __` *          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\  *           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
  --__/
  -- *            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
  -- *                                           /\____/
  -- *                                           \_/__/
  -- *
  -- *      Memory management routines.
  -- *
  -- *      See readme.txt for copyright information.
  --  

  -- Type: ALLEGRO_MEMORY_INTERFACE
  --  

   type ALLEGRO_MEMORY_INTERFACE;
   type ALLEGRO_MEMORY_INTERFACE is record
      mi_malloc : access function
           (arg1 : stddef_h.size_t;
            arg2 : int;
            arg3 : Interfaces.C.Strings.chars_ptr;
            arg4 : Interfaces.C.Strings.chars_ptr) return System.Address;  -- /usr/include/allegro5/memory.h:31
      mi_free : access procedure
           (arg1 : System.Address;
            arg2 : int;
            arg3 : Interfaces.C.Strings.chars_ptr;
            arg4 : Interfaces.C.Strings.chars_ptr);  -- /usr/include/allegro5/memory.h:32
      mi_realloc : access function
           (arg1 : System.Address;
            arg2 : stddef_h.size_t;
            arg3 : int;
            arg4 : Interfaces.C.Strings.chars_ptr;
            arg5 : Interfaces.C.Strings.chars_ptr) return System.Address;  -- /usr/include/allegro5/memory.h:33
      mi_calloc : access function
           (arg1 : stddef_h.size_t;
            arg2 : stddef_h.size_t;
            arg3 : int;
            arg4 : Interfaces.C.Strings.chars_ptr;
            arg5 : Interfaces.C.Strings.chars_ptr) return System.Address;  -- /usr/include/allegro5/memory.h:34
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/memory.h:30

   procedure al_set_memory_interface (iface : access ALLEGRO_MEMORY_INTERFACE)  -- /usr/include/allegro5/memory.h:37
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_memory_interface";

  -- Function: al_malloc
  --  

  -- Function: al_free
  --  

  -- Function: al_realloc
  --  

  -- Function: al_calloc
  --  

   function al_malloc_with_context
     (n : stddef_h.size_t;
      line : int;
      file : Interfaces.C.Strings.chars_ptr;
      func : Interfaces.C.Strings.chars_ptr) return System.Address  -- /usr/include/allegro5/memory.h:61
   with Import => True, 
        Convention => C, 
        External_Name => "al_malloc_with_context";

   procedure al_free_with_context
     (ptr : System.Address;
      line : int;
      file : Interfaces.C.Strings.chars_ptr;
      func : Interfaces.C.Strings.chars_ptr)  -- /usr/include/allegro5/memory.h:63
   with Import => True, 
        Convention => C, 
        External_Name => "al_free_with_context";

   function al_realloc_with_context
     (ptr : System.Address;
      n : stddef_h.size_t;
      line : int;
      file : Interfaces.C.Strings.chars_ptr;
      func : Interfaces.C.Strings.chars_ptr) return System.Address  -- /usr/include/allegro5/memory.h:65
   with Import => True, 
        Convention => C, 
        External_Name => "al_realloc_with_context";

   function al_calloc_with_context
     (count : stddef_h.size_t;
      n : stddef_h.size_t;
      line : int;
      file : Interfaces.C.Strings.chars_ptr;
      func : Interfaces.C.Strings.chars_ptr) return System.Address  -- /usr/include/allegro5/memory.h:67
   with Import => True, 
        Convention => C, 
        External_Name => "al_calloc_with_context";

end allegro5_memory_h;

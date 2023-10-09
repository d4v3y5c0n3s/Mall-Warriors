pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with allegro5_color_h;
with x86_64_linux_gnu_bits_stdint_uintn_h;
with Interfaces.C.Extensions;
with System;
limited with allegro5_bitmap_h;
with stddef_h;
with stdint_h;

package allegro_primitives_h is

   --  unsupported macro: ALLEGRO_PRIM_FUNC AL_FUNC
   ALLEGRO_VERTEX_CACHE_SIZE : constant := 256;  --  addons/primitives/allegro5/allegro_primitives.h:119

   ALLEGRO_PRIM_QUALITY : constant := 10;  --  addons/primitives/allegro5/allegro_primitives.h:123

  -- Enum: ALLEGRO_PRIM_TYPE
  --  

   type ALLEGRO_PRIM_TYPE is 
     (ALLEGRO_PRIM_LINE_LIST,
      ALLEGRO_PRIM_LINE_STRIP,
      ALLEGRO_PRIM_LINE_LOOP,
      ALLEGRO_PRIM_TRIANGLE_LIST,
      ALLEGRO_PRIM_TRIANGLE_STRIP,
      ALLEGRO_PRIM_TRIANGLE_FAN,
      ALLEGRO_PRIM_POINT_LIST,
      ALLEGRO_PRIM_NUM_TYPES)
   with Convention => C;  -- addons/primitives/allegro5/allegro_primitives.h:36

  -- Enum: ALLEGRO_PRIM_ATTR
  --  

   subtype ALLEGRO_PRIM_ATTR is unsigned;
   ALLEGRO_PRIM_POSITION : constant unsigned := 1;
   ALLEGRO_PRIM_COLOR_ATTR : constant unsigned := 2;
   ALLEGRO_PRIM_TEX_COORD : constant unsigned := 3;
   ALLEGRO_PRIM_TEX_COORD_PIXEL : constant unsigned := 4;
   ALLEGRO_PRIM_USER_ATTR : constant unsigned := 5;
   ALLEGRO_PRIM_ATTR_NUM : constant unsigned := 15;  -- addons/primitives/allegro5/allegro_primitives.h:55

  -- Enum: ALLEGRO_PRIM_STORAGE
  --  

   type ALLEGRO_PRIM_STORAGE is 
     (ALLEGRO_PRIM_FLOAT_2,
      ALLEGRO_PRIM_FLOAT_3,
      ALLEGRO_PRIM_SHORT_2,
      ALLEGRO_PRIM_FLOAT_1,
      ALLEGRO_PRIM_FLOAT_4,
      ALLEGRO_PRIM_UBYTE_4,
      ALLEGRO_PRIM_SHORT_4,
      ALLEGRO_PRIM_NORMALIZED_UBYTE_4,
      ALLEGRO_PRIM_NORMALIZED_SHORT_2,
      ALLEGRO_PRIM_NORMALIZED_SHORT_4,
      ALLEGRO_PRIM_NORMALIZED_USHORT_2,
      ALLEGRO_PRIM_NORMALIZED_USHORT_4,
      ALLEGRO_PRIM_HALF_FLOAT_2,
      ALLEGRO_PRIM_HALF_FLOAT_4)
   with Convention => C;  -- addons/primitives/allegro5/allegro_primitives.h:67

  -- Enum: ALLEGRO_LINE_JOIN
  --  

   subtype ALLEGRO_LINE_JOIN is unsigned;
   ALLEGRO_LINE_JOIN_NONE : constant unsigned := 0;
   ALLEGRO_LINE_JOIN_BEVEL : constant unsigned := 1;
   ALLEGRO_LINE_JOIN_ROUND : constant unsigned := 2;
   ALLEGRO_LINE_JOIN_MITER : constant unsigned := 3;
   ALLEGRO_LINE_JOIN_MITRE : constant unsigned := 3;  -- addons/primitives/allegro5/allegro_primitives.h:87

  -- Enum: ALLEGRO_LINE_CAP
  --  

   type ALLEGRO_LINE_CAP is 
     (ALLEGRO_LINE_CAP_NONE,
      ALLEGRO_LINE_CAP_SQUARE,
      ALLEGRO_LINE_CAP_ROUND,
      ALLEGRO_LINE_CAP_TRIANGLE,
      ALLEGRO_LINE_CAP_CLOSED)
   with Convention => C;  -- addons/primitives/allegro5/allegro_primitives.h:98

  -- Enum: ALLEGRO_PRIM_BUFFER_FLAGS
  --  

   subtype ALLEGRO_PRIM_BUFFER_FLAGS is unsigned;
   ALLEGRO_PRIM_BUFFER_STREAM : constant unsigned := 1;
   ALLEGRO_PRIM_BUFFER_STATIC : constant unsigned := 2;
   ALLEGRO_PRIM_BUFFER_DYNAMIC : constant unsigned := 4;
   ALLEGRO_PRIM_BUFFER_READWRITE : constant unsigned := 8;  -- addons/primitives/allegro5/allegro_primitives.h:109

  -- Enum: ALLEGRO_VERTEX_CACHE_SIZE
  --  

  -- Enum: ALLEGRO_PRIM_QUALITY
  --  

  -- Type: ALLEGRO_VERTEX_ELEMENT
  --  

   type ALLEGRO_VERTEX_ELEMENT;
   type ALLEGRO_VERTEX_ELEMENT is record
      attribute : aliased int;  -- addons/primitives/allegro5/allegro_primitives.h:130
      storage : aliased int;  -- addons/primitives/allegro5/allegro_primitives.h:131
      offset : aliased int;  -- addons/primitives/allegro5/allegro_primitives.h:132
   end record
   with Convention => C_Pass_By_Copy;  -- addons/primitives/allegro5/allegro_primitives.h:129

  -- Type: ALLEGRO_VERTEX_DECL
  --  

   type ALLEGRO_VERTEX_DECL is null record;   -- incomplete struct

  -- Duplicated in allegro5/internal/aintern_tri_soft.h  
  -- Type: ALLEGRO_VERTEX
  --  

   type ALLEGRO_VERTEX;
   type ALLEGRO_VERTEX is record
      x : aliased float;  -- addons/primitives/allegro5/allegro_primitives.h:148
      y : aliased float;  -- addons/primitives/allegro5/allegro_primitives.h:148
      z : aliased float;  -- addons/primitives/allegro5/allegro_primitives.h:148
      u : aliased float;  -- addons/primitives/allegro5/allegro_primitives.h:149
      v : aliased float;  -- addons/primitives/allegro5/allegro_primitives.h:149
      color : aliased allegro5_color_h.ALLEGRO_COLOR;  -- addons/primitives/allegro5/allegro_primitives.h:150
   end record
   with Convention => C_Pass_By_Copy;  -- addons/primitives/allegro5/allegro_primitives.h:147

  -- Type: ALLEGRO_VERTEX_BUFFER
  --  

   type ALLEGRO_VERTEX_BUFFER is null record;   -- incomplete struct

  -- Type: ALLEGRO_INDEX_BUFFER
  --  

   type ALLEGRO_INDEX_BUFFER is null record;   -- incomplete struct

   function al_get_allegro_primitives_version return x86_64_linux_gnu_bits_stdint_uintn_h.uint32_t  -- addons/primitives/allegro5/allegro_primitives.h:162
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_allegro_primitives_version";

  --* Primary Functions
  -- 

   function al_init_primitives_addon return Extensions.bool  -- addons/primitives/allegro5/allegro_primitives.h:167
   with Import => True, 
        Convention => C, 
        External_Name => "al_init_primitives_addon";

   function al_is_primitives_addon_initialized return Extensions.bool  -- addons/primitives/allegro5/allegro_primitives.h:168
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_primitives_addon_initialized";

   procedure al_shutdown_primitives_addon  -- addons/primitives/allegro5/allegro_primitives.h:169
   with Import => True, 
        Convention => C, 
        External_Name => "al_shutdown_primitives_addon";

   function al_draw_prim
     (vtxs : System.Address;
      decl : access constant ALLEGRO_VERTEX_DECL;
      texture : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      start : int;
      c_end : int;
      c_type : int) return int  -- addons/primitives/allegro5/allegro_primitives.h:170
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_prim";

   function al_draw_indexed_prim
     (vtxs : System.Address;
      decl : access constant ALLEGRO_VERTEX_DECL;
      texture : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      indices : access int;
      num_vtx : int;
      c_type : int) return int  -- addons/primitives/allegro5/allegro_primitives.h:171
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_indexed_prim";

   function al_draw_vertex_buffer
     (vertex_buffer : access ALLEGRO_VERTEX_BUFFER;
      texture : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      start : int;
      c_end : int;
      c_type : int) return int  -- addons/primitives/allegro5/allegro_primitives.h:172
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_vertex_buffer";

   function al_draw_indexed_buffer
     (vertex_buffer : access ALLEGRO_VERTEX_BUFFER;
      texture : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      index_buffer : access ALLEGRO_INDEX_BUFFER;
      start : int;
      c_end : int;
      c_type : int) return int  -- addons/primitives/allegro5/allegro_primitives.h:173
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_indexed_buffer";

   function al_create_vertex_decl (elements : access constant ALLEGRO_VERTEX_ELEMENT; stride : int) return access ALLEGRO_VERTEX_DECL  -- addons/primitives/allegro5/allegro_primitives.h:175
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_vertex_decl";

   procedure al_destroy_vertex_decl (decl : access ALLEGRO_VERTEX_DECL)  -- addons/primitives/allegro5/allegro_primitives.h:176
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_vertex_decl";

  -- * Vertex buffers
  --  

   function al_create_vertex_buffer
     (decl : access ALLEGRO_VERTEX_DECL;
      initial_data : System.Address;
      num_vertices : int;
      flags : int) return access ALLEGRO_VERTEX_BUFFER  -- addons/primitives/allegro5/allegro_primitives.h:181
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_vertex_buffer";

   procedure al_destroy_vertex_buffer (buffer : access ALLEGRO_VERTEX_BUFFER)  -- addons/primitives/allegro5/allegro_primitives.h:182
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_vertex_buffer";

   function al_lock_vertex_buffer
     (buffer : access ALLEGRO_VERTEX_BUFFER;
      offset : int;
      length : int;
      flags : int) return System.Address  -- addons/primitives/allegro5/allegro_primitives.h:183
   with Import => True, 
        Convention => C, 
        External_Name => "al_lock_vertex_buffer";

   procedure al_unlock_vertex_buffer (buffer : access ALLEGRO_VERTEX_BUFFER)  -- addons/primitives/allegro5/allegro_primitives.h:184
   with Import => True, 
        Convention => C, 
        External_Name => "al_unlock_vertex_buffer";

   function al_get_vertex_buffer_size (buffer : access ALLEGRO_VERTEX_BUFFER) return int  -- addons/primitives/allegro5/allegro_primitives.h:185
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_vertex_buffer_size";

  -- * Index buffers
  --  

   function al_create_index_buffer
     (index_size : int;
      initial_data : System.Address;
      num_indices : int;
      flags : int) return access ALLEGRO_INDEX_BUFFER  -- addons/primitives/allegro5/allegro_primitives.h:190
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_index_buffer";

   procedure al_destroy_index_buffer (buffer : access ALLEGRO_INDEX_BUFFER)  -- addons/primitives/allegro5/allegro_primitives.h:191
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_index_buffer";

   function al_lock_index_buffer
     (buffer : access ALLEGRO_INDEX_BUFFER;
      offset : int;
      length : int;
      flags : int) return System.Address  -- addons/primitives/allegro5/allegro_primitives.h:192
   with Import => True, 
        Convention => C, 
        External_Name => "al_lock_index_buffer";

   procedure al_unlock_index_buffer (buffer : access ALLEGRO_INDEX_BUFFER)  -- addons/primitives/allegro5/allegro_primitives.h:193
   with Import => True, 
        Convention => C, 
        External_Name => "al_unlock_index_buffer";

   function al_get_index_buffer_size (buffer : access ALLEGRO_INDEX_BUFFER) return int  -- addons/primitives/allegro5/allegro_primitives.h:194
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_index_buffer_size";

  --* Utilities for high level primitives.
  -- 

   function al_triangulate_polygon
     (vertices : access float;
      vertex_stride : stddef_h.size_t;
      vertex_counts : access int;
      emit_triangle : access procedure
        (arg1 : int;
         arg2 : int;
         arg3 : int;
         arg4 : System.Address);
      userdata : System.Address) return Extensions.bool  -- addons/primitives/allegro5/allegro_primitives.h:199
   with Import => True, 
        Convention => C, 
        External_Name => "al_triangulate_polygon";

  --* Custom primitives
  -- 

   procedure al_draw_soft_triangle
     (v1 : access ALLEGRO_VERTEX;
      v2 : access ALLEGRO_VERTEX;
      v3 : access ALLEGRO_VERTEX;
      state : stdint_h.uintptr_t;
      init : access procedure
        (arg1 : stdint_h.uintptr_t;
         arg2 : access ALLEGRO_VERTEX;
         arg3 : access ALLEGRO_VERTEX;
         arg4 : access ALLEGRO_VERTEX);
      first : access procedure
        (arg1 : stdint_h.uintptr_t;
         arg2 : int;
         arg3 : int;
         arg4 : int;
         arg5 : int);
      step : access procedure (arg1 : stdint_h.uintptr_t; arg2 : int);
      draw : access procedure
        (arg1 : stdint_h.uintptr_t;
         arg2 : int;
         arg3 : int;
         arg4 : int))  -- addons/primitives/allegro5/allegro_primitives.h:205
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_soft_triangle";

   procedure al_draw_soft_line
     (v1 : access ALLEGRO_VERTEX;
      v2 : access ALLEGRO_VERTEX;
      state : stdint_h.uintptr_t;
      first : access procedure
        (arg1 : stdint_h.uintptr_t;
         arg2 : int;
         arg3 : int;
         arg4 : access ALLEGRO_VERTEX;
         arg5 : access ALLEGRO_VERTEX);
      step : access procedure (arg1 : stdint_h.uintptr_t; arg2 : int);
      draw : access procedure
        (arg1 : stdint_h.uintptr_t;
         arg2 : int;
         arg3 : int))  -- addons/primitives/allegro5/allegro_primitives.h:210
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_soft_line";

  --*High level primitives
  -- 

   procedure al_draw_line
     (x1 : float;
      y1 : float;
      x2 : float;
      y2 : float;
      color : allegro5_color_h.ALLEGRO_COLOR;
      thickness : float)  -- addons/primitives/allegro5/allegro_primitives.h:218
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_line";

   procedure al_draw_triangle
     (x1 : float;
      y1 : float;
      x2 : float;
      y2 : float;
      x3 : float;
      y3 : float;
      color : allegro5_color_h.ALLEGRO_COLOR;
      thickness : float)  -- addons/primitives/allegro5/allegro_primitives.h:219
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_triangle";

   procedure al_draw_rectangle
     (x1 : float;
      y1 : float;
      x2 : float;
      y2 : float;
      color : allegro5_color_h.ALLEGRO_COLOR;
      thickness : float)  -- addons/primitives/allegro5/allegro_primitives.h:220
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_rectangle";

   procedure al_draw_rounded_rectangle
     (x1 : float;
      y1 : float;
      x2 : float;
      y2 : float;
      rx : float;
      ry : float;
      color : allegro5_color_h.ALLEGRO_COLOR;
      thickness : float)  -- addons/primitives/allegro5/allegro_primitives.h:221
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_rounded_rectangle";

   procedure al_calculate_arc
     (dest : access float;
      stride : int;
      cx : float;
      cy : float;
      rx : float;
      ry : float;
      start_theta : float;
      delta_theta : float;
      thickness : float;
      num_points : int)  -- addons/primitives/allegro5/allegro_primitives.h:223
   with Import => True, 
        Convention => C, 
        External_Name => "al_calculate_arc";

   procedure al_draw_circle
     (cx : float;
      cy : float;
      r : float;
      color : allegro5_color_h.ALLEGRO_COLOR;
      thickness : float)  -- addons/primitives/allegro5/allegro_primitives.h:224
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_circle";

   procedure al_draw_ellipse
     (cx : float;
      cy : float;
      rx : float;
      ry : float;
      color : allegro5_color_h.ALLEGRO_COLOR;
      thickness : float)  -- addons/primitives/allegro5/allegro_primitives.h:225
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_ellipse";

   procedure al_draw_arc
     (cx : float;
      cy : float;
      r : float;
      start_theta : float;
      delta_theta : float;
      color : allegro5_color_h.ALLEGRO_COLOR;
      thickness : float)  -- addons/primitives/allegro5/allegro_primitives.h:226
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_arc";

   procedure al_draw_elliptical_arc
     (cx : float;
      cy : float;
      rx : float;
      ry : float;
      start_theta : float;
      delta_theta : float;
      color : allegro5_color_h.ALLEGRO_COLOR;
      thickness : float)  -- addons/primitives/allegro5/allegro_primitives.h:227
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_elliptical_arc";

   procedure al_draw_pieslice
     (cx : float;
      cy : float;
      r : float;
      start_theta : float;
      delta_theta : float;
      color : allegro5_color_h.ALLEGRO_COLOR;
      thickness : float)  -- addons/primitives/allegro5/allegro_primitives.h:228
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_pieslice";

   procedure al_calculate_spline
     (dest : access float;
      stride : int;
      points : access float;
      thickness : float;
      num_segments : int)  -- addons/primitives/allegro5/allegro_primitives.h:230
   with Import => True, 
        Convention => C, 
        External_Name => "al_calculate_spline";

   procedure al_draw_spline
     (points : access float;
      color : allegro5_color_h.ALLEGRO_COLOR;
      thickness : float)  -- addons/primitives/allegro5/allegro_primitives.h:231
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_spline";

   procedure al_calculate_ribbon
     (dest : access float;
      dest_stride : int;
      points : access float;
      points_stride : int;
      thickness : float;
      num_segments : int)  -- addons/primitives/allegro5/allegro_primitives.h:233
   with Import => True, 
        Convention => C, 
        External_Name => "al_calculate_ribbon";

   procedure al_draw_ribbon
     (points : access float;
      points_stride : int;
      color : allegro5_color_h.ALLEGRO_COLOR;
      thickness : float;
      num_segments : int)  -- addons/primitives/allegro5/allegro_primitives.h:234
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_ribbon";

   procedure al_draw_filled_triangle
     (x1 : float;
      y1 : float;
      x2 : float;
      y2 : float;
      x3 : float;
      y3 : float;
      color : allegro5_color_h.ALLEGRO_COLOR)  -- addons/primitives/allegro5/allegro_primitives.h:236
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_filled_triangle";

   procedure al_draw_filled_rectangle
     (x1 : float;
      y1 : float;
      x2 : float;
      y2 : float;
      color : allegro5_color_h.ALLEGRO_COLOR)  -- addons/primitives/allegro5/allegro_primitives.h:237
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_filled_rectangle";

   procedure al_draw_filled_ellipse
     (cx : float;
      cy : float;
      rx : float;
      ry : float;
      color : allegro5_color_h.ALLEGRO_COLOR)  -- addons/primitives/allegro5/allegro_primitives.h:238
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_filled_ellipse";

   procedure al_draw_filled_circle
     (cx : float;
      cy : float;
      r : float;
      color : allegro5_color_h.ALLEGRO_COLOR)  -- addons/primitives/allegro5/allegro_primitives.h:239
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_filled_circle";

   procedure al_draw_filled_pieslice
     (cx : float;
      cy : float;
      r : float;
      start_theta : float;
      delta_theta : float;
      color : allegro5_color_h.ALLEGRO_COLOR)  -- addons/primitives/allegro5/allegro_primitives.h:240
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_filled_pieslice";

   procedure al_draw_filled_rounded_rectangle
     (x1 : float;
      y1 : float;
      x2 : float;
      y2 : float;
      rx : float;
      ry : float;
      color : allegro5_color_h.ALLEGRO_COLOR)  -- addons/primitives/allegro5/allegro_primitives.h:241
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_filled_rounded_rectangle";

   procedure al_draw_polyline
     (vertices : access float;
      vertex_stride : int;
      vertex_count : int;
      join_style : int;
      cap_style : int;
      color : allegro5_color_h.ALLEGRO_COLOR;
      thickness : float;
      miter_limit : float)  -- addons/primitives/allegro5/allegro_primitives.h:243
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_polyline";

   procedure al_draw_polygon
     (vertices : access float;
      vertex_count : int;
      join_style : int;
      color : allegro5_color_h.ALLEGRO_COLOR;
      thickness : float;
      miter_limit : float)  -- addons/primitives/allegro5/allegro_primitives.h:245
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_polygon";

   procedure al_draw_filled_polygon
     (vertices : access float;
      vertex_count : int;
      color : allegro5_color_h.ALLEGRO_COLOR)  -- addons/primitives/allegro5/allegro_primitives.h:246
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_filled_polygon";

   procedure al_draw_filled_polygon_with_holes
     (vertices : access float;
      vertex_counts : access int;
      color : allegro5_color_h.ALLEGRO_COLOR)  -- addons/primitives/allegro5/allegro_primitives.h:247
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_filled_polygon_with_holes";

end allegro_primitives_h;

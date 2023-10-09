pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;
limited with allegro5_bitmap_h;
with allegro5_events_h; use allegro5_events_h;
with System;

package allegro5_display_h is

   ALLEGRO_NEW_WINDOW_TITLE_MAX_SIZE : constant := 255;  --  /usr/include/allegro5/display.h:113

  -- Possible bit combinations for the flags parameter of al_create_display.  
  -- older synonym  
  -- Possible parameters for al_set_display_option.
  -- * Make sure to update ALLEGRO_EXTRA_DISPLAY_SETTINGS if you modify
  -- * anything here.
  --  

   type ALLEGRO_DISPLAY_OPTIONS is 
     (ALLEGRO_RED_SIZE,
      ALLEGRO_GREEN_SIZE,
      ALLEGRO_BLUE_SIZE,
      ALLEGRO_ALPHA_SIZE,
      ALLEGRO_RED_SHIFT,
      ALLEGRO_GREEN_SHIFT,
      ALLEGRO_BLUE_SHIFT,
      ALLEGRO_ALPHA_SHIFT,
      ALLEGRO_ACC_RED_SIZE,
      ALLEGRO_ACC_GREEN_SIZE,
      ALLEGRO_ACC_BLUE_SIZE,
      ALLEGRO_ACC_ALPHA_SIZE,
      ALLEGRO_STEREO,
      ALLEGRO_AUX_BUFFERS,
      ALLEGRO_COLOR_SIZE,
      ALLEGRO_DEPTH_SIZE,
      ALLEGRO_STENCIL_SIZE,
      ALLEGRO_SAMPLE_BUFFERS,
      ALLEGRO_SAMPLES,
      ALLEGRO_RENDER_METHOD,
      ALLEGRO_FLOAT_COLOR,
      ALLEGRO_FLOAT_DEPTH,
      ALLEGRO_SINGLE_BUFFER,
      ALLEGRO_SWAP_METHOD,
      ALLEGRO_COMPATIBLE_DISPLAY,
      ALLEGRO_UPDATE_DISPLAY_REGION,
      ALLEGRO_VSYNC,
      ALLEGRO_MAX_BITMAP_SIZE,
      ALLEGRO_SUPPORT_NPOT_BITMAP,
      ALLEGRO_CAN_DRAW_INTO_BITMAP,
      ALLEGRO_SUPPORT_SEPARATE_ALPHA,
      ALLEGRO_AUTO_CONVERT_BITMAPS,
      ALLEGRO_SUPPORTED_ORIENTATIONS,
      ALLEGRO_OPENGL_MAJOR_VERSION,
      ALLEGRO_OPENGL_MINOR_VERSION,
      ALLEGRO_DISPLAY_OPTIONS_COUNT)
   with Convention => C;  -- /usr/include/allegro5/display.h:36

  -- Bitflags so they can be used for the ALLEGRO_SUPPORTED_ORIENTATIONS option.  
   subtype ALLEGRO_DISPLAY_ORIENTATION is unsigned;
   ALLEGRO_DISPLAY_ORIENTATION_UNKNOWN : constant unsigned := 0;
   ALLEGRO_DISPLAY_ORIENTATION_0_DEGREES : constant unsigned := 1;
   ALLEGRO_DISPLAY_ORIENTATION_90_DEGREES : constant unsigned := 2;
   ALLEGRO_DISPLAY_ORIENTATION_180_DEGREES : constant unsigned := 4;
   ALLEGRO_DISPLAY_ORIENTATION_270_DEGREES : constant unsigned := 8;
   ALLEGRO_DISPLAY_ORIENTATION_PORTRAIT : constant unsigned := 5;
   ALLEGRO_DISPLAY_ORIENTATION_LANDSCAPE : constant unsigned := 10;
   ALLEGRO_DISPLAY_ORIENTATION_ALL : constant unsigned := 15;
   ALLEGRO_DISPLAY_ORIENTATION_FACE_UP : constant unsigned := 16;
   ALLEGRO_DISPLAY_ORIENTATION_FACE_DOWN : constant unsigned := 32;  -- /usr/include/allegro5/display.h:84

  -- Formally part of the primitives addon.  
  -- Type: ALLEGRO_DISPLAY
  --  

     -- Enum: ALLEGRO_NEW_WINDOW_TITLE_MAX_SIZE
  -- 

   procedure al_set_new_display_refresh_rate (refresh_rate : int)  -- /usr/include/allegro5/display.h:115
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_new_display_refresh_rate";

   procedure al_set_new_display_flags (flags : int)  -- /usr/include/allegro5/display.h:116
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_new_display_flags";

   function al_get_new_display_refresh_rate return int  -- /usr/include/allegro5/display.h:117
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_new_display_refresh_rate";

   function al_get_new_display_flags return int  -- /usr/include/allegro5/display.h:118
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_new_display_flags";

   procedure al_set_new_window_title (title : Interfaces.C.Strings.chars_ptr)  -- /usr/include/allegro5/display.h:120
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_new_window_title";

   function al_get_new_window_title return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/display.h:121
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_new_window_title";

   function al_get_display_width (display : access ALLEGRO_DISPLAY) return int  -- /usr/include/allegro5/display.h:123
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_display_width";

   function al_get_display_height (display : access ALLEGRO_DISPLAY) return int  -- /usr/include/allegro5/display.h:124
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_display_height";

   function al_get_display_format (display : access ALLEGRO_DISPLAY) return int  -- /usr/include/allegro5/display.h:125
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_display_format";

   function al_get_display_refresh_rate (display : access ALLEGRO_DISPLAY) return int  -- /usr/include/allegro5/display.h:126
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_display_refresh_rate";

   function al_get_display_flags (display : access ALLEGRO_DISPLAY) return int  -- /usr/include/allegro5/display.h:127
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_display_flags";

   function al_get_display_orientation (display : access ALLEGRO_DISPLAY) return int  -- /usr/include/allegro5/display.h:128
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_display_orientation";

   function al_set_display_flag
     (display : access ALLEGRO_DISPLAY;
      flag : int;
      onoff : Extensions.bool) return Extensions.bool  -- /usr/include/allegro5/display.h:129
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_display_flag";

   function al_create_display (w : int; h : int) return access ALLEGRO_DISPLAY  -- /usr/include/allegro5/display.h:131
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_display";

   procedure al_destroy_display (display : access ALLEGRO_DISPLAY)  -- /usr/include/allegro5/display.h:132
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_display";

   function al_get_current_display return access ALLEGRO_DISPLAY  -- /usr/include/allegro5/display.h:133
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_current_display";

   procedure al_set_target_bitmap (bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP)  -- /usr/include/allegro5/display.h:134
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_target_bitmap";

   procedure al_set_target_backbuffer (display : access ALLEGRO_DISPLAY)  -- /usr/include/allegro5/display.h:135
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_target_backbuffer";

   function al_get_backbuffer (display : access ALLEGRO_DISPLAY) return access allegro5_bitmap_h.ALLEGRO_BITMAP  -- /usr/include/allegro5/display.h:136
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_backbuffer";

   function al_get_target_bitmap return access allegro5_bitmap_h.ALLEGRO_BITMAP  -- /usr/include/allegro5/display.h:137
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_target_bitmap";

   function al_acknowledge_resize (display : access ALLEGRO_DISPLAY) return Extensions.bool  -- /usr/include/allegro5/display.h:139
   with Import => True, 
        Convention => C, 
        External_Name => "al_acknowledge_resize";

   function al_resize_display
     (display : access ALLEGRO_DISPLAY;
      width : int;
      height : int) return Extensions.bool  -- /usr/include/allegro5/display.h:140
   with Import => True, 
        Convention => C, 
        External_Name => "al_resize_display";

   procedure al_flip_display  -- /usr/include/allegro5/display.h:141
   with Import => True, 
        Convention => C, 
        External_Name => "al_flip_display";

   procedure al_update_display_region
     (x : int;
      y : int;
      width : int;
      height : int)  -- /usr/include/allegro5/display.h:142
   with Import => True, 
        Convention => C, 
        External_Name => "al_update_display_region";

   function al_is_compatible_bitmap (bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP) return Extensions.bool  -- /usr/include/allegro5/display.h:143
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_compatible_bitmap";

   function al_wait_for_vsync return Extensions.bool  -- /usr/include/allegro5/display.h:145
   with Import => True, 
        Convention => C, 
        External_Name => "al_wait_for_vsync";

   function al_get_display_event_source (display : access ALLEGRO_DISPLAY) return access allegro5_events_h.ALLEGRO_EVENT_SOURCE  -- /usr/include/allegro5/display.h:147
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_display_event_source";

   procedure al_set_display_icon (display : access ALLEGRO_DISPLAY; icon : access allegro5_bitmap_h.ALLEGRO_BITMAP)  -- /usr/include/allegro5/display.h:149
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_display_icon";

   procedure al_set_display_icons
     (display : access ALLEGRO_DISPLAY;
      num_icons : int;
      icons : System.Address)  -- /usr/include/allegro5/display.h:150
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_display_icons";

  -- Stuff for multihead/window management  
   function al_get_new_display_adapter return int  -- /usr/include/allegro5/display.h:153
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_new_display_adapter";

   procedure al_set_new_display_adapter (adapter : int)  -- /usr/include/allegro5/display.h:154
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_new_display_adapter";

   procedure al_set_new_window_position (x : int; y : int)  -- /usr/include/allegro5/display.h:155
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_new_window_position";

   procedure al_get_new_window_position (x : access int; y : access int)  -- /usr/include/allegro5/display.h:156
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_new_window_position";

   procedure al_set_window_position
     (display : access ALLEGRO_DISPLAY;
      x : int;
      y : int)  -- /usr/include/allegro5/display.h:157
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_window_position";

   procedure al_get_window_position
     (display : access ALLEGRO_DISPLAY;
      x : access int;
      y : access int)  -- /usr/include/allegro5/display.h:158
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_window_position";

   function al_set_window_constraints
     (display : access ALLEGRO_DISPLAY;
      min_w : int;
      min_h : int;
      max_w : int;
      max_h : int) return Extensions.bool  -- /usr/include/allegro5/display.h:159
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_window_constraints";

   function al_get_window_constraints
     (display : access ALLEGRO_DISPLAY;
      min_w : access int;
      min_h : access int;
      max_w : access int;
      max_h : access int) return Extensions.bool  -- /usr/include/allegro5/display.h:160
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_window_constraints";

   procedure al_apply_window_constraints (display : access ALLEGRO_DISPLAY; onoff : Extensions.bool)  -- /usr/include/allegro5/display.h:161
   with Import => True, 
        Convention => C, 
        External_Name => "al_apply_window_constraints";

   procedure al_set_window_title (display : access ALLEGRO_DISPLAY; title : Interfaces.C.Strings.chars_ptr)  -- /usr/include/allegro5/display.h:163
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_window_title";

  -- Defined in display_settings.c  
   procedure al_set_new_display_option
     (option : int;
      value : int;
      importance : int)  -- /usr/include/allegro5/display.h:166
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_new_display_option";

   function al_get_new_display_option (option : int; importance : access int) return int  -- /usr/include/allegro5/display.h:167
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_new_display_option";

   procedure al_reset_new_display_options  -- /usr/include/allegro5/display.h:168
   with Import => True, 
        Convention => C, 
        External_Name => "al_reset_new_display_options";

   procedure al_set_display_option
     (display : access ALLEGRO_DISPLAY;
      option : int;
      value : int)  -- /usr/include/allegro5/display.h:169
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_display_option";

   function al_get_display_option (display : access ALLEGRO_DISPLAY; option : int) return int  -- /usr/include/allegro5/display.h:170
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_display_option";

  --Deferred drawing 
   procedure al_hold_bitmap_drawing (hold : Extensions.bool)  -- /usr/include/allegro5/display.h:173
   with Import => True, 
        Convention => C, 
        External_Name => "al_hold_bitmap_drawing";

   function al_is_bitmap_drawing_held return Extensions.bool  -- /usr/include/allegro5/display.h:174
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_bitmap_drawing_held";

  -- Miscellaneous  
   procedure al_acknowledge_drawing_halt (display : access ALLEGRO_DISPLAY)  -- /usr/include/allegro5/display.h:177
   with Import => True, 
        Convention => C, 
        External_Name => "al_acknowledge_drawing_halt";

   procedure al_acknowledge_drawing_resume (display : access ALLEGRO_DISPLAY)  -- /usr/include/allegro5/display.h:178
   with Import => True, 
        Convention => C, 
        External_Name => "al_acknowledge_drawing_resume";

  -- vim: set ts=8 sts=3 sw=3 et:  
end allegro5_display_h;

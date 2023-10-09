pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
limited with allegro5_bitmap_h;
limited with allegro5_events_h;
with Interfaces.C.Extensions;

package allegro5_mouse_cursor_h is

   type ALLEGRO_MOUSE_CURSOR is null record;   -- incomplete struct

   type ALLEGRO_SYSTEM_MOUSE_CURSOR is 
     (ALLEGRO_SYSTEM_MOUSE_CURSOR_NONE,
      ALLEGRO_SYSTEM_MOUSE_CURSOR_DEFAULT,
      ALLEGRO_SYSTEM_MOUSE_CURSOR_ARROW,
      ALLEGRO_SYSTEM_MOUSE_CURSOR_BUSY,
      ALLEGRO_SYSTEM_MOUSE_CURSOR_QUESTION,
      ALLEGRO_SYSTEM_MOUSE_CURSOR_EDIT,
      ALLEGRO_SYSTEM_MOUSE_CURSOR_MOVE,
      ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_N,
      ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_W,
      ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_S,
      ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_E,
      ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_NW,
      ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_SW,
      ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_SE,
      ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_NE,
      ALLEGRO_SYSTEM_MOUSE_CURSOR_PROGRESS,
      ALLEGRO_SYSTEM_MOUSE_CURSOR_PRECISION,
      ALLEGRO_SYSTEM_MOUSE_CURSOR_LINK,
      ALLEGRO_SYSTEM_MOUSE_CURSOR_ALT_SELECT,
      ALLEGRO_SYSTEM_MOUSE_CURSOR_UNAVAILABLE,
      ALLEGRO_NUM_SYSTEM_MOUSE_CURSORS)
   with Convention => C;  -- /usr/include/allegro5/mouse_cursor.h:12

   function al_create_mouse_cursor
     (sprite : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      xfocus : int;
      yfocus : int) return access ALLEGRO_MOUSE_CURSOR  -- /usr/include/allegro5/mouse_cursor.h:41
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_mouse_cursor";

   procedure al_destroy_mouse_cursor (arg1 : access ALLEGRO_MOUSE_CURSOR)  -- /usr/include/allegro5/mouse_cursor.h:43
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_mouse_cursor";

   function al_set_mouse_cursor (display : access allegro5_events_h.ALLEGRO_DISPLAY; cursor : access ALLEGRO_MOUSE_CURSOR) return Extensions.bool  -- /usr/include/allegro5/mouse_cursor.h:44
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_mouse_cursor";

   function al_set_system_mouse_cursor (display : access allegro5_events_h.ALLEGRO_DISPLAY; cursor_id : ALLEGRO_SYSTEM_MOUSE_CURSOR) return Extensions.bool  -- /usr/include/allegro5/mouse_cursor.h:46
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_system_mouse_cursor";

   function al_show_mouse_cursor (display : access allegro5_events_h.ALLEGRO_DISPLAY) return Extensions.bool  -- /usr/include/allegro5/mouse_cursor.h:48
   with Import => True, 
        Convention => C, 
        External_Name => "al_show_mouse_cursor";

   function al_hide_mouse_cursor (display : access allegro5_events_h.ALLEGRO_DISPLAY) return Extensions.bool  -- /usr/include/allegro5/mouse_cursor.h:49
   with Import => True, 
        Convention => C, 
        External_Name => "al_hide_mouse_cursor";

  -- vim: set sts=3 sw=3 et:  
end allegro5_mouse_cursor_h;

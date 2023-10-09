pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with allegro5_color_h;

package allegro5_drawing_h is

  -- Drawing primitives  
   procedure al_clear_to_color (color : allegro5_color_h.ALLEGRO_COLOR)  -- /usr/include/allegro5/drawing.h:12
   with Import => True, 
        Convention => C, 
        External_Name => "al_clear_to_color";

   procedure al_clear_depth_buffer (x : float)  -- /usr/include/allegro5/drawing.h:13
   with Import => True, 
        Convention => C, 
        External_Name => "al_clear_depth_buffer";

   procedure al_draw_pixel
     (x : float;
      y : float;
      color : allegro5_color_h.ALLEGRO_COLOR)  -- /usr/include/allegro5/drawing.h:14
   with Import => True, 
        Convention => C, 
        External_Name => "al_draw_pixel";

  -- vim: set ts=8 sts=3 sw=3 et:  
end allegro5_drawing_h;

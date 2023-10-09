pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with allegro5_color_h;

package allegro5_blender_h is

  -- * Blending modes
  --  

   type ALLEGRO_BLEND_MODE is 
     (ALLEGRO_ZERO,
      ALLEGRO_ONE,
      ALLEGRO_ALPHA,
      ALLEGRO_INVERSE_ALPHA,
      ALLEGRO_SRC_COLOR,
      ALLEGRO_DEST_COLOR,
      ALLEGRO_INVERSE_SRC_COLOR,
      ALLEGRO_INVERSE_DEST_COLOR,
      ALLEGRO_CONST_COLOR,
      ALLEGRO_INVERSE_CONST_COLOR,
      ALLEGRO_NUM_BLEND_MODES)
   with Convention => C;  -- /usr/include/allegro5/blender.h:15

   type ALLEGRO_BLEND_OPERATIONS is 
     (ALLEGRO_ADD,
      ALLEGRO_SRC_MINUS_DEST,
      ALLEGRO_DEST_MINUS_SRC,
      ALLEGRO_NUM_BLEND_OPERATIONS)
   with Convention => C;  -- /usr/include/allegro5/blender.h:29

   procedure al_set_blender
     (op : int;
      source : int;
      dest : int)  -- /usr/include/allegro5/blender.h:37
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_blender";

   procedure al_set_blend_color (color : allegro5_color_h.ALLEGRO_COLOR)  -- /usr/include/allegro5/blender.h:38
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_blend_color";

   procedure al_get_blender
     (op : access int;
      source : access int;
      dest : access int)  -- /usr/include/allegro5/blender.h:39
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_blender";

   function al_get_blend_color return allegro5_color_h.ALLEGRO_COLOR  -- /usr/include/allegro5/blender.h:40
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_blend_color";

   procedure al_set_separate_blender
     (op : int;
      source : int;
      dest : int;
      alpha_op : int;
      alpha_source : int;
      alpha_dest : int)  -- /usr/include/allegro5/blender.h:41
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_separate_blender";

   procedure al_get_separate_blender
     (op : access int;
      source : access int;
      dest : access int;
      alpha_op : access int;
      alpha_src : access int;
      alpha_dest : access int)  -- /usr/include/allegro5/blender.h:43
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_separate_blender";

end allegro5_blender_h;

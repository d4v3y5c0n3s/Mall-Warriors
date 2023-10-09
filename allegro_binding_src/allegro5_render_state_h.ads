pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package allegro5_render_state_h is

  -- Enum: ALLEGRO_RENDER_STATE
  --  

   subtype ALLEGRO_RENDER_STATE is unsigned;
   ALLEGRO_ALPHA_TEST : constant unsigned := 16;
   ALLEGRO_WRITE_MASK : constant unsigned := 17;
   ALLEGRO_DEPTH_TEST : constant unsigned := 18;
   ALLEGRO_DEPTH_FUNCTION : constant unsigned := 19;
   ALLEGRO_ALPHA_FUNCTION : constant unsigned := 20;
   ALLEGRO_ALPHA_TEST_VALUE : constant unsigned := 21;  -- /usr/include/allegro5/render_state.h:12

  -- ALLEGRO_ALPHA_TEST was the name of a rare bitmap flag only used on the
  --    * Wiz port.  Reuse the name but retain the same value.
  --     

  -- Enum: ALLEGRO_RENDER_FUNCTION
  --  

   type ALLEGRO_RENDER_FUNCTION is 
     (ALLEGRO_RENDER_NEVER,
      ALLEGRO_RENDER_ALWAYS,
      ALLEGRO_RENDER_LESS,
      ALLEGRO_RENDER_EQUAL,
      ALLEGRO_RENDER_LESS_EQUAL,
      ALLEGRO_RENDER_GREATER,
      ALLEGRO_RENDER_NOT_EQUAL,
      ALLEGRO_RENDER_GREATER_EQUAL)
   with Convention => C;  -- /usr/include/allegro5/render_state.h:26

  -- Enum: ALLEGRO_WRITE_MASK_FLAGS
  --  

   subtype ALLEGRO_WRITE_MASK_FLAGS is unsigned;
   ALLEGRO_MASK_RED : constant unsigned := 1;
   ALLEGRO_MASK_GREEN : constant unsigned := 2;
   ALLEGRO_MASK_BLUE : constant unsigned := 4;
   ALLEGRO_MASK_ALPHA : constant unsigned := 8;
   ALLEGRO_MASK_DEPTH : constant unsigned := 16;
   ALLEGRO_MASK_RGB : constant unsigned := 7;
   ALLEGRO_MASK_RGBA : constant unsigned := 15;  -- /usr/include/allegro5/render_state.h:39

   procedure al_set_render_state (state : ALLEGRO_RENDER_STATE; value : int)  -- /usr/include/allegro5/render_state.h:49
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_render_state";

end allegro5_render_state_h;

pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;
limited with allegro5_bitmap_h;
limited with allegro5_transformations_h;

package allegro5_shader_h is

   ALLEGRO_SHADER_VAR_COLOR : aliased constant String := "al_color" & ASCII.NUL;  --  /usr/include/allegro5/shader.h:36
   ALLEGRO_SHADER_VAR_POS : aliased constant String := "al_pos" & ASCII.NUL;  --  /usr/include/allegro5/shader.h:37
   ALLEGRO_SHADER_VAR_PROJVIEW_MATRIX : aliased constant String := "al_projview_matrix" & ASCII.NUL;  --  /usr/include/allegro5/shader.h:38
   ALLEGRO_SHADER_VAR_TEX : aliased constant String := "al_tex" & ASCII.NUL;  --  /usr/include/allegro5/shader.h:39
   ALLEGRO_SHADER_VAR_TEXCOORD : aliased constant String := "al_texcoord" & ASCII.NUL;  --  /usr/include/allegro5/shader.h:40
   ALLEGRO_SHADER_VAR_TEX_MATRIX : aliased constant String := "al_tex_matrix" & ASCII.NUL;  --  /usr/include/allegro5/shader.h:41
   ALLEGRO_SHADER_VAR_USER_ATTR : aliased constant String := "al_user_attr_" & ASCII.NUL;  --  /usr/include/allegro5/shader.h:42
   ALLEGRO_SHADER_VAR_USE_TEX : aliased constant String := "al_use_tex" & ASCII.NUL;  --  /usr/include/allegro5/shader.h:43
   ALLEGRO_SHADER_VAR_USE_TEX_MATRIX : aliased constant String := "al_use_tex_matrix" & ASCII.NUL;  --  /usr/include/allegro5/shader.h:44
   ALLEGRO_SHADER_VAR_ALPHA_TEST : aliased constant String := "al_alpha_test" & ASCII.NUL;  --  /usr/include/allegro5/shader.h:45
   ALLEGRO_SHADER_VAR_ALPHA_FUNCTION : aliased constant String := "al_alpha_func" & ASCII.NUL;  --  /usr/include/allegro5/shader.h:46
   ALLEGRO_SHADER_VAR_ALPHA_TEST_VALUE : aliased constant String := "al_alpha_test_val" & ASCII.NUL;  --  /usr/include/allegro5/shader.h:47

  -- Type: ALLEGRO_SHADER
  --  

   type ALLEGRO_SHADER is null record;   -- incomplete struct

   subtype ALLEGRO_SHADER_TYPE is unsigned;
   ALLEGRO_VERTEX_SHADER : constant unsigned := 1;
   ALLEGRO_PIXEL_SHADER : constant unsigned := 2;  -- /usr/include/allegro5/shader.h:16

  -- Enum: ALLEGRO_SHADER_TYPE
  --  

   type ALLEGRO_SHADER_PLATFORM is 
     (ALLEGRO_SHADER_AUTO,
      ALLEGRO_SHADER_GLSL,
      ALLEGRO_SHADER_HLSL)
   with Convention => C;  -- /usr/include/allegro5/shader.h:25

  -- Enum: ALLEGRO_SHADER_PLATFORM
  --  

  -- Shader variable names  
   function al_create_shader (platform : ALLEGRO_SHADER_PLATFORM) return access ALLEGRO_SHADER  -- /usr/include/allegro5/shader.h:49
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_shader";

   function al_attach_shader_source
     (shader : access ALLEGRO_SHADER;
      c_type : ALLEGRO_SHADER_TYPE;
      source : Interfaces.C.Strings.chars_ptr) return Extensions.bool  -- /usr/include/allegro5/shader.h:50
   with Import => True, 
        Convention => C, 
        External_Name => "al_attach_shader_source";

   function al_attach_shader_source_file
     (shader : access ALLEGRO_SHADER;
      c_type : ALLEGRO_SHADER_TYPE;
      filename : Interfaces.C.Strings.chars_ptr) return Extensions.bool  -- /usr/include/allegro5/shader.h:52
   with Import => True, 
        Convention => C, 
        External_Name => "al_attach_shader_source_file";

   function al_build_shader (shader : access ALLEGRO_SHADER) return Extensions.bool  -- /usr/include/allegro5/shader.h:54
   with Import => True, 
        Convention => C, 
        External_Name => "al_build_shader";

   function al_get_shader_log (shader : access ALLEGRO_SHADER) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/shader.h:55
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_shader_log";

   function al_get_shader_platform (shader : access ALLEGRO_SHADER) return ALLEGRO_SHADER_PLATFORM  -- /usr/include/allegro5/shader.h:56
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_shader_platform";

   function al_use_shader (shader : access ALLEGRO_SHADER) return Extensions.bool  -- /usr/include/allegro5/shader.h:57
   with Import => True, 
        Convention => C, 
        External_Name => "al_use_shader";

   procedure al_destroy_shader (shader : access ALLEGRO_SHADER)  -- /usr/include/allegro5/shader.h:58
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_shader";

   function al_set_shader_sampler
     (name : Interfaces.C.Strings.chars_ptr;
      bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP;
      unit : int) return Extensions.bool  -- /usr/include/allegro5/shader.h:60
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_shader_sampler";

   function al_set_shader_matrix (name : Interfaces.C.Strings.chars_ptr; matrix : access constant allegro5_transformations_h.ALLEGRO_TRANSFORM) return Extensions.bool  -- /usr/include/allegro5/shader.h:62
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_shader_matrix";

   function al_set_shader_int (name : Interfaces.C.Strings.chars_ptr; i : int) return Extensions.bool  -- /usr/include/allegro5/shader.h:64
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_shader_int";

   function al_set_shader_float (name : Interfaces.C.Strings.chars_ptr; f : float) return Extensions.bool  -- /usr/include/allegro5/shader.h:65
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_shader_float";

   function al_set_shader_int_vector
     (name : Interfaces.C.Strings.chars_ptr;
      num_components : int;
      i : access int;
      num_elems : int) return Extensions.bool  -- /usr/include/allegro5/shader.h:66
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_shader_int_vector";

   function al_set_shader_float_vector
     (name : Interfaces.C.Strings.chars_ptr;
      num_components : int;
      f : access float;
      num_elems : int) return Extensions.bool  -- /usr/include/allegro5/shader.h:68
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_shader_float_vector";

   function al_set_shader_bool (name : Interfaces.C.Strings.chars_ptr; b : Extensions.bool) return Extensions.bool  -- /usr/include/allegro5/shader.h:70
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_shader_bool";

   function al_get_default_shader_source (platform : ALLEGRO_SHADER_PLATFORM; c_type : ALLEGRO_SHADER_TYPE) return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/shader.h:72
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_default_shader_source";

  -- vim: set sts=3 sw=3 et:  
end allegro5_shader_h;

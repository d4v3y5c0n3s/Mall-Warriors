pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package allegro5_transformations_h is

  -- Type: ALLEGRO_TRANSFORM
  --  

   type ALLEGRO_TRANSFORM;
   type anon2308_array2311 is array (0 .. 3, 0 .. 3) of aliased float;
   type ALLEGRO_TRANSFORM is record
      m : aliased anon2308_array2311;  -- /usr/include/allegro5/transformations.h:15
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/transformations.h:14

  -- Transformations 
   procedure al_use_transform (trans : access constant ALLEGRO_TRANSFORM)  -- /usr/include/allegro5/transformations.h:19
   with Import => True, 
        Convention => C, 
        External_Name => "al_use_transform";

   procedure al_use_projection_transform (trans : access constant ALLEGRO_TRANSFORM)  -- /usr/include/allegro5/transformations.h:20
   with Import => True, 
        Convention => C, 
        External_Name => "al_use_projection_transform";

   procedure al_copy_transform (dest : access ALLEGRO_TRANSFORM; src : access constant ALLEGRO_TRANSFORM)  -- /usr/include/allegro5/transformations.h:21
   with Import => True, 
        Convention => C, 
        External_Name => "al_copy_transform";

   procedure al_identity_transform (trans : access ALLEGRO_TRANSFORM)  -- /usr/include/allegro5/transformations.h:22
   with Import => True, 
        Convention => C, 
        External_Name => "al_identity_transform";

   procedure al_build_transform
     (trans : access ALLEGRO_TRANSFORM;
      x : float;
      y : float;
      sx : float;
      sy : float;
      theta : float)  -- /usr/include/allegro5/transformations.h:23
   with Import => True, 
        Convention => C, 
        External_Name => "al_build_transform";

   procedure al_build_camera_transform
     (trans : access ALLEGRO_TRANSFORM;
      position_x : float;
      position_y : float;
      position_z : float;
      look_x : float;
      look_y : float;
      look_z : float;
      up_x : float;
      up_y : float;
      up_z : float)  -- /usr/include/allegro5/transformations.h:24
   with Import => True, 
        Convention => C, 
        External_Name => "al_build_camera_transform";

   procedure al_translate_transform
     (trans : access ALLEGRO_TRANSFORM;
      x : float;
      y : float)  -- /usr/include/allegro5/transformations.h:28
   with Import => True, 
        Convention => C, 
        External_Name => "al_translate_transform";

   procedure al_translate_transform_3d
     (trans : access ALLEGRO_TRANSFORM;
      x : float;
      y : float;
      z : float)  -- /usr/include/allegro5/transformations.h:29
   with Import => True, 
        Convention => C, 
        External_Name => "al_translate_transform_3d";

   procedure al_rotate_transform (trans : access ALLEGRO_TRANSFORM; theta : float)  -- /usr/include/allegro5/transformations.h:30
   with Import => True, 
        Convention => C, 
        External_Name => "al_rotate_transform";

   procedure al_rotate_transform_3d
     (trans : access ALLEGRO_TRANSFORM;
      x : float;
      y : float;
      z : float;
      angle : float)  -- /usr/include/allegro5/transformations.h:31
   with Import => True, 
        Convention => C, 
        External_Name => "al_rotate_transform_3d";

   procedure al_scale_transform
     (trans : access ALLEGRO_TRANSFORM;
      sx : float;
      sy : float)  -- /usr/include/allegro5/transformations.h:32
   with Import => True, 
        Convention => C, 
        External_Name => "al_scale_transform";

   procedure al_scale_transform_3d
     (trans : access ALLEGRO_TRANSFORM;
      sx : float;
      sy : float;
      sz : float)  -- /usr/include/allegro5/transformations.h:33
   with Import => True, 
        Convention => C, 
        External_Name => "al_scale_transform_3d";

   procedure al_transform_coordinates
     (trans : access constant ALLEGRO_TRANSFORM;
      x : access float;
      y : access float)  -- /usr/include/allegro5/transformations.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "al_transform_coordinates";

   procedure al_transform_coordinates_3d
     (trans : access constant ALLEGRO_TRANSFORM;
      x : access float;
      y : access float;
      z : access float)  -- /usr/include/allegro5/transformations.h:35
   with Import => True, 
        Convention => C, 
        External_Name => "al_transform_coordinates_3d";

   procedure al_transform_coordinates_4d
     (trans : access constant ALLEGRO_TRANSFORM;
      x : access float;
      y : access float;
      z : access float;
      w : access float)  -- /usr/include/allegro5/transformations.h:37
   with Import => True, 
        Convention => C, 
        External_Name => "al_transform_coordinates_4d";

   procedure al_transform_coordinates_3d_projective
     (trans : access constant ALLEGRO_TRANSFORM;
      x : access float;
      y : access float;
      z : access float)  -- /usr/include/allegro5/transformations.h:39
   with Import => True, 
        Convention => C, 
        External_Name => "al_transform_coordinates_3d_projective";

   procedure al_compose_transform (trans : access ALLEGRO_TRANSFORM; other : access constant ALLEGRO_TRANSFORM)  -- /usr/include/allegro5/transformations.h:41
   with Import => True, 
        Convention => C, 
        External_Name => "al_compose_transform";

   function al_get_current_transform return access constant ALLEGRO_TRANSFORM  -- /usr/include/allegro5/transformations.h:42
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_current_transform";

   function al_get_current_inverse_transform return access constant ALLEGRO_TRANSFORM  -- /usr/include/allegro5/transformations.h:43
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_current_inverse_transform";

   function al_get_current_projection_transform return access constant ALLEGRO_TRANSFORM  -- /usr/include/allegro5/transformations.h:44
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_current_projection_transform";

   procedure al_invert_transform (trans : access ALLEGRO_TRANSFORM)  -- /usr/include/allegro5/transformations.h:45
   with Import => True, 
        Convention => C, 
        External_Name => "al_invert_transform";

   procedure al_transpose_transform (trans : access ALLEGRO_TRANSFORM)  -- /usr/include/allegro5/transformations.h:46
   with Import => True, 
        Convention => C, 
        External_Name => "al_transpose_transform";

   function al_check_inverse (trans : access constant ALLEGRO_TRANSFORM; tol : float) return int  -- /usr/include/allegro5/transformations.h:47
   with Import => True, 
        Convention => C, 
        External_Name => "al_check_inverse";

   procedure al_orthographic_transform
     (trans : access ALLEGRO_TRANSFORM;
      left : float;
      top : float;
      n : float;
      right : float;
      bottom : float;
      f : float)  -- /usr/include/allegro5/transformations.h:48
   with Import => True, 
        Convention => C, 
        External_Name => "al_orthographic_transform";

   procedure al_perspective_transform
     (trans : access ALLEGRO_TRANSFORM;
      left : float;
      top : float;
      n : float;
      right : float;
      bottom : float;
      f : float)  -- /usr/include/allegro5/transformations.h:49
   with Import => True, 
        Convention => C, 
        External_Name => "al_perspective_transform";

   procedure al_horizontal_shear_transform (trans : access ALLEGRO_TRANSFORM; theta : float)  -- /usr/include/allegro5/transformations.h:50
   with Import => True, 
        Convention => C, 
        External_Name => "al_horizontal_shear_transform";

   procedure al_vertical_shear_transform (trans : access ALLEGRO_TRANSFORM; theta : float)  -- /usr/include/allegro5/transformations.h:51
   with Import => True, 
        Convention => C, 
        External_Name => "al_vertical_shear_transform";

end allegro5_transformations_h;

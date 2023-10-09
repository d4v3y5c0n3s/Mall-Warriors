pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package allegro5_fullscreen_mode_h is

  -- Type: ALLEGRO_DISPLAY_MODE
  --  

   type ALLEGRO_DISPLAY_MODE is record
      width : aliased int;  -- /usr/include/allegro5/fullscreen_mode.h:15
      height : aliased int;  -- /usr/include/allegro5/fullscreen_mode.h:16
      format : aliased int;  -- /usr/include/allegro5/fullscreen_mode.h:17
      refresh_rate : aliased int;  -- /usr/include/allegro5/fullscreen_mode.h:18
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/fullscreen_mode.h:13

   function al_get_num_display_modes return int  -- /usr/include/allegro5/fullscreen_mode.h:22
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_num_display_modes";

   function al_get_display_mode (index : int; mode : access ALLEGRO_DISPLAY_MODE) return access ALLEGRO_DISPLAY_MODE  -- /usr/include/allegro5/fullscreen_mode.h:23
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_display_mode";

  -- vim: set ts=8 sts=3 sw=3 et:  
end allegro5_fullscreen_mode_h;

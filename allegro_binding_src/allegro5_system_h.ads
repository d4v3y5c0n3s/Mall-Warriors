pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Extensions;
limited with allegro5_config_h;
limited with allegro5_path_h;
with Interfaces.C.Strings;

package allegro5_system_h is

   --  arg-macro: function al_init ()
   --    return al_install_system(ALLEGRO_VERSION_INT, atexit);
   type ALLEGRO_SYSTEM is null record;   -- incomplete struct

  -- Enum: ALLEGRO_SYSTEM_ID
  --  

   subtype ALLEGRO_SYSTEM_ID is unsigned;
   ALLEGRO_SYSTEM_ID_UNKNOWN : constant unsigned := 0;
   ALLEGRO_SYSTEM_ID_XGLX : constant unsigned := 1481067608;
   ALLEGRO_SYSTEM_ID_WINDOWS : constant unsigned := 1464421956;
   ALLEGRO_SYSTEM_ID_MACOSX : constant unsigned := 1330862112;
   ALLEGRO_SYSTEM_ID_ANDROID : constant unsigned := 1095648338;
   ALLEGRO_SYSTEM_ID_IPHONE : constant unsigned := 1229998159;
   ALLEGRO_SYSTEM_ID_GP2XWIZ : constant unsigned := 1464424992;
   ALLEGRO_SYSTEM_ID_RASPBERRYPI : constant unsigned := 1380012880;
   ALLEGRO_SYSTEM_ID_SDL : constant unsigned := 1396984882;  -- /usr/include/allegro5/system.h:15

  -- Function: al_init
  --  

   function al_install_system (version : int; atexit_ptr : access function (arg1 : access procedure) return int) return Extensions.bool  -- /usr/include/allegro5/system.h:32
   with Import => True, 
        Convention => C, 
        External_Name => "al_install_system";

   procedure al_uninstall_system  -- /usr/include/allegro5/system.h:33
   with Import => True, 
        Convention => C, 
        External_Name => "al_uninstall_system";

   function al_is_system_installed return Extensions.bool  -- /usr/include/allegro5/system.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_system_installed";

   function al_get_system_driver return access ALLEGRO_SYSTEM  -- /usr/include/allegro5/system.h:35
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_system_driver";

   function al_get_system_config return access allegro5_config_h.ALLEGRO_CONFIG  -- /usr/include/allegro5/system.h:36
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_system_config";

   function al_get_system_id return ALLEGRO_SYSTEM_ID  -- /usr/include/allegro5/system.h:37
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_system_id";

  -- must be last  
   function al_get_standard_path (id : int) return access allegro5_path_h.ALLEGRO_PATH  -- /usr/include/allegro5/system.h:50
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_standard_path";

   procedure al_set_exe_name (path : Interfaces.C.Strings.chars_ptr)  -- /usr/include/allegro5/system.h:51
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_exe_name";

   procedure al_set_org_name (org_name : Interfaces.C.Strings.chars_ptr)  -- /usr/include/allegro5/system.h:53
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_org_name";

   procedure al_set_app_name (app_name : Interfaces.C.Strings.chars_ptr)  -- /usr/include/allegro5/system.h:54
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_app_name";

   function al_get_org_name return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/system.h:55
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_org_name";

   function al_get_app_name return Interfaces.C.Strings.chars_ptr  -- /usr/include/allegro5/system.h:56
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_app_name";

   function al_inhibit_screensaver (inhibit : Extensions.bool) return Extensions.bool  -- /usr/include/allegro5/system.h:58
   with Import => True, 
        Convention => C, 
        External_Name => "al_inhibit_screensaver";

  -- vim: set sts=3 sw=3 et:  
end allegro5_system_h;

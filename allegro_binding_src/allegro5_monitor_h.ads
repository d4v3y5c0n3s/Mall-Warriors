pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Extensions;

package allegro5_monitor_h is

  -- Type: ALLEGRO_MONITOR_INFO
  --  

   type ALLEGRO_MONITOR_INFO is record
      x1 : aliased int;  -- /usr/include/allegro5/monitor.h:15
      y1 : aliased int;  -- /usr/include/allegro5/monitor.h:16
      x2 : aliased int;  -- /usr/include/allegro5/monitor.h:17
      y2 : aliased int;  -- /usr/include/allegro5/monitor.h:18
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/monitor.h:13

   function al_get_num_video_adapters return int  -- /usr/include/allegro5/monitor.h:25
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_num_video_adapters";

   function al_get_monitor_info (adapter : int; info : access ALLEGRO_MONITOR_INFO) return Extensions.bool  -- /usr/include/allegro5/monitor.h:26
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_monitor_info";

   function al_get_monitor_dpi (adapter : int) return int  -- /usr/include/allegro5/monitor.h:27
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_monitor_dpi";

  -- vim: set ts=8 sts=3 sw=3 et:  
end allegro5_monitor_h;

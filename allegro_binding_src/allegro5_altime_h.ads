pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with x86_64_linux_gnu_bits_stdint_uintn_h;

package allegro5_altime_h is

  -- Type: ALLEGRO_TIMEOUT
  --  

   type ALLEGRO_TIMEOUT;
   type ALLEGRO_TIMEOUT is record
      uu_pad1_u_u : aliased x86_64_linux_gnu_bits_stdint_uintn_h.uint64_t;  -- /usr/include/allegro5/altime.h:14
      uu_pad2_u_u : aliased x86_64_linux_gnu_bits_stdint_uintn_h.uint64_t;  -- /usr/include/allegro5/altime.h:15
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/altime.h:13

   function al_get_time return double  -- /usr/include/allegro5/altime.h:20
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_time";

   procedure al_rest (seconds : double)  -- /usr/include/allegro5/altime.h:21
   with Import => True, 
        Convention => C, 
        External_Name => "al_rest";

   procedure al_init_timeout (timeout : access ALLEGRO_TIMEOUT; seconds : double)  -- /usr/include/allegro5/altime.h:22
   with Import => True, 
        Convention => C, 
        External_Name => "al_init_timeout";

end allegro5_altime_h;

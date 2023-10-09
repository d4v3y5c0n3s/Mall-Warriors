pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Extensions;
with x86_64_linux_gnu_bits_stdint_uintn_h;

package allegro_acodec_h is

   --  unsupported macro: ALLEGRO_ACODEC_FUNC AL_FUNC
   function al_init_acodec_addon return Extensions.bool  -- addons/acodec/allegro5/allegro_acodec.h:32
   with Import => True, 
        Convention => C, 
        External_Name => "al_init_acodec_addon";

   function al_is_acodec_addon_initialized return Extensions.bool  -- addons/acodec/allegro5/allegro_acodec.h:33
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_acodec_addon_initialized";

   function al_get_allegro_acodec_version return x86_64_linux_gnu_bits_stdint_uintn_h.uint32_t  -- addons/acodec/allegro5/allegro_acodec.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_allegro_acodec_version";

end allegro_acodec_h;

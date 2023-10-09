pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Extensions;
with x86_64_linux_gnu_bits_stdint_uintn_h;

package allegro_image_h is

   --  unsupported macro: ALLEGRO_IIO_FUNC AL_FUNC
   function al_init_image_addon return Extensions.bool  -- addons/image/allegro5/allegro_image.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "al_init_image_addon";

   function al_is_image_addon_initialized return Extensions.bool  -- addons/image/allegro5/allegro_image.h:35
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_image_addon_initialized";

   procedure al_shutdown_image_addon  -- addons/image/allegro5/allegro_image.h:36
   with Import => True, 
        Convention => C, 
        External_Name => "al_shutdown_image_addon";

   function al_get_allegro_image_version return x86_64_linux_gnu_bits_stdint_uintn_h.uint32_t  -- addons/image/allegro5/allegro_image.h:37
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_allegro_image_version";

end allegro_image_h;

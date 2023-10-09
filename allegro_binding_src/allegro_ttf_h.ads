pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
limited with allegro5_allegro_font_h;
limited with allegro5_file_h;
with Interfaces.C.Extensions;
with x86_64_linux_gnu_bits_stdint_uintn_h;

package allegro_ttf_h is

   ALLEGRO_TTF_NO_KERNING : constant := 1;  --  addons/ttf/allegro5/allegro_ttf.h:11
   ALLEGRO_TTF_MONOCHROME : constant := 2;  --  addons/ttf/allegro5/allegro_ttf.h:12
   ALLEGRO_TTF_NO_AUTOHINT : constant := 4;  --  addons/ttf/allegro5/allegro_ttf.h:13
   --  unsupported macro: ALLEGRO_TTF_FUNC AL_FUNC

   function al_load_ttf_font
     (filename : Interfaces.C.Strings.chars_ptr;
      size : int;
      flags : int) return access allegro5_allegro_font_h.ALLEGRO_FONT  -- addons/ttf/allegro5/allegro_ttf.h:37
   with Import => True, 
        Convention => C, 
        External_Name => "al_load_ttf_font";

   function al_load_ttf_font_f
     (file : access allegro5_file_h.ALLEGRO_FILE;
      filename : Interfaces.C.Strings.chars_ptr;
      size : int;
      flags : int) return access allegro5_allegro_font_h.ALLEGRO_FONT  -- addons/ttf/allegro5/allegro_ttf.h:38
   with Import => True, 
        Convention => C, 
        External_Name => "al_load_ttf_font_f";

   function al_load_ttf_font_stretch
     (filename : Interfaces.C.Strings.chars_ptr;
      w : int;
      h : int;
      flags : int) return access allegro5_allegro_font_h.ALLEGRO_FONT  -- addons/ttf/allegro5/allegro_ttf.h:39
   with Import => True, 
        Convention => C, 
        External_Name => "al_load_ttf_font_stretch";

   function al_load_ttf_font_stretch_f
     (file : access allegro5_file_h.ALLEGRO_FILE;
      filename : Interfaces.C.Strings.chars_ptr;
      w : int;
      h : int;
      flags : int) return access allegro5_allegro_font_h.ALLEGRO_FONT  -- addons/ttf/allegro5/allegro_ttf.h:40
   with Import => True, 
        Convention => C, 
        External_Name => "al_load_ttf_font_stretch_f";

   function al_init_ttf_addon return Extensions.bool  -- addons/ttf/allegro5/allegro_ttf.h:41
   with Import => True, 
        Convention => C, 
        External_Name => "al_init_ttf_addon";

   function al_is_ttf_addon_initialized return Extensions.bool  -- addons/ttf/allegro5/allegro_ttf.h:42
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_ttf_addon_initialized";

   procedure al_shutdown_ttf_addon  -- addons/ttf/allegro5/allegro_ttf.h:43
   with Import => True, 
        Convention => C, 
        External_Name => "al_shutdown_ttf_addon";

   function al_get_allegro_ttf_version return x86_64_linux_gnu_bits_stdint_uintn_h.uint32_t  -- addons/ttf/allegro5/allegro_ttf.h:44
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_allegro_ttf_version";

end allegro_ttf_h;

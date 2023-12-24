with Fighter;
with Globals; use Globals;
with Cool_Math; use Cool_Math;
with allegro5_bitmap_h; use allegro5_bitmap_h;

package Fighter_Data is
  
  type Fighter_Options is (Shambler, Test);
  
  function Load_Fighter (F : Fighter_Options) return Fighter.Fighter;
  
  function Fighter_Name (F : Fighter_Options) return String;
  
  function Fighter_Icon (F : Fighter_Options) return access ALLEGRO_BITMAP;
  
end Fighter_Data;

with Fighter;
with Globals; use Globals;
with Cool_Math; use Cool_Math;
with allegro5_bitmap_h; use allegro5_bitmap_h;

package Fighter_Data is
  
  type Fighter_Options is (Shambler, Test);
  
  type Fighter_Move_Name is access String;
  type Fighter_Move_Name_Array is array(Natural range <>) of Fighter_Move_Name;
  type Fighter_Move_Index_Array is array(Natural range <>) of Natural;
  
  function Load_Fighter (F : Fighter_Options) return Fighter.Fighter;
  
  function Fighter_Name (F : Fighter_Options) return String;
  
  function Fighter_Icon (F : Fighter_Options) return ALLEGRO_BITMAP_ACCESS;
  
  function Fighter_Move_Names (F : Fighter_Options) return Fighter_Move_Name_Array;
  
  function Fighter_Move_Indexes (F : Fighter_Options) return Fighter_Move_Index_Array;
  
end Fighter_Data;

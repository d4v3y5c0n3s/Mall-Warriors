with Fighter;
with Globals; use Globals;
with Cool_Math; use Cool_Math;

package Fighter_Data is
  
  type Fighter_Options is (Shambler, Test);
  
  function Load_Fighter (F : Fighter_Options) return Fighter.Fighter;
end Fighter_Data;

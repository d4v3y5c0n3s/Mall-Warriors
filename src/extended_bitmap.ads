with Cool_Math; use Cool_Math;
with allegro5_bitmap_h;
with Globals; use Globals;

package Extended_Bitmap is

  type Extended_Bitmap is record
    pos : Position;
    graphic : allegro5_bitmap_h.ALLEGRO_BITMAP_ACCESS;
    graphic_width, graphic_height : Float := 0.0;
    active_anim : Animation_Data_Access;
    anim_index : Natural := 0;
    anim_frame : Natural := 0;
    x_offset : Scalar;
    shown : Boolean := false;
  end record;
  
  procedure Frame_Update (E : in out Extended_Bitmap);
  
  procedure Draw (E : Extended_Bitmap; fighter_pos : Position; faces_right : Boolean);
  
end Extended_Bitmap;

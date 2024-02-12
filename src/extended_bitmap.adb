with allegro5_bitmap_draw_h;
with Interfaces.C;

package body Extended_Bitmap is

  procedure Frame_Update (E : in out Extended_Bitmap) is
  begin
    if E.anim_frame = E.active_anim(E.anim_index).frame_dration then
      E.anim_frame := 0;
      E.anim_index := E.anim_index + 1;
      
      if E.anim_index > E.active_anim'Last then
        E.anim_index := 0;
      end if;
    else
      E.anim_frame := E.anim_frame + 1;
    end if;
  end Frame_Update;
  
  procedure Draw (E : Extended_Bitmap; fighter_pos : Position; faces_right : Boolean) is
    sprite_facing : constant Interfaces.C.int := (if not faces_right then 1 else 0);
    current_anim_frame : constant Animation_Frame := E.active_anim(E.anim_index);
    x_pos : constant Scalar := (if not faces_right then -E.pos.X else E.pos.X);
  begin
    allegro5_bitmap_draw_h.al_draw_bitmap_region(
      E.graphic,
      current_anim_frame.x_start, current_anim_frame.y_start,
      E.graphic_width, E.graphic_height,
      Float(fighter_pos.X + x_pos + E.x_offset), Float(fighter_pos.Y + E.pos.Y),
      sprite_facing
    );
  end Draw;
  
end Extended_Bitmap;

with allegro5_bitmap_draw_h;
with Interfaces.C;

package body Projectile is
  
  procedure Frame_Update (P : in out Projectile) is
    facing_x_modify : constant Scalar := (if P.going_right then 1.0 else -1.0);
    movement : constant Position := Position'(X => (P.movement_per_frame.X * facing_x_modify), Y => P.movement_per_frame.Y);
  begin
    P.pos := P.pos + movement;
    
    if P.anim_frame = P.active_anim(P.anim_index).frame_dration then
      P.anim_frame := 0;
      P.anim_index := P.anim_index + 1;
      
      if P.anim_index > P.active_anim'Last then
        P.anim_index := 0;
      end if;
    else
      P.anim_frame := P.anim_frame + 1;
    end if;
    
    P.frames_to_live := P.frames_to_live - 1;
  end Frame_Update;
  
  procedure Draw (P : Projectile) is
    sprite_facing : constant Interfaces.C.int := (if not P.going_right then 1 else 0);
    current_anim_frame : constant Animation_Frame := P.active_anim(P.anim_index);
  begin
    allegro5_bitmap_draw_h.al_draw_bitmap_region(
      P.graphic,
      current_anim_frame.x_start, current_anim_frame.y_start,
      P.graphic_width, P.graphic_height,
      Float(P.pos.X + P.x_offset), Float(P.pos.Y),
      sprite_facing
    );
  end Draw;
  
  function Make_Projectile (
    pos : Position;
    hitboxes_to_add : To_Add_Hitboxes;
    movement : Position;
    graphic : allegro5_bitmap_h.ALLEGRO_BITMAP_ACCESS;
    graphic_width, graphic_height : Float;
    x_offset : Scalar;
    main_anim : Animation_Data_Access;
    frames_to_live : Natural
  ) return Projectile is
    hitbox_list : Projectile_Hitboxes.List;
  begin
    for HB of hitboxes_to_add loop
      Projectile_Hitboxes.Append(hitbox_list, HB);
    end loop;
    
    return Projectile'(
      pos => pos,
      hitboxes => hitbox_list,
      movement_per_frame => movement,
      going_right => true,
      graphic => graphic,
      graphic_width => graphic_width,
      graphic_height => graphic_height,
      x_offset => x_offset,
      main_anim => main_anim,
      active_anim => main_anim,
      anim_index => 0,
      anim_frame => 0,
      frames_to_live => frames_to_live
    );
  end Make_Projectile;
  
end Projectile;

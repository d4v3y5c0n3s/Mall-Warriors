with Cool_Math; use Cool_Math;
with Globals; use Globals;
with allegro5_bitmap_h;
with Ada.Containers.Doubly_Linked_Lists;

package Projectile is
  
  package Projectile_Hitboxes is new Ada.Containers.Doubly_Linked_Lists(Hitbox);

  type Projectile is record
    pos : Position;
    hitboxes : Projectile_Hitboxes.List;
    movement_per_frame : Position;
    going_right : Boolean := true;
    graphic : allegro5_bitmap_h.ALLEGRO_BITMAP_ACCESS;
    graphic_width, graphic_height : Float := 0.0;
    x_offset : Scalar;
    main_anim : Animation_Data_Access;
    active_anim : Animation_Data_Access;
    anim_index : Natural := 0;
    anim_frame : Natural := 0;
    frames_to_live : Natural := 0;
  end record;
  
  procedure Frame_Update (P : in out Projectile);
  
  procedure Draw (P : Projectile);
  
  type To_Add_Hitboxes is array(Natural range <>) of Hitbox;
  
  function Make_Projectile (
    pos : Position;
    hitboxes_to_add : To_Add_Hitboxes;
    movement : Position;
    graphic : allegro5_bitmap_h.ALLEGRO_BITMAP_ACCESS;
    graphic_width, graphic_height : Float;
    x_offset : Scalar;
    main_anim : Animation_Data_Access;
    frames_to_live : Natural
  ) return Projectile;
  
end Projectile;

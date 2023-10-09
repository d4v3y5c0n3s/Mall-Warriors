with Cool_Math; use Cool_Math;
with Move;
with allegro5_bitmap_h;
with Ada.Containers.Doubly_Linked_Lists;
with Ada.Containers.Multiway_Trees;

package Fighter is

  type Moves_Collection is array(Natural range <>) of Move.Move;
  type Moves_Collection_Access is access Moves_Collection;
  
  type Sprite_States is (none, has_bitmap);
  type Sprite (S : Sprite_States) is record
    case S is
      when none =>
        null;
      when has_bitmap =>
        bitmap : access allegro5_bitmap_h.ALLEGRO_BITMAP;
    end case;
  end record;
  type Sprite_Access is access Sprite;
  
  type input_tree_id is (tree_end, up, down, left, right, atk_1, atk_2, atk_3, atk_4, atk_5, atk_6);
  subtype input_ids is input_tree_id range up .. atk_6;
  
  type Frame_And_Input is record
    frame : Natural;
    input : input_ids;
  end record;
  
  package Inputs_List is new Ada.Containers.Doubly_Linked_Lists(Frame_And_Input);
  
  package Input_Tree is new Ada.Containers.Multiway_Trees(input_tree_id);

  type Fighter is tagged record
    inputs : Inputs_List.List;
    tree_of_move_inputs : Input_Tree.Tree;
    moves : Moves_Collection_Access;
    blocking : Boolean := false;
    crouching : Boolean := false;
    on_ground : Boolean := true;
    hitstunned : Boolean := false;
    doing_action : Boolean := false;
    facing_right : Boolean := true;
    moving_right : Boolean := false;
    moving_left : Boolean := false;
    gravity : Scalar := 1.0;
    walk_speed : Scalar := 7.0;
    jump_speed : Scalar := -20.0;
    velocity_horizontal : Scalar := 0.0;
    velocity_vertical : Scalar := 0.0;
    hitpoints : Integer := 100;
    pos : Position := Position'(0.0, 0.0);
    upper_hitbox : Circle;--upper body hitbox
    lower_hitbox : Circle;--lower body hitbox
    chunkbox : Circle;--body chunkbox
    bottom_of_feet : Position := Position'(0.0, 100.0);-- used for detecting the floor
    sprite_data : Sprite_Access := new Sprite(S => none);
    frame_width : Integer := 200;
    frame_height : Integer := 200;
    sprite_offset : Position := Position'(-100.0, -100.0);
  end record;
  
  procedure Press_Input(F : in out Fighter; given_input : input_ids; frame : Natural);
  
  procedure Release_Input(F : in out Fighter; given_input : input_ids; frame : Natural);
  
  procedure Add_Move (F : in out Fighter; M : Move.Move);
  
  procedure Draw (F : Fighter);
  
  procedure Update (F : in out Fighter);
  
private

  procedure Queue_Input (F : in out Fighter; input_on_frame : Frame_And_Input);

end Fighter;

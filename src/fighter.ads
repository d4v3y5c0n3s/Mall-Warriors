with Cool_Math; use Cool_Math;
with Move;
with Globals; use Globals;
with allegro5_bitmap_h;
with Ada.Containers.Doubly_Linked_Lists;
with allegro_audio_h;

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
  
  type Frame_And_Input is record
    frame : Natural;
    input : input_ids;
  end record;
  
  type Single_Sound is record
    value : access allegro_audio_h.ALLEGRO_SAMPLE;
  end record;
  type Fighter_Sounds is array(Natural range <>) of Single_Sound;
  
  package Inputs_List is new Ada.Containers.Doubly_Linked_Lists(Frame_And_Input);
  
  package Active_Hitboxes is new Ada.Containers.Doubly_Linked_Lists(Hitbox);
  
  Hitbox_To_Despawn_Not_Found : exception;

  type Fighter is tagged record
    inputs : Inputs_List.List;
    tree_of_move_inputs : Input_Tree.Tree;
    moves : Moves_Collection_Access := new Moves_Collection(0 .. 32);
    blocking : Boolean := false;
    crouching : Boolean := false;
    on_ground : Boolean := true;
    hitstun_duration : Natural := 0;
    doing_action : Boolean := false;
    facing_right : Boolean := true;
    moving_right : Boolean := false;
    moving_left : Boolean := false;
    strafing_left : Boolean := false;
    strafing_right : Boolean := false;
    gravity : Scalar := 1.0;
    walk_speed : Scalar := 7.0;
    air_strafe_speed : Scalar := 5.0;
    jump_speed : Scalar := -20.0;
    velocity_horizontal : Scalar := 0.0;
    velocity_vertical : Scalar := 0.0;
    knockback_velocity_vertical, knockback_velocity_horizontal : Scalar := 0.0;
    knockback_duration : Natural := 0;
    dash_velocity_vertical, dash_velocity_horizontal : Scalar := 0.0;
    dash_duration : Natural := 0;
    hitpoints : Integer := 100;
    pos : Position := Position'(0.0, 0.0);
    upper_hitbox : Circle := Circle'(pos => Position'(X => 0.0, Y => -50.0), radius => 50.0);--upper body hitbox
    lower_hitbox : Circle := Circle'(pos => Position'(X => 0.0, Y => 50.0), radius => 50.0);--lower body hitbox
    chunkbox : Circle := Circle'(pos => Position'(X => 0.0, Y => 0.0), radius => 40.0);--body chunkbox
    bottom_of_feet : Position := Position'(0.0, 100.0);-- used for detecting the floor
    sprite_data : Sprite_Access := new Sprite(S => none);
    frame_width : Integer := 200;
    frame_height : Integer := 200;
    sprite_offset : Position := Position'(-100.0, -100.0);
    attack_hitboxes : Active_Hitboxes.List;
    active_move_steps : Move.Move_Step_Array_Access := new Move.Move_Step_Array(1 .. 20);
    move_step_index : Positive := 1;
    move_frame_progression : Natural := 0;
    active_animation : Animation_Data_Access := new Animation_Data'(
      0 => Animation_Frame'(x_start => 0.0, y_start => 0.0, frame_dration => 5),
      1 => Animation_Frame'(x_start => 200.0, y_start => 0.0, frame_dration => 5)
    );
    active_anim_index : Natural := 0;
    animation_progression : Natural := 0;
    show_hitboxes : Boolean := true;
    sounds : access Fighter_Sounds := new Fighter_Sounds(0 .. 8);
  end record;
  
  procedure Press_Input(F : in out Fighter; given_input : input_ids; frame : Natural);
  
  procedure Release_Input(F : in out Fighter; given_input : input_ids; frame : Natural);
  
  procedure Add_Move (F : in out Fighter; M : Move.Move; Index : Natural);
  
  procedure Draw (F : Fighter);
  
  procedure Update (F : in out Fighter; Current_Frame : Natural);
  
  procedure Execute_Move (F : in out Fighter; ThisMove : Move.Move);
  
private

  procedure Queue_Input (F : in out Fighter; input_on_frame : Frame_And_Input);

end Fighter;

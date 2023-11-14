with Globals; use Globals;
with Cool_Math; use Cool_Math;

package Move is

  type Sub_Step is (Play_Animation, Spawn_Hitbox, Despawn_Hitbox, Dash, Play_Sound);
  type Move_Sub_Step (O : Sub_Step) is record
    case O is
      when Play_Animation =>
        anim : Animation_Data_Access := new Animation_Data(0 .. 32);
      when Spawn_Hitbox =>
        hb : Hitbox;
      when Despawn_Hitbox =>
        despawn_hitbox_id : Integer;
      when Dash =>
        dash_duration : Natural;
        dash_vertical : Scalar;
        dash_horizontal : Scalar;
      when Play_Sound =>
        sound_index : Natural;
    end case;
  end record;
  type Move_Sub_Step_Access is access Move_Sub_Step;
  type Move_Sub_Step_Collection is array(Natural range <>) of Move_Sub_Step_Access;
  type Move_Step is record
    frame_duration : Natural;
    operations : access Move_Sub_Step_Collection;
  end record;
  type Move_Step_Access is access Move_Step;
  type Move_Step_Array is array(Natural range <>) of Move_Step_Access;
  type Move_Step_Array_Access is access Move_Step_Array;
  
  type Move_Input_Sequence is array(Natural range <>) of Input_Tree_Node_Access;
  
  type Move_Specialty is (None, Grab);
  
  type Move is record
    command : access Move_Input_Sequence;
    doing : Move_Specialty;
    steps : Move_Step_Array_Access;
  end record;

end Move;

with allegro5_bitmap_io_h; use allegro5_bitmap_io_h;
with Interfaces.C.Strings; use Interfaces.C.Strings;
with Move;
with allegro_audio_h; use allegro_audio_h;

package body Fighter_Data is
  
  function Load_Fighter (F : Fighter_Options) return Fighter.Fighter is
    data : Fighter.Fighter;
    bitmap_path : access String;
  begin
    case F is
      when Shambler =>
        bitmap_path := new String'("assets/shambler.png");
      when Test =>
        bitmap_path := new String'("assets/shambler.png");
        
        data.sounds(0).value := al_load_sample(New_String("assets/test_audio.flac"));
        
        data.start_crouch_steps := new Move.Move_Step_Array'(
          0 => new Move.Move_Step'(frame_duration => 5, operations => new Move.Move_Sub_Step_Collection'(
            0 => new Move.Move_Sub_Step'(
              O => Move.Play_Animation,
              anim => new Animation_Data'(
                0 => Animation_Frame'(x_start => 200.0, y_start => 0.0, frame_dration => 5)
              )
            )
          ))
        );
        
        data.start_uncrouch_steps := new Move.Move_Step_Array'(
          0 => new Move.Move_Step'(frame_duration => 5, operations => new Move.Move_Sub_Step_Collection'(
            0 => new Move.Move_Sub_Step'(
              O => Move.Play_Animation,
              anim => new Animation_Data'(
                0 => Animation_Frame'(x_start => 200.0, y_start => 0.0, frame_dration => 5)
              )
            )
          ))
        );
        
        data.idle_crouch_steps := new Move.Move_Step_Array'(
          0 => new Move.Move_Step'(frame_duration => 1, operations => new Move.Move_Sub_Step_Collection'(
            0 => new Move.Move_Sub_Step'(
              O => Move.Play_Animation,
              anim => new Animation_Data'(
                0 => Animation_Frame'(x_start => 0.0, y_start => 200.0, frame_dration => 1)
              )
            )
          ))
        );
        
        data.idle_stand_steps := new Move.Move_Step_Array'(
          0 => new Move.Move_Step'(frame_duration => 10, operations => new Move.Move_Sub_Step_Collection'(
            0 => new Move.Move_Sub_Step'(
              O => Move.Play_Animation,
              anim => new Animation_Data'(
                Animation_Frame'(x_start => 0.0, y_start => 0.0, frame_dration => 5),
                Animation_Frame'(x_start => 400.0, y_start => 0.0, frame_dration => 5)
              )
            )
          ))
        );
        
        data.on_hit_steps := new Move.Move_Step_Array'(
          0 => new Move.Move_Step'(frame_duration => 10, operations => new Move.Move_Sub_Step_Collection'(
            0 => new Move.Move_Sub_Step'(
              O => Move.Play_Animation,
              anim => new Animation_Data'(
                0 => Animation_Frame'(x_start => 200.0, y_start => 200.0, frame_dration => 10)
              )
            )
          ))
        );
        
        data.block_steps := new Move.Move_Step_Array'(
          0 => new Move.Move_Step'(frame_duration => 5, operations => new Move.Move_Sub_Step_Collection'(
            0 => new Move.Move_Sub_Step'(
              O => Move.Play_Animation,
              anim => new Animation_Data'(
                0 => Animation_Frame'(x_start => 400.0, y_start => 200.0, frame_dration => 5)
              )
            )
          ))
        );
        
        data.grab_actions_steps := new Fighter.Move_Steps_Collection'(
          0 => new Move.Move_Step_Array'(
            0 => new Move.Move_Step'(
              frame_duration => 3,
              operations => new Move.Move_Sub_Step_Collection'(
                0 => new Move.Move_Sub_Step'(
                  O => Move.Dash,
                  dash_duration => 3,
                  dash_vertical => 20.0,
                  dash_horizontal => 20.0
                )
              )
            )
          )
        );
        
        data.grabbed_opponent_reactions_steps := new Fighter.Move_Steps_Collection'(
          0 => new Move.Move_Step_Array'(
            0 => new Move.Move_Step'(
              frame_duration => 6,
              operations => new Move.Move_Sub_Step_Collection'(
                0 => new Move.Move_Sub_Step'(
                  O => Move.Dash,
                  dash_duration => 3,
                  dash_vertical => 20.0,
                  dash_horizontal => -20.0
                ),
                1 => new Move.Move_Sub_Step'(
                  O => Move.Dash,
                  dash_duration => 3,
                  dash_vertical => 30.0,
                  dash_horizontal => -40.0
                )
              )
            )
          )
        );
        
        Fighter.Add_Move(data,
          Move.Move'(
            command => new Move.Move_Input_Sequence'(new Input_Tree_Node'(ID => atk_1), new Input_Tree_Node'(ID => atk_4)),
            doing => Move.Grab,
            steps => new Move.Move_Step_Array'(
              new Move.Move_Step'(frame_duration => 10, operations => new Move.Move_Sub_Step_Collection'(
                0 => new Move.Move_Sub_Step'(O => Move.Play_Animation, anim => new Animation_Data'(
                  0 => Animation_Frame'(x_start => 0.0, y_start => 400.0, frame_dration => 2)
                ))
              )),
              new Move.Move_Step'(frame_duration => 10, operations => new Move.Move_Sub_Step_Collection'(
                0 => new Move.Move_Sub_Step'(O => Move.Spawn_Hitbox, hb => Hitbox'(
                  effect => Grab,
                  grab_opponent_steps_index => 0,
                  identity => 1,
                  shape => Circle'(pos => Position'(100.0, 0.0), radius => 50.0),
                  hit => false,
                  damage => 0,
                  knockback_vertical => 0.0,
                  knockback_horizontal => 0.0,
                  knockback_duration => 0,
                  hitstun_duration => 0
                ))
              )),
              new Move.Move_Step'(frame_duration => 10, operations => new Move.Move_Sub_Step_Collection'(
                0 => new Move.Move_Sub_Step'(O => Move.Despawn_Hitbox, despawn_hitbox_id => 1)
              ))
            )
          ),
        0);
        
        Fighter.Add_Move(data,
          Move.Move'(
            command => new Move.Move_Input_Sequence'(new Input_Tree_Node'(ID => up), new Input_Tree_Node'(ID => atk_1)),
            doing => Move.None,
            steps => new Move.Move_Step_Array'(
              new Move.Move_Step'(frame_duration => 10, operations => new Move.Move_Sub_Step_Collection'(
                0 => new Move.Move_Sub_Step'(O => Move.Spawn_Hitbox, hb => Hitbox'(
                  effect => Attack,
                  grab_opponent_steps_index => 0,
                  identity => 1,
                  shape => Circle'(pos => Position'(100.0, 0.0), radius => 50.0),
                  hit => false,
                  damage => 20,
                  knockback_vertical => 40.0,
                  knockback_horizontal => 50.0,
                  knockback_duration => 2,
                  hitstun_duration => 10
                )),
                1 => new Move.Move_Sub_Step'(O => Move.Play_Sound,
                  sound_index => 0
                )
              )),
              new Move.Move_Step'(frame_duration => 10, operations => new Move.Move_Sub_Step_Collection'(
                0 => new Move.Move_Sub_Step'(O => Move.Spawn_Hitbox, hb => Hitbox'(
                  effect => Attack,
                  identity => 1,
                  grab_opponent_steps_index => 0,
                  shape => Circle'(pos => Position'(150.0, 0.0), radius => 50.0),
                  hit => false,
                  damage => 20,
                  knockback_vertical => 40.0,
                  knockback_horizontal => 50.0,
                  knockback_duration => 2,
                  hitstun_duration => 10
                ))
              )),
              new Move.Move_Step'(frame_duration => 10, operations => new Move.Move_Sub_Step_Collection'(
                0 => new Move.Move_Sub_Step'(O => Move.Despawn_Hitbox, despawn_hitbox_id =>  1)
              ))
            )
          ),
        1);
        
        Fighter.Add_Move(data,
          Move.Move'(
            command => new Move.Move_Input_Sequence'(
              new Input_Tree_Node'(ID => left),
              new Input_Tree_Node'(ID => down),
              new Input_Tree_Node'(ID => right),
              new Input_Tree_Node'(ID => atk_4)
            ),
            doing => Move.None,
            steps => new Move.Move_Step_Array'(
              new Move.Move_Step'(
                frame_duration => 3,
                operations => new Move.Move_Sub_Step_Collection'(
                  0 => new Move.Move_Sub_Step'(
                    O => Move.Play_Animation,
                    anim => new Animation_Data'(
                      0 => Animation_Frame'(x_start => 0.0, y_start => 200.0, frame_dration => 2),
                      1 => Animation_Frame'(x_start => 200.0, y_start => 200.0, frame_dration => 1)
                    )
                  )
                )
              ),
              new Move.Move_Step'(
                frame_duration => 3,
                operations => new Move.Move_Sub_Step_Collection'(
                  0 => new Move.Move_Sub_Step'(
                    O => Move.Dash,
                    dash_duration => 3,
                    dash_vertical => 20.0,
                    dash_horizontal => 20.0
                  )
                )
              ),
              new Move.Move_Step'(
                frame_duration => 11,
                operations => new Move.Move_Sub_Step_Collection'(
                  0 => new Move.Move_Sub_Step'(
                    O => Move.Play_Animation,
                    anim => new Animation_Data'(
                      0 => Animation_Frame'(x_start => 200.0, y_start => 200.0, frame_dration => 6),
                      1 => Animation_Frame'(x_start => 0.0, y_start => 200.0, frame_dration => 5)
                    )
                  )
                )
              )
            )
          ),
        2);
    end case;
    
    data.sprite_data := new Fighter.Sprite'(S => Fighter.has_bitmap, bitmap => al_load_bitmap(New_String(bitmap_path.all)));
    
    Fighter.Execute_Move(data, data.idle_stand_steps, Idle);
    
    return data;
  end Load_Fighter;
  
  function Fighter_Name (F : Fighter_Options) return String is
  begin
    return F'Image;
  end Fighter_Name;
  
  function Fighter_Icon (F : Fighter_Options) return access ALLEGRO_BITMAP is
  begin
    return al_load_bitmap(New_String("assets/temp_stage_char_icon.png"));
  end Fighter_Icon;
  
  function Fighter_Move_Names (F : Fighter_Options) return Fighter_Move_Name_Array is
  begin
    case F is
      when Shambler =>
        return Fighter_Move_Name_Array'(0 => Fighter_Move_Name'(new String'("None lol")));
      when Test =>
        return Fighter_Move_Name_Array'(Fighter_Move_Name'(new String'("Beeeep")), Fighter_Move_Name'(new String'("Useless Hop")));
    end case;
  end Fighter_Move_Names;
  
  function Fighter_Move_Indexes (F : Fighter_Options) return Fighter_Move_Index_Array is
  begin
    case F is
      when Shambler =>
        return Fighter_Move_Index_Array'(0 => 0);
      when Test =>
        return Fighter_Move_Index_Array'(1, 2);
    end case;
  end Fighter_Move_Indexes;
end Fighter_Data;

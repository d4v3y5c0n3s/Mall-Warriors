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
        
        Fighter.Add_Move(data,
          Move.Move'(
            command => new Move.Move_Input_Sequence'(new Input_Tree_Node'(ID => up), new Input_Tree_Node'(ID => atk_1)),
            steps => new Move.Move_Step_Array'(
              new Move.Move_Step'(frame_duration => 10, operations => new Move.Move_Sub_Step_Collection'(
                0 => new Move.Move_Sub_Step'(O => Move.Spawn_Hitbox, hb => Hitbox'(
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
                  identity => 1,
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
        0);
        
        Fighter.Add_Move(data,
          Move.Move'(
            command => new Move.Move_Input_Sequence'(
              new Input_Tree_Node'(ID => left),
              new Input_Tree_Node'(ID => down),
              new Input_Tree_Node'(ID => right),
              new Input_Tree_Node'(ID => atk_4)
            ),
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
        1);
    end case;
    
    data.sprite_data := new Fighter.Sprite'(S => Fighter.has_bitmap, bitmap => al_load_bitmap(New_String(bitmap_path.all)));
    
    return data;
  end Load_Fighter;
end Fighter_Data;

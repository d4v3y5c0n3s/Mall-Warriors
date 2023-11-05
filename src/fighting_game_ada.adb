with Ada.Calendar; use Ada.Calendar;
with Interfaces.C.Strings; use Interfaces.C.Strings;
with Interfaces.C; use Interfaces.C;
with Interfaces; use Interfaces;
with Interfaces.C.Extensions; use Interfaces.C.Extensions;
with allegro5_events_h; use allegro5_events_h;
with allegro5_system_h; use allegro5_system_h;
with allegro5_base_h; use allegro5_base_h;
with allegro5_keyboard_h; use allegro5_keyboard_h;
with allegro_primitives_h; use allegro_primitives_h;
with allegro_image_h; use allegro_image_h;
with allegro5_display_h; use allegro5_display_h;
with allegro5_color_h; use allegro5_color_h;
with allegro5_drawing_h; use allegro5_drawing_h;
with allegro_font_h; use allegro_font_h;
with allegro5_bitmap_io_h; use allegro5_bitmap_io_h;
with allegro5_transformations_h; use allegro5_transformations_h;
with allegro_audio_h; use allegro_audio_h;
with allegro_acodec_h; use allegro_acodec_h;
with allegro5_bitmap_h; use allegro5_bitmap_h;
with allegro5_bitmap_draw_h; use allegro5_bitmap_draw_h;
with Globals; use Globals;
with Fighter;
with Move;
with Cool_Math; use Cool_Math;
with Stage_Data; use Stage_Data;
with Fighter_Data; use Fighter_Data;

procedure Fighting_Game_Ada is
  
  screen_width : constant Scalar := 800.0;
  half_screen_width : constant Scalar := screen_width / 2.0;
  screen_height : constant Scalar := 600.0;
  floor_height : constant Scalar := Scalar(screen_height / 6.0) * 5.0;
  stage_width : constant Scalar := screen_width * 3.0;
  half_stage_width : constant Scalar := stage_width / 2.0;
  
  frame_start_time : Time := Clock;
  should_exit : Boolean := false;
  player_one : Fighter.Fighter;
  player_two : Fighter.Fighter;
  Color_Black : ALLEGRO_COLOR;
  Text_Color : ALLEGRO_COLOR;
  basic_font : access ALLEGRO_FONT;
  transform : access ALLEGRO_TRANSFORM := new ALLEGRO_TRANSFORM;
  frame : Natural := 0;
  camera_pos : Position;
  stage : Stage_Assets;
  
  Allegro_Initialization_Failure : exception;
  
  Q : access ALLEGRO_EVENT_QUEUE;
  Display : access ALLEGRO_DISPLAY;
  DisplayEventSrc : access ALLEGRO_EVENT_SOURCE;
  KBEventSrc : access ALLEGRO_EVENT_SOURCE;
  Ev : access ALLEGRO_EVENT := new ALLEGRO_EVENT;
  
  type Wall_Collision is (None, Left_Collision, Right_Collision);
  
  procedure feet_touches_floor (F : in out Fighter.Fighter) is
  begin
    if F.pos.Y + F.bottom_of_feet.Y >= floor_height then
      F.on_ground := true;
      F.pos.Y := floor_height - F.bottom_of_feet.Y;
      F.strafing_left := false;
      F.strafing_right := false;
    end if;
  end feet_touches_floor;
  
  function body_touches_wall (F : Fighter.Fighter; Camera_X : Scalar) return Wall_Collision is
    translated_chunkbox : Circle := F.chunkbox + F.pos;
    chunkbox_left : Scalar := translated_chunkbox.pos.X - translated_chunkbox.radius;
    chunkbox_right : Scalar := translated_chunkbox.pos.X + translated_chunkbox.radius;
    left_side : Scalar := -Camera_X;
    right_side : Scalar := -(Camera_X) + screen_width;
  begin
    if chunkbox_left < left_side then
      return Left_Collision;
    elsif chunkbox_right > right_side then
      return Right_Collision;
    else
      return None;
    end if;
  end body_touches_wall;
  
  procedure Collide_Attacks_With (Attacker : in out Fighter.Fighter; Defender : in out Fighter.Fighter) is
      index : Fighter.Active_Hitboxes.Cursor := Fighter.Active_Hitboxes.First(Attacker.attack_hitboxes);
      elem : Hitbox;
      shape : Circle;
      
      procedure Mark_Matching_As_Hit (hit_id : Integer) is
        cursor : Fighter.Active_Hitboxes.Cursor := Fighter.Active_Hitboxes.First(Attacker.attack_hitboxes);
        temp_hitbox : Hitbox;
      begin
        while Fighter.Active_Hitboxes.Has_Element(cursor) loop
          temp_hitbox := Fighter.Active_Hitboxes.Element(cursor);
          
          if temp_hitbox.identity = hit_id then
            temp_hitbox.hit := true;
            Fighter.Active_Hitboxes.Replace_Element(Attacker.attack_hitboxes, cursor, temp_hitbox);
          end if;
          
          cursor := Fighter.Active_Hitboxes.Next(cursor);
        end loop;
      end Mark_Matching_As_Hit;
      
      procedure On_Hit is
      begin
        Defender.hitpoints := Defender.hitpoints - elem.damage;
        Defender.hitstun_duration := elem.hitstun_duration;
        Defender.knockback_velocity_vertical := elem.knockback_vertical;
        Defender.knockback_velocity_horizontal := elem.knockback_horizontal;
        Defender.knockback_duration := elem.knockback_duration;
        Defender.doing_action := false;
        Defender.dash_duration := 0;
      end On_Hit;
    begin
      while Fighter.Active_Hitboxes.Has_Element(index) loop
        elem := Fighter.Active_Hitboxes.Element(index);
        shape := elem.shape;
        
        if not Attacker.facing_right then
          shape.pos.X := -shape.pos.X;
        end if;
        
        if not elem.hit then
          if Collides(shape + Attacker.pos + Attacker.sprite_offset, Defender.upper_hitbox + Defender.pos + Defender.sprite_offset) then
            if not Defender.blocking or Defender.crouching then
              On_Hit;
            end if;
            Mark_Matching_As_Hit(elem.identity);
          elsif Collides(shape + Attacker.pos + Attacker.sprite_offset, Defender.lower_hitbox + Defender.pos + Defender.sprite_offset) then
            if not Defender.blocking or not Defender.crouching then
              On_Hit;
            end if;
            Mark_Matching_As_Hit(elem.identity);
          end if;
        end if;
        
        index := Fighter.Active_Hitboxes.Next(index);
      end loop;
  end Collide_Attacks_With;
  
begin
  
  if al_install_system(Interfaces.C.int(al_get_allegro_version), null) and
  al_install_keyboard and
  al_init_primitives_addon and
  al_init_font_addon and
  al_init_image_addon and
  al_install_audio and
  al_init_acodec_addon and
  al_reserve_samples(32) then
    Q := al_create_event_queue;
    Display := al_create_display(int(screen_width), int(screen_height));
    DisplayEventSrc := al_get_display_event_source(Display);
    al_register_event_source(Q, DisplayEventSrc);
    KBEventSrc := al_get_keyboard_event_source;
    al_register_event_source(Q, KBEventSrc);
    
    Color_Black := al_map_rgb(0, 0, 0);
    Text_Color := al_map_rgb(255, 255, 255);
    basic_font := al_create_builtin_font;
    
    debug_upper_hitbox_color := al_map_rgb(250, 230, 80);
    debug_lower_hitbox_color := al_map_rgb(170, 130, 170);
    debug_attack_hitbox_color := al_map_rgb(220, 50, 50);
    debug_chunkbox_color := al_map_rgb(87, 87, 82);
    
    player_one := Load_Fighter(Test);
    player_two := Load_Fighter(Test);
    player_one.pos := Position'(200.0, 400.0);
    player_two.pos := Position'(600.0, 400.0);
      
    stage := Load_Stage(Test1);
    
    loop
      frame_start_time := Clock;
      loop
        if al_get_next_event(Q, Ev) then
          case Ev.c_type is
            when 42 => -- code for the display getting closed
              should_exit := true;
            when 10 => -- key down
              case Ev.keyboard.keycode is
                when 23 =>-- w
                  Fighter.Press_Input(player_one, Globals.up, frame);
                when 1 =>-- a
                  Fighter.Press_Input(player_one, Globals.left, frame);
                when 19 =>-- s
                  Fighter.Press_Input(player_one, Globals.down, frame);
                when 4 =>-- d
                  Fighter.Press_Input(player_one, Globals.right, frame);
                when 21 =>-- u
                  Fighter.Press_Input(player_one, Globals.atk_1, frame);
                when 9 =>-- i
                  Fighter.Press_Input(player_one, Globals.atk_2, frame);
                when 15 =>-- o
                  Fighter.Press_Input(player_one, Globals.atk_3, frame);
                when 10 =>-- j
                  Fighter.Press_Input(player_one, Globals.atk_4, frame);
                when 11 =>-- k
                  Fighter.Press_Input(player_one, Globals.atk_5, frame);
                when 12 =>-- l
                  Fighter.Press_Input(player_one, Globals.atk_6, frame);
                when others =>
                  null;
              end case;
            when 12 => -- key up
              case Ev.keyboard.keycode is
                when 23 =>-- w
                  Fighter.Release_Input(player_one, Globals.up, frame);
                when 1 =>-- a
                  Fighter.Release_Input(player_one, Globals.left, frame);
                when 19 =>-- s
                  Fighter.Release_Input(player_one, Globals.down, frame);
                when 4 =>-- d
                  Fighter.Release_Input(player_one, Globals.right, frame);
                when 21 =>-- u
                  Fighter.Release_Input(player_one, Globals.atk_1, frame);
                when 9 =>-- i
                  Fighter.Release_Input(player_one, Globals.atk_2, frame);
                when 15 =>-- o
                  Fighter.Release_Input(player_one, Globals.atk_3, frame);
                when 10 =>-- j
                  Fighter.Release_Input(player_one, Globals.atk_4, frame);
                when 11 =>-- k
                  Fighter.Release_Input(player_one, Globals.atk_5, frame);
                when 12 =>-- l
                  Fighter.Release_Input(player_one, Globals.atk_6, frame);
                when others =>
                  null;
              end case;
            when others =>
              null;
          end case;
        else
          exit;
        end if;
      end loop;
      
      if (player_one.pos.X + player_one.sprite_offset.X) < (player_two.pos.X + player_two.sprite_offset.X) then
        if not player_one.facing_right and player_one.on_ground and not player_one.doing_action and Fighter.Inputs_List.Is_Empty(player_one.inputs) then
          player_one.facing_right := true;
        end if;
        
        if player_two.facing_right and player_two.on_ground and not player_two.doing_action and Fighter.Inputs_List.Is_Empty(player_two.inputs) then
          player_two.facing_right := false;
        end if;
      else
        if player_one.facing_right and player_one.on_ground and not player_one.doing_action and Fighter.Inputs_List.Is_Empty(player_one.inputs) then
          player_one.facing_right := false;
        end if;
        
        if not player_two.facing_right and player_two.on_ground and not player_two.doing_action and Fighter.Inputs_List.Is_Empty(player_two.inputs) then
          player_two.facing_right := true;
        end if;
      end if;
      
      Fighter.Update(player_one, frame);
      Fighter.Update(player_two, frame);
      
      -- check for floor collision here
      feet_touches_floor(player_one);
      feet_touches_floor(player_two);
      
      -- check for other collisions here
      FighterGeneralCollision:
        declare
          p1_touching_wall : Wall_Collision := body_touches_wall(player_one, camera_pos.X);
          p2_touching_wall : Wall_Collision := body_touches_wall(player_two, camera_pos.X);
          players_colliding : Boolean := Collides(player_one.chunkbox + player_one.pos, player_two.chunkbox + player_two.pos);
          p1_hitstunned : Boolean := player_one.hitstun_duration > 0;
          p2_hitstunned : Boolean := player_two.hitstun_duration > 0;
          p1_is_left : Boolean := player_one.pos.X < player_two.pos.X;
          
          function uncollide_wall (Player : Fighter.Fighter; Touching : Wall_Collision) return Scalar is
            value : Scalar := Player.pos.X + Player.chunkbox.pos.X;
            absolute_value : Scalar := abs value;
            difference : Scalar := 0.0;
            
            procedure calculate_difference is
              WallX : Scalar := 0.0;
              rad : Scalar := 0.0;
              dir : Scalar := 0.0;
              absolute_wall_x : Scalar := 0.0;
            begin
              if Touching = Left_Collision then
                WallX := -camera_pos.X;
                rad := -Player.chunkbox.radius;
                dir := -1.0;
              elsif Touching = Right_Collision then
                WallX := -(camera_pos.X) + screen_width;
                rad := Player.chunkbox.radius;
                dir := 1.0;
              end if;
              absolute_wall_x := abs WallX;
              difference := dir * (rad + absolute_value - absolute_wall_x);
            end calculate_difference;
          begin
            if Touching = Left_Collision then
              calculate_difference;
              return Player.pos.X + difference;
            elsif Touching = Right_Collision then
              calculate_difference;
              return Player.pos.X - difference;
            else
              return Player.pos.X;
            end if;
          end uncollide_wall;
          
          type Uncollide_Dir is (Left, Right);
          
          function uncollide_player (ToMove : Fighter.Fighter; From : Fighter.Fighter; Direction : Uncollide_Dir) return Scalar is
            move_rad : Scalar := ToMove.chunkbox.radius;
            from_rad : Scalar := From.chunkbox.radius;
            dir : Scalar := 0.0;
          begin
            case Direction is
              when Left =>
                dir := -1.0;
              when Right =>
                dir := 1.0;
            end case;
            return From.pos.X + (dir * (From.chunkbox.pos.X + move_rad + from_rad + ToMove.chunkbox.pos.X));
          end uncollide_player;
        begin
          if players_colliding then
            if p1_touching_wall = p2_touching_wall and p1_touching_wall /= None then
              player_one.pos.X := uncollide_wall(player_one, p1_touching_wall);
              player_two.pos.X := uncollide_wall(player_two, p2_touching_wall);
              
              if p1_touching_wall = Left_Collision then
                if p1_is_left then
                  player_two.pos.X := uncollide_player(player_two, player_one, Right);
                else
                   player_one.pos.X := uncollide_player(player_one, player_two, Right);
                end if;
              elsif p1_touching_wall = Right_Collision then
                if p1_is_left then
                  player_one.pos.X := uncollide_player(player_one, player_two, Left);
                else
                  player_two.pos.X := uncollide_player(player_two, player_one, Left);
                end if;
              end if;
            elsif p1_touching_wall /= None and p2_touching_wall = None then
              if p1_touching_wall = Left_Collision then
                player_two.pos.X := uncollide_player(player_two, player_one, Right);
              elsif p1_touching_wall = Right_Collision then
                player_two.pos.X := uncollide_player(player_two, player_one, Left);
              end if;
            elsif p2_touching_wall /= None and p1_touching_wall = None then
              if p2_touching_wall = Left_Collision then
                player_one.pos.X := uncollide_player(player_one, player_two, Right);
              elsif p2_touching_wall = Right_Collision then
                player_one.pos.X := uncollide_player(player_one, player_two, Left);
              end if;
            elsif p1_hitstunned and not p2_hitstunned then
              if p1_is_left then
                player_one.pos.X := uncollide_player(player_one, player_two, Left);
              else
                player_one.pos.X := uncollide_player(player_one, player_two, Right);
              end if;
            elsif not p1_hitstunned and p2_hitstunned then
              if p1_is_left then
                player_two.pos.X := uncollide_player(player_two, player_one, Right);
              else
                player_two.pos.X := uncollide_player(player_two, player_one, Left);
              end if;
            else
              if p1_is_left then
                player_one.pos.X := uncollide_player(player_one, player_two, Left);
                player_two.pos.X := uncollide_player(player_two, player_one, Right);
              else
                player_one.pos.X := uncollide_player(player_one, player_two, Right);
                player_two.pos.X := uncollide_player(player_two, player_one, Left);
              end if;
            end if;
          else
            player_one.pos.X := uncollide_wall(player_one, p1_touching_wall);
            player_two.pos.X := uncollide_wall(player_two, p2_touching_wall);
          end if;
        end FighterGeneralCollision;
      
      Collide_Attacks_With(player_one, player_two);
      Collide_Attacks_With(player_two, player_one);
      
      -- move camera here
      MoveCamera:
        declare
          midpoint : constant Scalar := (Scalar((player_one.pos.X - player_two.pos.X) / 2.0) + 200.0) * (-1.0);
        begin
          if midpoint < (-(half_stage_width) + half_screen_width) then
            camera_pos.X := -(half_stage_width) + half_screen_width;
          elsif midpoint > (half_stage_width - half_screen_width) then
            camera_pos.X := half_stage_width - half_screen_width;
          else
            camera_pos.X := midpoint;
          end if;
        end MoveCamera;
      
      al_clear_to_color(Color_Black);
      al_identity_transform(transform);
      al_translate_transform(transform, Float(camera_pos.X), Float(camera_pos.Y));
      al_use_transform(transform);
      al_draw_bitmap(stage.background, Float(-(screen_width)), 0.0, 0);
      Fighter.Draw(player_one);
      Fighter.Draw(player_two);
      al_identity_transform(transform);
      al_use_transform(transform);
      al_draw_text(basic_font, Text_Color, 100.0, 10.0, 0, New_String("Player 1 HP: " & player_one.hitpoints'Image));
      al_draw_text(basic_font, Text_Color, 500.0, 10.0, 0, New_String("Player 2 HP: " & player_two.hitpoints'Image));
      al_flip_display;
      
      if should_exit then
        exit;
      end if;
      
      frame := frame + 1;
      
      delay until frame_start_time + frame_duration;
    end loop;
    al_register_event_source(Q, KBEventSrc);
    al_destroy_event_queue(Q);
    al_destroy_display(Display);
  else
    raise Allegro_Initialization_Failure;
  end if;
end Fighting_Game_Ada;

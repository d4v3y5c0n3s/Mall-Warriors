with Ada.Calendar; use Ada.Calendar;
with Interfaces.C.Strings; use Interfaces.C.Strings;
with Interfaces.C; use Interfaces.C;
with Interfaces; use Interfaces;
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
with Game_Constants; use Game_Constants;
with Fighter;
with Cool_Math; use Cool_Math;

procedure Fighting_Game_Ada is
  
  frame_start_time : Time := Clock;
  should_exit : Boolean := false;
  player_one : Fighter.Fighter;
  player_two : Fighter.Fighter;
  floor_height : Scalar := 500.0;
  Color_Black : ALLEGRO_COLOR;
  Text_Color : ALLEGRO_COLOR;
  basic_font : access ALLEGRO_FONT;
  frame : Natural := 0;
  
  Allegro_Initialization_Failure : exception;
  
  Q : access ALLEGRO_EVENT_QUEUE;
  Display : access ALLEGRO_DISPLAY;
  DisplayEventSrc : access ALLEGRO_EVENT_SOURCE;
  KBEventSrc : access ALLEGRO_EVENT_SOURCE;
  Ev : access ALLEGRO_EVENT := new ALLEGRO_EVENT;
  
  procedure feet_touches_floor (F : in out Fighter.Fighter) is
  begin
    if F.pos.Y + F.bottom_of_feet.Y >= floor_height then
      F.on_ground := true;
      F.pos.Y := floor_height - F.bottom_of_feet.Y;
    end if;
  end feet_touches_floor;
  
begin
  
  if al_install_system(Interfaces.C.int(al_get_allegro_version), null) and
  al_install_keyboard and
  al_init_primitives_addon and
  al_init_font_addon and
  al_init_image_addon then
    Q := al_create_event_queue;
    Display := al_create_display(800, 600);
    DisplayEventSrc := al_get_display_event_source(Display);
    al_register_event_source(Q, DisplayEventSrc);
    KBEventSrc := al_get_keyboard_event_source;
    al_register_event_source(Q, KBEventSrc);
    
    Color_Black := al_map_rgb(0, 0, 0);
    Text_Color := al_map_rgb(255, 255, 255);
    basic_font := al_create_builtin_font;
    
    player_one.sprite_data := new Fighter.Sprite'(S => Fighter.has_bitmap, bitmap => al_load_bitmap(New_String("assets/2023-09-21-194004.jpg")));
    player_two.sprite_data := new Fighter.Sprite'(S => Fighter.has_bitmap, bitmap => al_load_bitmap(New_String("assets/2023-09-21-194004.jpg")));
    player_one.pos := Position'(200.0, 400.0);
    player_two.pos := Position'(600.0, 400.0);
    
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
                  Fighter.Press_Input(player_one, Fighter.up, frame);
                when 1 =>-- a
                  Fighter.Press_Input(player_one, Fighter.left, frame);
                when 19 =>-- s
                  Fighter.Press_Input(player_one, Fighter.down, frame);
                when 4 =>-- d
                  Fighter.Press_Input(player_one, Fighter.right, frame);
                when 21 =>-- u
                  Fighter.Press_Input(player_one, Fighter.atk_1, frame);
                when 9 =>-- i
                  Fighter.Press_Input(player_one, Fighter.atk_2, frame);
                when 15 =>-- o
                  Fighter.Press_Input(player_one, Fighter.atk_3, frame);
                when 10 =>-- j
                  Fighter.Press_Input(player_one, Fighter.atk_4, frame);
                when 11 =>-- k
                  Fighter.Press_Input(player_one, Fighter.atk_5, frame);
                when 12 =>-- l
                  Fighter.Press_Input(player_one, Fighter.atk_6, frame);
                when others =>
                  null;
              end case;
            when 12 => -- key up
              case Ev.keyboard.keycode is
                when 23 =>-- w
                  Fighter.Release_Input(player_one, Fighter.up, frame);
                when 1 =>-- a
                  Fighter.Release_Input(player_one, Fighter.left, frame);
                when 19 =>-- s
                  Fighter.Release_Input(player_one, Fighter.down, frame);
                when 4 =>-- d
                  Fighter.Release_Input(player_one, Fighter.right, frame);
                when 21 =>-- u
                  Fighter.Release_Input(player_one, Fighter.atk_1, frame);
                when 9 =>-- i
                  Fighter.Release_Input(player_one, Fighter.atk_2, frame);
                when 15 =>-- o
                  Fighter.Release_Input(player_one, Fighter.atk_3, frame);
                when 10 =>-- j
                  Fighter.Release_Input(player_one, Fighter.atk_4, frame);
                when 11 =>-- k
                  Fighter.Release_Input(player_one, Fighter.atk_5, frame);
                when 12 =>-- l
                  Fighter.Release_Input(player_one, Fighter.atk_6, frame);
                when others =>
                  null;
              end case;
            when others =>
              null;
          end case;
        else
          exit;
        end if;
        
        frame := frame + 1;
      end loop;
      
      Fighter.Update(player_one);
      Fighter.Update(player_two);
      
      -- check for floor collision here
      feet_touches_floor(player_one);
      feet_touches_floor(player_two);
      
      -- check for other collisions here
      --  instead of in each fighter-specific update procedure
      
      al_clear_to_color(Color_Black);
      Fighter.Draw(player_one);
      Fighter.Draw(player_two);
      al_draw_text(basic_font, Text_Color, 100.0, 10.0, 0, New_String("Player 1 HP: " & player_one.hitpoints'Image));
      al_draw_text(basic_font, Text_Color, 500.0, 10.0, 0, New_String("Player 2 HP: " & player_two.hitpoints'Image));
      al_flip_display;
      
      if should_exit then
        exit;
      end if;
      
      delay until frame_start_time + frame_duration;
    end loop;
    al_register_event_source(Q, KBEventSrc);
    al_destroy_event_queue(Q);
    al_destroy_display(Display);
  else
    raise Allegro_Initialization_Failure;
  end if;
end Fighting_Game_Ada;

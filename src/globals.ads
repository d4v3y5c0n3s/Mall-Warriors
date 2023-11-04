with Ada.Calendar; use Ada.Calendar;
with Ada.Containers.Multiway_Trees;
with allegro5_color_h;
with Cool_Math; use Cool_Math;

package Globals is
  
  type input_tree_id is (tree_end, up, down, left, right, atk_1, atk_2, atk_3, atk_4, atk_5, atk_6);
  subtype input_ids is input_tree_id range up .. atk_6;
  
  frame_duration : constant Duration := 1.0 / 60.0;
  input_buffer_frames : constant Integer := 28;
  
  type Input_Tree_Node(ID : input_tree_id) is record
    case ID is
      when tree_end =>
        key : Natural;
      when others =>
        null;
    end case;
  end record;
  
  type Input_Tree_Node_Access is access Input_Tree_Node;
  
  package Input_Tree is new Ada.Containers.Multiway_Trees(Input_Tree_Node_Access);
  
  type Animation_Frame is record
    x_start : Float := 0.0;
    y_start : Float := 0.0;
    frame_dration : Natural := 0;
  end record;
  type Animation_Data is array(Natural range <>) of Animation_Frame;
  type Animation_Data_Access is access Animation_Data;
  
  type Hitbox is record
    identity : Integer := 0;
    shape : Circle := Circle'(pos => Position'(X => 0.0, Y => 0.0), radius => 10.0);
    hit : Boolean := false;
    damage : Integer := 0;
    knockback_vertical, knockback_horizontal : Scalar := 0.0;
    knockback_duration : Natural := 0;
    hitstun_duration : Natural := 0;
  end record;
  
  debug_upper_hitbox_color : allegro5_color_h.ALLEGRO_COLOR;
  debug_lower_hitbox_color : allegro5_color_h.ALLEGRO_COLOR;
  debug_attack_hitbox_color : allegro5_color_h.ALLEGRO_COLOR;
  debug_chunkbox_color : allegro5_color_h.ALLEGRO_COLOR;
  
end Globals;

with Ada.Calendar; use Ada.Calendar;
with Ada.Containers.Multiway_Trees;

package Globals is
  
  type input_tree_id is (tree_end, up, down, left, right, atk_1, atk_2, atk_3, atk_4, atk_5, atk_6);
  subtype input_ids is input_tree_id range up .. atk_6;
  
  frame_duration : constant Duration := 1.0 / 60.0;
  input_buffer_frames : constant Integer := 32;
  
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
  
end Globals;

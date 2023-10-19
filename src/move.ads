with Globals; use Globals;

package Move is

  type Move_Step is record
    null;--could be changed from a record to an access to a procedure, would be much more general & easier to set up
    --also need to store duration of step in frames
  end record;
  -- a record type that says what happens from frame X to frame X during the course of performing this move
  type Move_Step_Array is array(Positive range <>) of Move_Step;
  type Move_Input_Sequence is array(Positive range <>) of Input_Tree_Node_Access;
  
  type Move is record
    command : access Move_Input_Sequence;--input_sequence
    --steps : ;--[list/array of Move_Step]
  end record;

end Move;

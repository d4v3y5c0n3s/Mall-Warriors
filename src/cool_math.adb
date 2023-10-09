package body Cool_Math is

  function "+" (A, B : Position) return Position is
  begin
    return Position'(A.X + B.X, A.Y + B.Y);
  end "+";

end Cool_Math;

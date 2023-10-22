package body Cool_Math is

  function "+" (A, B : Position) return Position is
  begin
    return Position'(A.X + B.X, A.Y + B.Y);
  end "+";
  
  function "+" (C : Circle; P : Position) return Circle is
  begin
    return Circle'(pos => C.pos + P, radius => C.radius);
  end "+";
  
  function Collides (A, B: Circle) return Boolean is
    dist_to_collide : Scalar := A.radius + B.radius;
    dist : Scalar := ((B.pos.X - A.pos.X) + (B.pos.Y - A.pos.Y));
  begin
    return Scalar(dist * dist) < (dist_to_collide * dist_to_collide);
  end Collides;

end Cool_Math;

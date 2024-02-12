package Cool_Math is

  type Scalar is delta 10.0 ** (-6) digits 13;
  
  type Position is record
    X : Scalar := 0.0;
    Y : Scalar := 0.0;
  end record;
  
  type Circle is record
    pos : Position;
    radius : Scalar;
  end record;
  
  function "+" (A, B : Position) return Position;
  
  function "-" (A, B : Position) return Position;
  
  function "+" (C : Circle; P : Position) return Circle;
  
  function "abs" (S : Scalar) return Scalar is (if S < 0.0 then S * (-1.0) else S);
  
  function Collides (A, B: Circle) return Boolean;

end Cool_Math;

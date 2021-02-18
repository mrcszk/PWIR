with Ada.Text_IO,Ada.Numerics.Elementary_Functions, Ada.Numerics.Discrete_Random;
use Ada.Text_IO,Ada.Numerics.Elementary_Functions;

procedure Zad1 is

  type Point is record
    X : Integer := 0;
    Y : Integer := 0;
  end record;

  task Generate is
    entry Start;
  end Generate;

  task Counter is
    entry Start;
    entry Finish;
    entry Count(P: Point);
  end Counter;

  task body Generate is
    subtype Numb is Integer range -100 .. 100;
    package Random_Die is new Ada.Numerics.Discrete_Random (Numb);
    use Random_Die;
    Gen: Generator;
    P: Point;
  begin
    accept Start;
    Reset(Gen);
    for I in 1..5 loop
      P.X := Random(Gen);
      P.Y := Random(Gen);
      Counter.Count(P);
    end loop;
    Counter.Finish;
  end Generate;

  task body Counter is
    Xn: Integer;
    Yn: Integer;
    Xp: Integer :=0;
    Yp: Integer := 0;
    Dst_00: Float := 0.0;
    Dst_Xp: Float := 0.0;
  begin
    accept Start;
    loop
      select
      accept Count(P: in Point) do
            Xn := P.X;
            Yn := P.Y;
          end Count;
          Put_Line("(X,Y) = (" & Xn'Img & "," & Yn'Img & ")");
          Dst_00 := Sqrt(Float(Xn*Xn+Yn*Yn));
          Put_Line("    Odleglosc od (0,0): " & Dst_00'Img);

          if Xp /= 0 and then Yp /= 0 then
            Dst_Xp := Sqrt(Float((Xp-Xn)**2+(Yp-Yn)**2));
            Put_Line("    Odleglosc od ("& Xp'Img & "," & Yp'Img & ") :" & Dst_Xp'Img);
          end if;

          Xp := Xn;
          Yp := Yn;
        or
        accept Finish;
        exit;
      end select;
    end loop;
  end Counter;

begin
  Generate.Start;
  Counter.Start;

end Zad1;

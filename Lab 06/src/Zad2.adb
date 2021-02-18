with Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Numerics.Discrete_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;

procedure Zad2 is

task Values is
  entry Start(N : out Float);
  entry Finish;
end Values;

task body Values is
  Gen : Generator;
begin
  loop
    select
      accept Start(N: out Float) do
          Reset(Gen);
          N := Random(Gen)*5.0;
        end Start;
      or
      accept Finish;
      exit;
    end select;
  end loop;
end Values;

type Colors is (Bialy, Czarny, Zielony, Niebieski, Zolty, Czerwony);
package Draw_Color is new Ada.Numerics.Discrete_Random(Colors);
use Draw_Color;

type Week is (Poniedzialek, Wtorek, Sroda, Czwartek, Piatek, Sobota, Niedziela);
package Draw_Dni is new Ada.Numerics.Discrete_Random(Week);
use Draw_Dni;

type Tab is array(1..6) of Integer;
subtype Ranger is Integer range 1 .. 49;
package Draw_Tab is new Ada.Numerics.Discrete_Random(Ranger);
use Draw_Tab;

task Ret is
  entry Table(T: out Tab);
  entry Color(C: out Colors);
  entry Day(D: out Week);
  entry Finish;
end Ret;

task body Ret is
  GDay : Draw_Dni.Generator;
  GColor : Draw_Color.Generator;
  GTab : Draw_Tab.Generator;
begin
  loop
    select
      accept Table(T: out Tab) do
          Reset(GTab);
          for E of T loop
            E := Random(GTab);
          end loop;
        end Table;
      or accept Color(C: out Colors) do
          Reset(GColor);
          C := Random(GColor);
        end Color;
      or accept Day(D: out Week) do
          Reset(GDay);
          D := Random(GDay);
        end Day;
      or accept Finish;
      exit;
    end select;
  end loop;
end Ret;


Num : Float := 0.0;
T : Tab := (others => 0);
C : Colors;
D : Week;
begin
  for I in 1..5 loop
    Values.Start(Num);
    Put_Line("Liczba: "&Num'Img);
  end loop;
  Values.Finish;

  Ret.Day(D);
  Put_Line("Dni tygodnia: "&D'Img);

  Ret.Color(C);
  Put_Line("Kolor: "&C'Img);

  Ret.Table(T);
  for J in T'Range loop
    Put_Line("T("&J'Img&") = "&T(J)'Img);
  end loop;

  Ret.Finish;

end Zad2;

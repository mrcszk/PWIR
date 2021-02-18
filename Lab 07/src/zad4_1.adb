with Ada.Text_IO;
use Ada.Text_IO;

procedure zad4_1 is
	task type Semafor is
		entry Wait;
		entry Signal;
	end Semafor;

	task body Semafor is
	Sem: Integer := 3;
	begin
		loop
       select
          when Sem > 0 =>
             accept Wait do
                Sem := Sem-1;
                Put_Line("    Semafor zmniejszyl sie" & Sem'Img);
             end Wait;
          or
          accept Signal;
                Sem := Sem+1;
                Put_Line("    Semafor zwiekszyl sie" & Sem'Img);
       end select;
		end loop;
	end Semafor;

Sem: Semafor;

	task type Zad(N: Integer := 1) is
		entry Start;
	end Zad;

	task body Zad is
	begin
		accept Start;
		Put_Line("Start zadanie " & N'Img);
		Sem.Wait;
		Put_Line("Semafor zad " & N'Img);
		delay 5.0;
		Put_Line("Koniec zadanie " & N'Img);
		Sem.Signal;
	end Zad;


Zad1: Zad(1);
Zad2: Zad(2);
Zad3: Zad(3);
begin
	Zad1.Start;
	Zad2.Start;
   Zad3.Start;
end zad4_1;

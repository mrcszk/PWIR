with Ada.Text_IO;
use Ada.Text_IO;

procedure zad4_2 is
	protected Semafor is
      entry Wait;
      procedure Signal;
      private
			Sem: Integer := 3;
	end Semafor;

   protected body Semafor is
      entry Wait
        when Sem > 0 is
      		begin
         		Sem := Sem-1;
         		Put_Line("    Semafor zmniejszyl sie" & Sem'Img);
      		end Wait;
      procedure Signal is
      		begin
                Sem := Sem+1;
      		end Signal;
	end Semafor;


	task type Zad(N: Integer := 1) is
		entry Start;
	end Zad;

	task body Zad is
	begin
		accept Start;
		Put_Line("Start zadanie " & N'Img);
		Semafor.Wait;
		Put_Line("Semafor zad " & N'Img);
		delay 5.0;
		Put_Line("Koniec zadanie " & N'Img);
		Semafor.Signal;
	end Zad;


Zad1: Zad(1);
Zad2: Zad(2);
Zad3: Zad(3);
begin
   Zad1.Start;
   Zad2.Start;
   Zad3.Start;
end zad4_2;

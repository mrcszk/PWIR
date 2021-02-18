with Ada.Text_IO;
use Ada.Text_IO;

procedure zad5 is
	protected Semafor is
      entry Wait;
      procedure Signal;
      private
			Sem: Integer := 4;
	end Semafor;

   protected body Semafor is
      entry Wait
        when Sem > 0 is
      		begin
         		Sem := Sem-1;
           --  Put_Line("    Semafor zmniejszyl sie" & Sem'Img);
      		end Wait;
      procedure Signal is
      		begin
                Sem := Sem+1;
      		end Signal;
	end Semafor;


protected Ekran is
  procedure Pisz(S: String);
end Ekran;

protected body Ekran is
  procedure Pisz(S: String) is
  begin
    Put_Line("# Wypisany tekst:");
    Put_Line("$ " & S);
  end Pisz;
end Ekran;

task type Zadanie(N: Integer := 1);
type Wsk_Zadanie is access Zadanie;

task body Zadanie is
begin
      Ekran.Pisz("Jestem w zadaniu " & N'Img);
		Semafor.Wait;
		delay 5.0;
		Semafor.Signal;
end Zadanie;

Z1 : Zadanie(1);
Z2 : Zadanie(2);
Z3 : Zadanie(3);
WZX : Wsk_Zadanie;

begin
  WZX := new Zadanie(4);
  Ekran.Pisz("Jestem w procedurze glownej");
end zad5;

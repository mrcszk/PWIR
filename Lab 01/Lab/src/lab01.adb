with Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar, pak_lab01;
use Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar, pak_lab01;

procedure lab01 is
   tab: Wektor(1..10) := (1..3 => 5.0, 5..8 => 15.0, others => 2.0);

   T1:Time;
   T2:Time;
   D: Duration;
begin
   Put_Line("Agregat");
   WypiszWektor(tab);

   Wypelnijlosowo(tab);
   Put_Line("Losowo");
   WypiszWektor(tab);

   T1:=Clock;
   Sortowanie(tab);
   T2:=Clock;
   D:= T2-T1;
   Put_Line("Czas sortowania: "&D'Img&"[s]");
   Put_Line("Posortowane");
   WypiszWektor(tab);

   -- zadanie na ocene 5
   Wypisz;
end lab01;

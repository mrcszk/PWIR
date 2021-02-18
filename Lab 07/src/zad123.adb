with Ada.Text_IO;
use Ada.Text_IO;

procedure zad123 is
   type TBuf is array (Integer range<>) of Character;

   protected type Buf (N : Integer) is
      entry Wstaw(C : Character);
      entry Pobierz(C : out Character);
   private
      B : TBuf(1..N);
      LiczElem  :Integer := 0;
      PozPob   :Integer := 1;
      PozWstaw :Integer := 1;
   end Buf;

protected body Buf is
  entry Wstaw(C : Character) when LiczElem < N is
      begin
         B(PozWstaw) := C;
         LiczElem := LiczElem + 1;
         if PozWstaw = N then
            PozWstaw := 1;
         else
            PozWstaw := PozWstaw + 1;
         end if;
      end Wstaw;
  entry Pobierz(C : out Character) when LiczElem > 0 is
      begin
         C := B(PozPob);
         LiczElem := LiczElem - 1;
         if PozPob = N then
            PozPob := 1;
         else
            PozPob := PozPob + 1;
         end if;
  end Pobierz;
end Buf;

Buff : Buf(5);


task type Producent;
   task body Producent is
   begin
      for I in 97..107 loop
         Put_Line("$ Producent : "&Character'Val(I)'Img);
         Buff.Wstaw(Character'Val(I));
         Put_Line("$ Wstawione");
      end loop;
end Producent;


task type Konsument;

task body Konsument is
      C : Character := ' ';
   begin
      for I in 1..5 loop
      Put_Line("#     Konsument");
      Buff.Pobierz(C);
         Put_Line("#         Znak = '" & C & "'");
    end loop;
end Konsument;


P: Producent;
K : Konsument;
begin
  Put_Line("@ jestem w procedurze glownej");
end zad123;

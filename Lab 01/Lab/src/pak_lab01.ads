package pak_lab01 is
   type Wektor is array (Integer range <>) of Float;
   procedure WypiszWektor(t:Wektor);
   procedure Wypelnijlosowo(t: out Wektor);
   procedure Sortowanie(t: in out Wektor);

   procedure Wypisz;
end pak_lab01;

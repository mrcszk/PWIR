with Ada.Numerics.Float_Random, Ada.Text_IO, Ada.Calendar, Ada.Calendar.Formatting;
use Ada.Numerics.Float_Random, Ada.Text_IO, Ada.Calendar, Ada.Calendar.Formatting;

package body pak_lab01 is
    procedure WypiszWektor(t:Wektor) is
    begin
        for i in t'Range loop
            Put_Line(t(i)'Img&" ");
        end loop;
    end WypiszWektor;


    procedure Wypelnijlosowo(t: out Wektor) is
        Gen: Generator;
    begin
        Reset(Gen);
        for i in t'Range loop
            t(i):=Random(Gen);
        end loop;
   end Wypelnijlosowo;


    procedure Sortowanie(t: in out Wektor) is
        tmp: Float := 0.0;
    begin
        for i in t'First..(t'Last-1) loop
            for j in t'First..(t'Last-i) loop
                if t(j)>t(j+1) then
                    tmp:=t(j+1);
                    t(j+1):=t(j);
                    t(j):=tmp;
                else
                    null;
                end if;
            end loop;
        end loop;
   end Sortowanie;

   procedure Wypisz is
      File: File_Type;
      Log: File_Type;

      Name: string(1..100) := (others => ' ');
      Len: integer := 0;

      T1:Time;
      T2:Time;
      D: Duration;
      Now : Time := Clock;

   begin
      -- start program
      T1:=Clock;
      -- check if file exists
      begin
         Open(Log, Append_File, "dziennik.txt");
      exception
         when Name_Error => Create (Log, In_File, "dziennik.txt");
      end;
      -- write date in log file
      Put(Log, Image(Date => Now));
      Put(Log, " Start programu");
      Close(Log);

      -- ask for file to open, write every event to Log file
      loop
         Put_Line("Podaj nazwe pliku do otwarcia: ");
         Get_Line(Name, Len);
         begin
            Open(File => File, Mode => In_File, Name => Name(1..Len));
            Open (Log, In_File, "dziennik.txt");
            Close (Log);
            exit;
         exception
            when Name_Error => Put_Line("Bledna nazwa pliku < " & Name(1..Len) & " > !");
                  Open (Log, Append_File, "dziennik.txt");
                  Put(Log, "Bledna nazwa pliku < " & Name(1..Len) & " > !");
                  Close (Log);
         end;
      end loop;
      Open (Log, Append_File, "dziennik.txt");
      Put(Log, "Otworzono plik < " & Name(1..Len) & " > .");
      Close (Log);
      -- read file
      while not End_Of_File(File) loop
            Put_Line(Get_Line(File));
      end loop;
      T2:=Clock;
      -- time delta
      D:= T2-T1;
      Put_Line("Czas dzialania programu: "&D'Img&"[s]");
      Close(File);
      -- program finish

      -- write logs to Log file
      Open (Log, Append_File, "dziennik.txt");
      Put(Log, "Skonczono program, czas dzialania: "&D'Img&"[s]");
      Close(Log);
      Open (Log, Append_File, "dziennik.txt");
      Put(Log, Image(Date => Now));
      Put(Log, " KONIEC");
      Close (Log);
      end Wypisz;
end pak_lab01;

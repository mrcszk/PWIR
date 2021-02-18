with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.discrete_Random;
use Ada.Text_IO, Ada.Integer_Text_IO;
procedure lab4tree is

type Element is
  record
    Data : Integer := 0;
    Up : access Element := Null;
    Left : access Element := Null;
    Right : access Element := Null;
  end record;

type Elem_Ptr is access all Element;

Procedure Print(Tree: in Elem_Ptr) is
begin
    if Tree /= Null then
        Put("(");
        if Tree.Left /= Null then
            Print(Tree.Left);
            Put("<-");
        end if;
        Put(Tree.Data, Width => 0);
        if Tree.Right /= Null then
            Put("->");
            Print(Tree.Right);
        end if;
        Put(")");
    end if;
end Print;

Procedure Insert(Tree: in out Elem_Ptr; N: Integer) is
    Elem: Elem_Ptr := new Element;
    P: Elem_Ptr := Null;
    L: Elem_Ptr := Tree;
    IL: Boolean;
begin
    Elem.Data := N;
    If Tree = Null then
        Elem.Up := P;
        Tree := Elem;
    else
        while L /= Null loop
            P := L;
            if N < L.Data then
                L := L.Left;
                IL := True;
            else
                L := L.Right;
                IL := False;
            end if;
        end loop;

        if IL then
            P.Left := Elem;
        else
            P.Right := Elem;
        end if;

        Elem.Up := P;
    end if;
end Insert;

Function Search(Tree: in out Elem_Ptr; N: in Integer) return Boolean is
begin
    if Tree = Null then
        return False;
    else
        return (Tree.Data = N or Search(Tree.Right,N) = True or Search(Tree.Left,N) = True );
    end if;
end Search;

procedure Random(Tree: in out Elem_Ptr; N,M:Integer) is
subtype Numb is Integer range 1 .. M;
  package Random_Die is new Ada.Numerics.Discrete_Random (Numb);
  use Random_Die;
  G: Generator;
  V: Integer;
  i:Integer:=0;
begin
    Reset(G);
    while i<N loop
        V:= Random(G) mod M;
        Insert(Tree,V);
        i:=i+1;
    end loop;
end Random;

Tree : Elem_Ptr := Null;

begin
    Insert(Tree, 5);
    Insert(Tree, 10);
    Insert(Tree, 3);
    Insert(Tree, 7);
    Insert(Tree, 15);
    Insert(Tree, 8);
    Insert(Tree, 12);
    Print(Tree);
    Put_Line("");
    Put_Line(Search(Tree,10)'Img);
    Put_Line(Search(Tree,11)'Img);
    Random(Tree,5,55);
    Print(Tree);
end lab4tree;

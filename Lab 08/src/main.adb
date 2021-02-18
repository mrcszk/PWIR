with Ada, Ada.Text_IO,Ada.Streams,Ada.Text_IO.Text_Streams,Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Float_Text_IO;
use Ada,Ada.Text_IO,Ada.Streams, Ada.Text_IO, Ada.Numerics.Float_Random,Ada.Text_IO.Text_Streams;


procedure Main is
  Plik         : File_Type;
  Nazwa        : String := "matrix.txt";
  Strumien     : Stream_Access;

  type matrix2D is array (Integer range <>, Integer range <>) of Float;

  procedure Read (S : access Root_Stream_Type'Class; NTab : out matrix2D);
  procedure Write (S : access Root_Stream_Type'Class; NTab : in matrix2D);
  for matrix2D'Read use Read;
  for matrix2D'Write use Write;

  procedure Read (S : access Root_Stream_Type'Class; NTab : out matrix2D) is
  begin
      for Y in NTab'Range (2) loop
        for X in NTab'Range (1) loop
          Float'Read(S,NTab(X,Y));
        end loop;
    end loop;
  end Read;
  procedure Write (S : access Root_Stream_Type'Class; NTab : in matrix2D) is
  begin
    for Y in NTab'Range (2) loop
      for X in NTab'Range (1) loop
        Float'Write(S,NTab(X,Y));
      end loop;
    end loop;

  end Write;

  function CreateMatrix(X: Integer; Y: Integer) return matrix2D is
       Gen: Generator;
     begin
       declare Grid: matrix2D (1 .. X, 1 .. Y) := (others => (others => 0.0));
       begin
         Reset(Gen);
         for R in 1 .. Y loop
             for C in 1 .. X loop
                Grid(C,R) := 10.0 * Random(Gen);
             end loop;
         end loop;
         return Grid;
       end;
   end CreateMatrix;

   procedure PrintMatrix(scr : matrix2D) is
   begin
        for Y in scr'Range (2) loop
          for X in scr'Range (1) loop
            Ada.Float_Text_IO.Put(scr(X,Y),2,2,0);
          end loop;
          Put_Line ("");
        end loop;

   end PrintMatrix;

  function Add(mat:matrix2D; num: Float) return matrix2D is
      resultMatrix: matrix2D(1..mat'Length(1), 1..mat'Length(2));
   begin
      for row in 1..mat'Length(1) loop
         for col in 1..mat'Length(2) loop
            resultMatrix(row, col) := mat(row, col) + num;
         end loop;
      end loop;
      return resultMatrix;
   end Add;

   function Sub(mat:matrix2D; num: Float) return matrix2D is
   begin
      return Add(mat, -1.0 * num);
   end Sub;

   function Mul(mat:matrix2D; num: Float) return matrix2D is
      resultMatrix: matrix2D(1..mat'Length(1), 1..mat'Length(2));
   begin
      for row in 1..mat'Length(1) loop
         for col in 1..mat'Length(2) loop
            resultMatrix(row, col) := mat(row, col) * num;
         end loop;
      end loop;
      return resultMatrix;
   end Mul;

   function Div(mat:matrix2D; num: Float) return matrix2D is
   begin
      if(num = 0.0) then
         Put_Line("Nie dziel przez 0!");
         return mat;
      end if;
      return Mul(mat, 1.0/ num);
   end Div;

   function MatrixAdd(mat1: matrix2d; mat2: matrix2d) return matrix2d is
      resultMatrix: matrix2d(1..mat1'Length(1), 1..mat1'Length(2));
   begin
      if(mat1'Length(1) /= mat2'Length(1) or mat1'Length(2) /= mat2'Length(2)) then
         Put_Line("Wymiary macierzy musza byc takie same!");
         return resultMatrix;
      end if;
      for row in 1..resultMatrix'Length(1) loop
         for col in 1..resultMatrix'Length(2) loop
            resultMatrix(row, col) := mat1(row, col) + mat2(row, col);
         end loop;
      end loop;
      return resultMatrix;
   end MatrixAdd;


   function MatrixSub(mat1: matrix2d; mat2: matrix2d) return matrix2d is
     begin
      return matrixAdd(mat1, Mul(mat2, -1.0));
   end MatrixSub;

  Mat: matrix2D := CreateMatrix(5,4);

begin
  Put_Line("Macierz: ");
  PrintMatrix(Mat);
  Create(Plik, Out_File, Nazwa);
  Strumien := Stream(Plik);
  matrix2D'Write(Strumien, Mat);
  Close(Plik);

  -- dodawanie
  Open(Plik, In_File, Nazwa);
  Strumien := Stream(Plik);
  matrix2D'Read(Strumien, Mat);
  Close(Plik);
  Mat := Add(Mat, 2.0);
  Put_Line("");
  Put_Line("Dodanie do macierzy 2: ");
  PrintMatrix(Mat);
  Open(Plik, Out_File, Nazwa);
  Strumien := Stream(Plik);
  matrix2D'Write(Strumien, Mat);
  Close(Plik);

  -- odejmowanie
  Open(Plik, In_File, Nazwa);
  Strumien := Stream(Plik);
  matrix2D'Read(Strumien, Mat);
  Close(Plik);
  Mat := Sub(Mat, 2.0);
  Put_Line("");
  Put_Line("Odjecie od macierzy 2: ");
  PrintMatrix(Mat);
  Open(Plik, Out_File, Nazwa);
  Strumien := Stream(Plik);
  matrix2D'Write(Strumien, Mat);
  Close(Plik);

  -- mnozenie
  Open(Plik, In_File, Nazwa);
  Strumien := Stream(Plik);
  matrix2D'Read(Strumien, Mat);
  Close(Plik);
  Mat := Mul(Mat, 2.0);
  Put_Line("");
  Put_Line("Pomnozona macierz razy 2: ");
  PrintMatrix(Mat);
  Open(Plik, Out_File, Nazwa);
  Strumien := Stream(Plik);
  matrix2D'Write(Strumien, Mat);
  Close(Plik);

  -- dzielenie
  Open(Plik, In_File, Nazwa);
  Strumien := Stream(Plik);
  matrix2D'Read(Strumien, Mat);
  Close(Plik);
  Mat := Div(Mat, 2.0);
  Put_Line("");
  Put_Line("Podzielona macierz przez 2: ");
  PrintMatrix(Mat);
  Open(Plik, Out_File, Nazwa);
  Strumien := Stream(Plik);
  matrix2D'Write(Strumien, Mat);
  Close(Plik);

  -- dodanie macierzy
  Open(Plik, In_File, Nazwa);
  Strumien := Stream(Plik);
  matrix2D'Read(Strumien, Mat);
  Close(Plik);
  Mat := MatrixAdd(Mat, Mat);
  Put_Line("");
  Put_Line("Dodane macierze: ");
  PrintMatrix(Mat);
  Open(Plik, Out_File, Nazwa);
  Strumien := Stream(Plik);
  matrix2D'Write(Strumien, Mat);
  Close(Plik);

  -- odjecie macierzy
  Open(Plik, In_File, Nazwa);
  Strumien := Stream(Plik);
  matrix2D'Read(Strumien, Mat);
  Close(Plik);
  Mat := MatrixSub(Mat, Mat);
  Put_Line("");
  Put_Line("Odjete macierze: ");
  PrintMatrix(Mat);
  Open(Plik, Out_File, Nazwa);
  Strumien := Stream(Plik);
  matrix2D'Write(Strumien, Mat);
  Close(Plik);
end Main;

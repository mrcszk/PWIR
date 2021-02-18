-module(lab5).
-compile([export_all]).


producent() ->
  receive
    {create, Psr} ->
      io:format("Start ~n"), Psr ! {random, self(), rand:uniform(100)}, producent();
    {ok} ->
      io:format("Sukces ~n");
    {stop} ->
      io:format("Koniec producenta ~n");
    _ ->
      io:format("Nie rozpoznano ~n")
  end.


posrednik() ->
  receive
    {random, Fr , Num} ->
      Konsument = spawn(lab5, konsument, []),
      io:format("-----Odbieram od producenta  ~p ~n", [Num]),
      Fr  ! {ok},
      io:format("-----Przekazuje do konsumenta ~p ~n", [Num]),
      Konsument ! {random, self(), Num},
      posrednik();
    {ok} ->
      io:format("-----Konsument otrzymal ~n"),
      posrednik();
    {stop} ->
      io:format("-----Koniec pośrednika ~n");
    _ ->
      io:format("-----Nie rozpoznano ~n")
  end.
  
  
konsument() ->
  receive
    {random, Fr , Num} ->
      io:format("----------Konsument ma dane ~p ~n", [Num]),
      Fr  ! {ok}
  end.
  
main() ->
  PID1 = spawn(lab5, producent,[]),
  PID2 = spawn(lab5, posrednik,[]),
  PID1 ! {create,PID2},
  PID1 ! {create,PID2},
  PID1 ! {create,PID2}.
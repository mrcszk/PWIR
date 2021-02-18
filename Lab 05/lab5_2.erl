-module(lab5_2).
-compile([export_all]).

generator() ->
  receive
    {generate, Dst} ->
        Dst ! {data, rand:uniform(100)},
        generator();
    _ ->
      generator()
  end.

przetwarzanie(Bufor) ->
  receive
    {data, Num} ->
      N = 2 * Num,
      Bufor ! {computed,Num,N},
      przetwarzanie(Bufor);
    _ ->
      przetwarzanie(Bufor)
  end.

bufor() ->
  receive
    {computed,Num,N} ->
      io:format("--- 2 * ~p = ~p ~n",[Num, N]),
      bufor();
    _ ->
      bufor()
  end.

main() ->
  PID1 = erlang:spawn(lab5_2, generator, []),
  PID2 = erlang:spawn(lab5_2,bufor,[]),
  L = [erlang:spawn(lab5_2, przetwarzanie, [PID2]), erlang:spawn(lab5_2, przetwarzanie, [PID2]), erlang:spawn(lab5_2, przetwarzanie, [PID2])],
  lists:foreach(fun(X) -> PID1 ! {generate,X} end,L),
  lists:foreach(fun(X) -> PID1 ! {generate,X} end,L),
  lists:foreach(fun(X) -> PID1 ! {generate,X} end,L).
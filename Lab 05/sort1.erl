%  sort1.erl
-module(sort1).
-compile([export_all]).

get_mstimestamp() ->
  {Mega, Sec, Micro} = os:timestamp(),
  (Mega*1000000 + Sec)*1000 + round(Micro/1000).

sorts(L) -> 
  merge_sort(L).
  
merge([],E) -> E;
merge(E,[]) -> E;
merge([Hl|Tl],[Hr|Tr]) ->
	if
		Hl<Hr -> [Hl]++merge(Tl,[Hr|Tr]);
		true -> [Hr]++merge([Hl|Tl],Tr)
	end.


merge_sort([]) -> [];
merge_sort([E]) -> [E];
merge_sort(List) ->
	{L,R} = lists:split(trunc(length(List)/2),List),
	merge(merge_sort(L),merge_sort(R)).

sortw(L) -> 
  merge_sort_concurrent(L). 
  
  

rcv(Pid) -> 
	receive
		{Pid, L} -> L
	end.

merge_sort_concurrent(L) ->
	Pid = spawn(sort1, merge_sort_execute, [self(), L]),
    rcv(Pid).

merge_sort_execute(Pid, L) when length(L) < 100 -> Pid ! {self(), merge_sort(L)}; 
merge_sort_execute(Pid, L) -> 
	{Lleft, Lright} = lists:split(trunc(length(L)/2),L),
    Pid1 = spawn(sort1, merge_sort_execute, [self(), Lleft]),
    Pid2 = spawn(sort1, merge_sort_execute, [self(), Lright]),
    L1 = rcv(Pid1),
    L2 = rcv(Pid2),
    Pid ! {self(), merge(L1,L2)}. 
	
	

gensort() ->
 L=[rand:uniform(5000)+1000 || _ <- lists:seq(1, 25339)],	
 Lw=L,
 io:format("Liczba elementow = ~p ~n",[length(L)]),
 
 io:format("Sortuje sekwencyjnie~n"),	
 TS1=get_mstimestamp(),
 sorts(L),
 DS=get_mstimestamp()-TS1,	
 io:format("Czas sortowania ~p [ms]~n",[DS]),
 io:format("Sortuje wspolbieznie~n"),	
 TS2=get_mstimestamp(),
 sortw(Lw),
 DS2=get_mstimestamp()-TS2,	
 io:format("Czas sortowania ~p [ms]~n",[DS2]).
 
 
-module(lab3).

-compile([export_all]).

-import(math,[sqrt/1,pi/0]).

% Pola i objetosci
pole({kwadrat,X,Y}) -> X*Y;
pole({kolo,X}) -> 3.14*X*X;
pole({trojkat,H,X}) -> H*X/2;
pole({trapez,X,Y,H}) -> (X+Y)*H/2;
pole({kula,R}) -> 4*pi()*R*R;
pole({szescian,X}) -> 6*X*X;
pole({stozek,R,H}) -> pi()*R*R + (pi()*R*sqrt(R*R+H*H)).

objetosc({kula,R}) -> 4*pi()*R*R*R/3;
objetosc({szescian,X}) -> X*X*X;
objetosc({stozek,R,H}) -> pi()*R*R*H/3.

% Dlugosc listy

len([]) -> 0;
len([_|T]) -> 1+len(T).

% Min Max

amin([H]) -> H;
amin([H|T])->
        case H < amin(T) of
            true -> H;
            false -> amin(T)
        end.

amax([H]) -> H;
amax([H|T])->
        case H > amax(T) of
            true -> H;
            false -> amax(T)
        end.
		
tmin_max(T) -> {amin(T),amax(T)}.

lmin_max(T) -> [amin(T),amax(T)].

% Pola z listy elementow

pola_figur([H]) -> [pole(H)];
pola_figur([H|T]) -> [pole(H)|pola_figur(T)].

% Lista malejaca

lista_malejaca(1) -> [1];
lista_malejaca(N) -> [N] ++ lista_malejaca(N-1).

% Konwerter temperatur

temperatura({S,T},S) -> {S,T};
% celciusz
temperatura({c,T},S) -> case S of
			k -> {k,T+273.15};
			f -> {f,(9.0/5.0)* T+32.0};
			r -> {r,(9.0/5.0)* (T+273.15)}
		end;
% farenheit
temperatura({f,T},S) -> case S of
			k -> {k,(T+459.67)*5.0/9.0};
			c -> {c,(5.0/9.0)*(T-32.0)};
			r -> {r,T+459.67}
		end;
% kelwin
temperatura({k,T},S) -> case S of
			c -> {c,T-273.15};
			f -> {f,(9.0/5.0)*T-459.67};
			r -> {r,T*9.0/5.0}
		end;
% rankine
temperatura({r,T},S) -> case S of
			k -> {k,T*5.0/9.0};
			f -> {f,T-459.67};
			c -> {c,(5.0/9.0)*T-273.15}
		end.

% Generator listy o zadanej dlugosci

generuj_jedynki(0) -> [];
generuj_jedynki(N) -> [1] ++ generuj_jedynki(N-1).

generuj(0,_) -> [];
generuj(N,E) -> [E] ++ generuj(N-1,E).

% Sortowanie

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
	
bubble_sort([]) -> [];
bubble_sort([A]) -> [A];
bubble_sort(List) ->
    LastSorted = bubble_sort_loop(List),
    bubble_sort(lists:sublist(LastSorted,length(LastSorted)-1)) ++ [lists:last(LastSorted)].
        
bubble_sort_loop([]) -> [];
bubble_sort_loop([X]) -> [X];
bubble_sort_loop([A,B|T]) ->
    if
        A > B -> [B|bubble_sort_loop([A|T])];
        true -> [A|bubble_sort_loop([B|T])]
    end.



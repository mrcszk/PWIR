-module(lab4).
-compile([export_all]).

empty() -> {node, nil}.

insert(Key, Val, {node, nil}) ->
    {node, {Key, Val, {node, nil}, {node, nil}}};
insert(NewKey, NewVal, {node, {Key, Val, Smaller, Larger}}) when NewKey < Key ->
    {node, {Key, Val, insert(NewKey, NewVal, Smaller), Larger}};
insert(NewKey, NewVal, {node, {Key, Val, Smaller, Larger}}) when NewKey > Key ->
    {node, {Key, Val, Smaller, insert(NewKey, NewVal, Larger)}};
insert(Key, Val, {node, {Key, _, Smaller, Larger}}) ->
    {node, {Key, Val, Smaller, Larger}}.

gen(0) -> empty();
gen(N) -> genH(N, empty()).

genH(0, Root) -> Root;
genH(N, Root) -> NewRoot = insert(rand:uniform(100), rand:uniform(100), Root), genH(N - 1, NewRoot).

treeList([]) -> empty();
treeList(L) -> treeListH(L, empty()).

treeListH([], Root) -> Root;
treeListH([{Key, Val} | T], Root) ->
    NewRoot = insert(Key, Val, Root),
    treeListH(T, NewRoot).

treeToList({node, nil}) -> [];
treeToList({node, {Key, Val, Smaller, Larger}}) ->
    treeToList(Smaller) ++ [{Key, Val}] ++ treeToList(Larger).

lookup(_, {node, nil}) -> undefined;
lookup(Key, {node, {Key, Val, _, _}}) -> {ok, Val};
lookup(Key, {node, {NodeKey, _, Smaller, _}}) when Key < NodeKey ->
    lookup(Key, Smaller);
lookup(Key, {node, {_, _, _, Larger}}) ->
    lookup(Key, Larger).

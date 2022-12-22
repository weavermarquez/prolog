:- use_module(library(pio)).
:- use_module(library(dcg/basics)).
:- use_module(library(dcg/high_order)).

%?- solve(Total).
%@ Total = 7811 ;
%@ false.

solve(Total) :- solve("031.txt", Total).

solve(File, Total) :-
    phrase_from_file(sequence(string, "\n", Rows), File),
    maplist(sack_priority, Rows, Priorities),
    sum_list(Priorities, Total).

sack_priority([], 0).
sack_priority(Row, Priority) :-
    append(SackA, SackB, Row), same_length(SackA, SackB), !,
    member(X, SackA), member(X, SackB), !,
    code_priority(X, Priority).

code_priority(Code, Priority) :-
    Code > 96
    ->  lower_sack(Code, Priority)
    ;   upper_sack(Code, Priority).


lower_sack(Code, Priority) :-
    Priority is Code - 96.

upper_sack(Code, Priority) :-
    Code < 65
    ->  Priority is 0
    ;   Priority is Code - 38.


%---
solve_(Badge-Priority) :-
    solve_("0320.txt", Badge-Priority).

solve_(File, Badge-Priority) :-
    phrase_from_file(sequence(string, "\n", Rows), File),
    sacks_badge(Rows, Badge-Priority).

%?- File = "0320.txt",  phrase_from_file(sequence(string, "\n", Rows), File).
%?- solve(Badge-Priority).

sacks_badge(Rows, Badge-Priority) :-
    length(Rows, 3),
    findall(Badge, member(Badge, Rows), List),
    code_priority(Badge, Priority).

%?- maplist(member, Badge, [`abc`,`cdf`,`cea`]), maplist(char_code,Char, Badge).
%
%?- findall(Badge, member(Badge, [`abc`,`cdf`,`cea`]), Bag).
%@ List = [[97, 98, 99], [99, 100, 102], [99, 101, 97]].

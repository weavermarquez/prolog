:- set_prolog_flag(double_quotes,chars).
%:- use_module(library(clpfd)).
:- use_module(library(pio)).
:- use_module(library(dcg/basics)).
:- use_module(library(dcg/high_order)).
:- use_module(library(lists)).


%?- phrase(seq(X), `abcdef`, Rest).

%?-X = "a", nth0(0,X,E).

seq([]) --> [].
seq([E|Es]) --> [E], seq(Es).

elf(Sum) --> snacks(Snacks), {sum_list(Snacks, Sum)}.

snack(C) --> integer(C), eos.
snack(C) --> integer(C), "\n".

snacks([]) --> [].
snacks([C|Cs]) --> snack(C), snacks(Cs).

elves([Last]) --> elf(Last).
elves([Sum|Sums]) --> elf(Sum), "\n", elves(Sums).

%% AAAAAAAAAARGH THE PHRASE FROM FILE READS CODES BY DEFAULT????
%%
pff(Rules, File) :-
    phrase_from_file(seq(Sequence), File),
    maplist(char_code, CharSeq, Sequence),
    phrase(Rules, CharSeq).

pff(Rules, File, Rest) :-
    phrase_from_file(seq(Sequence), File),
    maplist(char_code, CharSeq, Sequence),
    phrase(Rules, CharSeq, Rest).


snack_(S) --> integer(S), "\n".

elf_(Elf) --> sequence(snack, Elf), !.

bob --> [x].

solve(File, One, Two) :-
    phrase_from_file(sequence(elf_, "\n", X), File),
    !,
    maplist(sum_list, X, Y),
    sort(0, @>=, Y, [One,B,C|_]),
    Two is One + B + C.


upto_colon(Atom) -->
    string(Codes), ":", !,
    { atom_codes(Atom, Codes)  }.


% Sequence is Maplist
% Optional is Ignore
% Foreach is Foreach

%?- 'abc'.

%?- phrase(foreach(between(1,5,X), number(X), ", "), L), atom_codes(Atom, L), Atom = '1, 2, 3, 4, 5'.
%@ L = [49, 44, 32, 50, 44, 32, 51, 44, 32|...],
%@ Atom = '1, 2, 3, 4, 5'.

%?- phrase(foreach(between(1,5,X), number(X), ", "), L), maplist(_code, Chars, L).
%@ L = [49, 44, 32, 50, 44, 32, 51, 44, 32|...],
%@ Chars = ['1', ',', ' ', '2', ',', ' ', '3', ',', ' '|...].

till_space(String) --> string(String), " ".

%?- phrase(sequence(bob, ' '), ['x',' ','x','x','y'], Rest).
%?- phrase(bob, X, Rest).
%@ X = [x|Rest].


%?- solve("011.txt", One, Two).
%@ One = 70374,
%@ Two = 204610.


% Answer to Part 1
/*
 ?- phrase_from_file(seq(Sequence), "011.txt"),
 maplist(char_code,CharSeq,Sequence),
 phrase(elves(Sums), CharSeq),
 max_list(Sums, Max).
 %@ Sequence = [54, 55, 53, 48, 10, 54, 53, 51, 56|...],
 %@ CharSeq = ['6', '7', '5', '0', '\n', '6', '5', '3', '8'|...],
 %@ Sums = [58335, 37941, 55299, 46042, 41008, 50793, 16730, 46096, 64812|...],
 %@ Max = 70374 ;
 %@ false.
*/

% Answer to Part 2
/*
 ?- phrase_from_file(seq(Sequence), "011.txt"),
 maplist(char_code,CharSeq,Sequence),
 phrase(elves(Sums), CharSeq),
 sort(Sums, Asc), reverse(Asc, Desc),
 length(TopThree, 3), prefix(TopThree, Desc),
 sum_list(TopThree, FinalSum).
 %@ Sequence = [54, 55, 53, 48, 10, 54, 53, 51, 56|...],
 %@ CharSeq = ['6', '7', '5', '0', '\n', '6', '5', '3', '8'|...],
 %@ Sums = [58335, 37941, 55299, 46042, 41008, 50793, 16730, 46096, 64812|...],
 %@ Asc = [11496, 13638, 15207, 16730, 19407, 20130, 20793, 25022, 25661|...],
 %@ Desc = [70374, 68996, 65240, 64812, 64563, 64420, 63853, 63220, 62907|...],
 %@ TopThree = [70374, 68996, 65240],
 %@ FinalSum = 204610 ;
 %@ false.
*/

% ?- Test = "1000\n2000\n3000\n\n4000\n\n5000\n6000\n\n7000\n8000\n9000\n\n10000\n", phrase(elves(Sums), Test).

% ?- phrase_from_file(elves(Sums), '010.txt').

% ?- phrase(elves(Sums), "10\n20\n30\n\n40\n50\n60\n\n70\n80\n90\n\n100").
%@ Sums = [60, 150, 240, 100] ;
%@ false.

% ?- phrase(elves(Sums), "10\n10\n10\n\n30\n30\n30\n\n50\n50\n50\n\n100\n").
%@ Sums = [30, 90, 150, 100] ;

% ?- phrase_from_file(elves(Sums), "./010.txt").
% ?- File = "011.txt", phrase_from_file(elves(Sums), File).

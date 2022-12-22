/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
AUTHOR: Weaver Marquez <weavermarquez0@gmail.com>
DATE: 2022-11-11
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

:- set_prolog_flag(double_quotes, chars).
:- use_module(library(pio)).
%:- use_module(library(clpfd)).
%:- use_module(library(dcg/basics)).
%:-use_module(library(format)). %library(format) not in SWI-Prolog


%seq([]) --> [].
%seq([X|Xs]) --> [X], seq(Xs).

%seqq([]) --> [].
%seqq([X|Xs]) --> seq(X), seqq(Xs).

lines([]) --> call(eos), !.
lines([L|Ls]) --> line(L), lines(Ls).

line([]) --> ( "\n" |  call(eos) ), !.
line([C|Cs]) --> [C], line(Cs).

eos([], []).


file_list(File, List) :-
    phrase_to_file(lines(List), File).

%?- lines_list("day02-1.in", List).
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/* Puzzle 1: Multiply Final Horizontal Position and Final Horizontal Depth
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */



position([]) --> [].
position([X|Xs]) --> horizontal(X), position(Xs).
position([X|Xs]) --> vertical(X), position(Xs).

horizontal(X) --> "forward ", digit(X).
vertical(X) --> "up ", [X].
vertical(X) --> "down ",[X].

%?-phrase(position(X), "forward 5", Rest).
%
%?- phrase(horizontal(X), "forward 5", Rest).




/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Puzzle 2: Compare sums of 3-step windows.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

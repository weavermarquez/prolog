:- set_prolog_flag(double_quotes,chars).
%:- use_module(library(clpfd)).
:- use_module(library(pio)).
:- use_module(library(dcg/basics)).
:- use_module(library(lists)).

seq([]) --> [].
seq([E|Es]) --> [E], seq(Es).

%round(Opponent-Self) --> [Opponent], " ", [Self].

play(rock) --> "A" | "X".
play(paper) --> "B" | "Y".
play(scissors) --> "C" | "Z".


win(rock, paper).
win(paper, scissors).
win(scissors, rock).

score(lose, 0).
score(tie, 3).
score(win, 6).

score(rock, 1).
score(paper, 2).
score(scissors, 3).

round(tie-Score) --> play(Opponent), " ", play(Self), {Opponent = Self, score(Self, PlayScore), score(tie, ResultScore), Score is PlayScore + ResultScore}.
round(win-Score) --> play(Opponent), " ", play(Self), {win(Opponent, Self), score(Self, PlayScore), score(win, ResultScore), Score is PlayScore + ResultScore}.
round(lose-Score) --> play(Opponent), " ", play(Self), {win(Self, Opponent), score(Self, PlayScore), score(lose, ResultScore), Score is PlayScore + ResultScore}.

play_(rock) --> "A".
play_(paper) --> "B".
play_(scissors) --> "C".

result_(lose) --> "X".
result_(tie) --> "Y".
result_(win) --> "Z".

round_(tie-Score) --> play_(Opponent), " ", result_(tie),
            { Self = Opponent, score(Self, PlayScore), score(tie, ResultScore), Score is PlayScore + ResultScore }.
round_(win-Score) --> play_(Opponent), " ", result_(win),
            {win(Opponent, Self), score(Self, PlayScore), score(win, ResultScore), Score is PlayScore + ResultScore}.
round_(lose-Score) --> play_(Opponent), " ", result_(lose),
            {win(Self, Opponent), score(Self, PlayScore), score(lose, ResultScore), Score is PlayScore + ResultScore}.

tournament([]) --> [].
tournament([S|Ss]) --> round(S), tournament_(Ss).

%tournament_([]) --> [].
tournament_([]) --> "\n".
tournament_([S|Ss]) --> "\n", round(S), tournament_(Ss).

tournament_new([]) --> [].
tournament_new([S|Ss]) --> round_(S), tournament_new_(Ss).

tournament_new_([]) --> "\n".
tournament_new_([S|Ss]) --> "\n", round_(S), tournament_new_(Ss).

% Answer for Part 1
% ?- pff(tournament(Results), "021.txt"), pairs_values(Results, Points), sum_list(Points, Total).
%@ Results = [lose-3, win-7, lose-3, lose-3, lose-2, lose-2, lose-3, win-8, ... - ...|...],
%@ Points = [3, 7, 3, 3, 2, 2, 3, 8, 2|...],
%@ Total = 11767 .

% Answer for Part 2
% ?- pff(tournament(Results), "021.txt"), pairs_values(Results, Points), sum_list(Points, Total).

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


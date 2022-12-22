:- set_prolog_flag(double_quotes,chars).
:- use_module(library(clpfd)).
:- use_module(library(pio)).
:- use_module(library(dcg/basics)).

seq([]) --> [].
seq([X|Xs]) --> [Xs], seq(Xs).

seqq([]) --> [].
seqq([Xs|Xss]) --> seq(Xs), seqq(Xss).


snacks(0) --> "\n".
snacks(Sum) --> {Sum is C + Cs}, integer(C), white, snacks([Cs]).

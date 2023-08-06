% три обвиняемых, один виновен
% guilty(A,B,C)

guilty(1,0,0).
guilty(0,1,0).
guilty(0,0,1).

v1(v11).
v1(v12).
v2(v21).
v2(v22).
v3(v31).
v3(v32).

witness1(1,1,v11). %я виновен, правда
witness1(0,0,v11). %я виновен, ложь
witness1(0,1,v12). %я невиновен, правда
witness1(1,0,v12). %я невиновен, ложь

witness2(1,1,v21). %я виновен, правда
witness2(0,0,v21). %я виновен, ложь
witness2(0,1,v22). %я невиновен, правда
witness2(1,0,v22). %я невиновен, ложь

witness3(1,1,v31). %первый виновен, правда
witness3(0,0,v31). %первый виновен, ложь
witness3(0,1,v32). %первый невиновен, правда
witness3(1,0,v32). %первый невиновен, ложь

jabberwock_analysis(A,B,C,V1,V2,V3):-guilty(A,B,C),
    witness1(A,W1,V1),witness2(B,W2,V2),witness3(A,W3,V3),
    W is W1+W2+W3, W=<1.

jabberwock_question(V1,V2,V3,X):-v1(V1),v2(V2),v3(V3),
    aggregate_all(count,distinct(jabberwock_analysis(_,_,_,V1,V2,V3)),X).

jabberwock(A,B,C,V1,V2,V3):-
jabberwock_question(V1,V2,V3,1),
distinct(jabberwock_analysis(A,B,C,V1,V2,V3)).

tweedledee_solutions(A,B,C,V1):-jabberwock(A,B,C,V1,_,_).

tweedledee(V1,X):-
aggregate_all(count,distinct(tweedledee_solutions(_,_,_,V1)),X).

tweedledum1_solutions(A,B,C,V2):-jabberwock(A,B,C,_,V2,_).

tweedledum1(V2,X):-
aggregate_all(count,distinct(tweedledum1_solutions(_,_,_,V2)),X).

tweedle1_solutions(A,B,C,V1,V2):-jabberwock(A,B,C,V1,V2,_).

tweedle1(V1,V2,X):-
aggregate_all(count,distinct(tweedle1_solutions(_,_,_,V1,V2)),X).

tweedledum2_solutions(A,B,C,V3):-jabberwock(A,B,C,_,_,V3).

tweedledum2(V3,X):-
aggregate_all(count,distinct(tweedledum2_solutions(_,_,_,V3)),X).

tweedle2_solutions(A,B,C,V1,V3):-jabberwock(A,B,C,V1,_,V3).

tweedle2(V1,V3,X):-
aggregate_all(count,distinct(tweedle2_solutions(_,_,_,V1,V3)),X).


humpty_dumpty_analysis(A,B,C,V1,V2,V3):-
v1(V1),v2(V2),
tweedledee(V1,Dee),Dee > 1,
tweedledum1(V2,Dum),Dum > 1,
tweedle1(V1,V2,1),
jabberwock(A,B,C,V1,V2,V3).

humpty_dumpty_analysis(A,B,C,V1,V2,V3):-
v1(V1),v3(V3),
tweedledee(V1,Dee),Dee > 1,
tweedledum2(V3,Dum),Dum > 1,
tweedle2(V1,V3,1),
jabberwock(A,B,C,V1,V2,V3).

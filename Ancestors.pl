% Daniel Navarro
% Prolog Programming
% Ancestors.pl

% Assingment:
% Problem 1: Create a Prolog database of your family tree (based
% only on parent, male, female facts; no marriage facts to be included)
% back to your maternal and paternal grandparents or further.Include, at
% least, your parents, siblings, aunts, uncles, and first cousins and
% your descendants.

% Problem 2: Run queries using ONLY setof and your rules from Problem 1
% to answer the following queries. The structure of your queries is
% important. Your queries must work for any family, not just your own.
%    A list of all your mother’s siblings.
%    A list of all your firstcousins.
%    A list of all your aunts and uncles.[Also use append]
%    A list of all your siblings.
%    A list of all your grandmother’s children.[Pick one]
%    A list of all your ancestors.
%    A list of all descendants of your grandfather.[Pick one]


%Facts
female(mary).
female(jane).
female(lucy).
female(mandy).
female(molly).
female(ann).

male(charlie).
male(ted).
male(daniel).
male(luke).
male(john).
male(tom).

parent(lucy,ann).
parent(ann,mary).
parent(ann,molly).
parent(mary,mandy).
parent(mary,daniel).
parent(tom,ted).
parent(ted,luke).
parent(ted,john).
parent(john,charlie).
parent(luke,daniel).


%Rules
mother(X,Y):-female(X),parent(X,Y).
father(X,Y):-male(X),parent(X,Y).

grandparent(X,Y):-parent(X,Z),parent(Z,Y).

ancestor(X,Y):-parent(X,Y).
ancestor(X,Y):-parent(X,Z),ancestor(Z,Y).

descendant(X,Y):-mother(Y,X).
descendant(X,Y):-father(Y,X).

grandfather(X,Y):-parent(X,Z),father(Z,Y).
grandmother(X,Y):-parent(X,Z),mother(Z,Y).

child(X,Y):-descendant(X,Y).

siblings(X,Y):-parent(Z,X),parent(Z,Y),not(X=Y).

brother(X,Y):-male(X),siblings(X,Y).
sister(X,Y):-female(X),siblings(X,Y).

aunt(X,Y):-sister(X,Z),parent(Z,Y).
uncle(X,Y):-brother(X,Z),parent(Z,Y).

firstcousins(X,Y):-child(X,Z),siblings(Z,M),parent(M,Y).


%Test Cases:

%Problem 1:
%?- mother(X,daniel).
%X = mary

%?- father(X,daniel).
%X = luke

%?- grandparent(X,daniel).
%X = ann

%?- ancestor(X,ted).
%X = tom
%
%?- descendant(X,mary).
%X = mandy

%?- grandfather(X,john).
%X = tom

%?- grandmother(X,mary).
%X = lucy

%?- child(X,mary).
%X = mandy

%?- siblings(X,mary).
%X = molly

%?- brother(X,mandy).
%X = daniel

%?- sister(X,mary).
%X = molly

%?- aunt(X,daniel).
%X = molly

%?- uncle(X,daniel).
%X = john

%?- firstcousins(X,daniel).
%X = charlie


%Problem 2:
%?- setof(Y,siblings(Y,mary),L).
%L = [molly].

%?- setof(X,firstcousins(X,daniel),L).
%L = [charlie].

%?- setof(X,uncle(X,daniel),L1),setof(Y,aunt(Y,daniel),L2),append([L1],[L2],L).
%L1 = [john],
%L2 = [molly],
%L = [[john], [molly]].

%?- setof(X,siblings(X,daniel),L).
%L = [mandy].

%?-setof(X,child(X,ann),L).
%L = [mary, molly].

%?- setof(X,ancestor(X,daniel),L).
%L = [ann, lucy, luke, mary, ted, tom].

%?- setof(X,descendant(X,ted),L).
%L = [john, luke].

















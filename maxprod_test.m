clc

weight=[1,2,3];

% This matrix represents a tree graph with two nodes
% weight1=[1,2];
A=[0 1;
   1 0];
maxprod(A,weight,100);
%conclude: it will output assignment that maximizes each singleton belief


% This matrix represents a tree graph with three nodes
B=[0 1 1;
    1 0 0;
    1 0 0];
maxprod(B,weight,100);
%conclude: it will output assignment that maximizes each singleton belief


% This matrix represents a tree graph with five nodes
C=[0 1 0 0 1;
    1 0 1 1 0;
    0 1 0 0 0;
    0 1 0 0 0;
    1 0 0 0 0];

 maxprod(C,weight,100);
 %conclude:it will output assignment that maximizes each singleton belief
 
 % This matrix does not represent a tree graph
D=[0 1 1 1 1;
    1 0 1 1 1;
    1 1 0 1 1;
    1 1 1 0 1;
    1 1 1 1 0]; 
    
 maxprod(D,weight,100);


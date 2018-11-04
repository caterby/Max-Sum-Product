clc

weight=[1,2,3];

% This matrix represents a tree graph
% weight1=[1,2];
C=[0 1;
   1 0];
sumprod(C,weight,100);

%conclude: if the graph is a tree, this code will provide the exact partition function value

% This matrix represents a tree graph with three nodes
D=[0 1 1;
    1 0 0;
    1 0 0];
sumprod(D,weight,100);

% This matrix represents a tree graph
A=[0 1 0 0 1;
    1 0 1 1 0;
    0 1 0 0 0;
    0 1 0 0 0;
    1 0 0 0 0];

 sumprod(A,weight,100);
 %conclude: if the graph is a tree, this code will provide the exact partition function value
 
 % This matrix does not represent a tree graph
B=[0 1 1 1 1;
    1 0 1 1 1;
    1 1 0 1 1;
    1 1 1 0 1;
    1 1 1 1 0]; 
    
 sumprod(B,weight,100);

 %conclude: if the graph is not a tree, this code only provides an approximation of
 %the exact partition function value

option MIP=CPLEX;
option LP=CPLEX;
option NLP=BARON;
option MINLP=BARON;

option optcr=0;

set
         i /1*5/;

alias (i,j);

parameter
         IsArc(i,j)
         w(i,j)
         n;
IsArc(i,j)=0;
IsArc('1','2')=1;
IsArc('1','3')=1;
IsArc('2','4')=1;
IsArc('3','2')=1;
IsArc('3','5')=1;
IsArc('4','3')=1;
IsArc('4','5')=1;

w('1','2')=10;
w('1','3')=1;
w('2','4')=20;
w('3','2')=100;
w('3','5')=3;
w('4','3')=200;
w('4','5')=20;

n=5

binary variable delta(i,j);
nonnegative variable u(i);

variable z;

equation obj, const1, const2, const3, const4, const5;

obj..
         z=e=sum((i,j)$(IsArc(i,j)=1), w(i,j)*delta(i,j));

const1..
         sum(i$(IsArc('1',i)=1),delta('1',i))-sum(i$(IsArc(i,'1')=1),delta(i,'1'))=e=1;

const2..
         sum(i$(IsArc(i,'5')=1),delta(i,'5'))-sum(i$(IsArc('5',i)=1),delta('5',i))=e=1;

const3(j)$(j.val<>1 and j.val<>5)..
         sum(i$(IsArc(i,j)=1), delta(i,j))=e=sum(i$(IsArc(j,i)=1), delta(j,i));

const4..
         u('1')=e=1;

const5(i,j)$(j.val<>i.val)..
         u(i)-u(j)+n*delta(i,j)=l=n-1;

model longest_path /obj, const1, const2, const3,const4, const5/;
solve longest_path maximizing z using MIP;
display z.l, delta.l, u.l, w;

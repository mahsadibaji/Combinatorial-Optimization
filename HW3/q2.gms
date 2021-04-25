option MIP=CPLEX;
option LP=CPLEX;
option NLP=BARON;
option MINLP=BARON;

option optcr=0;

set
         i /1*20/;

alias (i,j);

parameter
         c(i,j)
         n;

c(i,j)=0;
c(i,j)$(i.val<>j.val)=2*i.val+3*j.val;
n=20;

variable z;
binary variable delta(i,j);
nonnegative variable u(i);

equation obj, const1, const2, const3,const4;

obj..
         z=e=sum((i,j),c(i,j)*delta(i,j));
const1(j)..
         sum(i$(i.val<>j.val),delta(i,j))=e=1;

const2(i)..
         sum(j$(j.val<>i.val),delta(i,j))=e=1;

const3..
         u('1')=e=1;

const4(i,j)$(j.val<>1 and j.val<>i.val)..
         u(i)-u(j)+n*delta(i,j)=l=n-1;

model tsp /obj, const1, const2, const3,const4/;
solve tsp minimizing z using MIP;
display z.l, delta.l, u.l, c;

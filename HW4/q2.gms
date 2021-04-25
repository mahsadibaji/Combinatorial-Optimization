option MIP=CPLEX;
option LP=CPLEX;
option NLP=BARON;
option MINLP=BARON;

option optcr=0;

set i /1*8/;

alias (i,j);

parameter
         m
         time(i) /1 15,2 16,3 20, 4 25,5 30, 6 35,7 40,8 50/;
m=8;

binary variable delta(i,j), gama(j);
variable z;

equation obj, const1, const2, const3, const4;

obj..
         z=e=sum(j,gama(j));
const1(j)..
         sum(i,delta(i,j)*time(i))=l=60;

const2(i)..
         sum(j,delta(i,j))=e=1;

const3(j)..
        sum(i,delta(i,j))=l=8*gama(j);
const4..
         sum((i,j),delta(i,j))=e=m;





model ad /all/;
solve ad minimizing z using MIP;
display delta.l, gama.l;

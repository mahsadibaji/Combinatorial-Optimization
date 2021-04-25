option MIP=CPLEX;
option LP=CPLEX;
option NLP=BARON;
option MINLP=BARON;

option optcr=0;

set
         i/1, 2/
         j/1, 2,3/;

parameter
         s(i) /1 500, 2 900/
         c(i)/1 1000, 2 2000/
         d(j) /1 120, 2 150, 3 200/;

integer variable n(i);
binary variable delta(i);
variable z;

equation obj, const1, const2, const3, const4;

obj..
         z=e=sum(i,n(i)*s(i))+sum(i,c(i)*delta(i));
const1(i)..
         n(i)=l=7*delta(i);
const2..
         20*n('1')+50*n('2')=g=d('1');
const3..
         30*n('1')+35*n('2')=g=d('2');
const4..
         40*n('1')+45*n('2')=g=d('3');

model paste /all/;
solve paste minimizing z using MIP;
display z.l,delta.l,n.l,s,c,d;


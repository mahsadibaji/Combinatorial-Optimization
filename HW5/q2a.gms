option MIP=CPLEX;
option LP=CPLEX;
option NLP=BARON;
option MINLP=BARON;

option optcr=0;

set i /1*7/;

alias (i,j);

parameter
         v(i) /1 17, 2 18, 3 19, 4 24, 5 26, 6 30, 7 33/
         d(i) /1 200, 2 400, 3 200, 4 700, 5 500, 6 300, 7 400/
         total_demand;
total_demand=sum(i,d(i));
variable z;
binary variable y(i);
nonnegative variable x(i,j);

equation obj, const1, const2, const3;

obj..
         z=e=sum(i,1000*y(i))+sum((i,j),v(i)*x(i,j));
const1(i)..
         sum(j,x(i,j))-total_demand*y(i)=l=0;
const2..
         y('7')=e=1;
const3(j)..
         sum(i$(i.val>=j.val),x(i,j))=g=d(j);


model boxes /all/;
solve boxes minimizing z using MIP;
display z.l, y.l, x.l, v, d, total_demand;

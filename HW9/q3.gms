option MIP=CPLEX;
option LP=CPLEX;
option NLP=BARON;
option MINLP=BARON;

option optcr=0;

set i /1*3/;

nonnegative variable
                         v(i)
                         w;
variable z;

equation obj, const1,const2,const3;

obj..
         z=e=w+3*v('1')+3*v('2')+2*v('3');
const1..
         2*v('1')+5*v('2')+v('3')=l=2*w;
const2..
         v('1')+2*v('2')+3*v('3')=l=3*w;
const3..
         w+2*v('1')+v('2')+v('3')=e=1;

model pq /all/;
solve pq maximizing z using MIP;
display z.l, v.l, w.l;

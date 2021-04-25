option MIP=CPLEX;
option LP=CPLEX;
option NLP=BARON;
option MINLP=BARON;

option optcr=0;

set i /0*7/
    k /0*7/;

alias (i,j);

parameter
         IsArc(i,j)
         v(i) /1 17, 2 18, 3 19, 4 24, 5 26, 6 30, 7 33/
         d(k) /1 200, 2 400, 3 200, 4 700, 5 500, 6 300, 7 400/
         c(i,j);

IsArc('7',j)$(j.val<7)=1;
IsArc('6',j)$(j.val<6)=1;
IsArc('5',j)$(j.val<5)=1;
IsArc('4',j)$(j.val<4)=1;
IsArc('3',j)$(j.val<3)=1;
IsArc('2',j)$(j.val<2)=1;
IsArc('1',j)$(j.val<1)=1;

c(i,j)$(IsArc(i,j)=1)=v(i)*sum(k$(k.val>j.val and k.val<=i.val),d(k))+1000;

variable z;
binary variable x(i,j);

equation obj, const1,const2,const3;

obj..
         z=e=sum((i,j)$(IsArc(i,j)=1), c(i,j)*x(i,j));

const1..
         sum(i$(IsArc('0',i)=1),x('0',i))-sum(i$(IsArc(i,'0')=1),x(i,'0'))=e=-1;

const2..
         sum(i$(IsArc(i,'7')=1),x(i,'7'))-sum(i$(IsArc('7',i)=1),x('7',i))=e=-1;

const3(j)$(j.val<>0 and j.val<>7)..
         sum(i$(IsArc(i,j)=1), x(i,j))=e=sum(i$(IsArc(j,i)=1), x(j,i));

model boxes_shp /obj, const1, const2, const3/;

solve boxes_shp using MIP minizing z;
display z.l, x.l, c, IsArc,v ,d;



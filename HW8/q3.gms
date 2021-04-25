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
         c(i,j);

IsArc(i,j)=0;
IsArc('1','2')=1;
IsArc('1','3')=1;
IsArc('2','4')=1;
IsArc('3','2')=1;
IsArc('3','5')=1;
IsArc('3','4')=1;
IsArc('4','5')=1;

c('1','2')=1;
c('1','3')=1;
c('2','4')=2;
c('3','2')=4;
c('3','5')=1;
c('3','4')=1;
c('4','5')=1;

binary variable delta(i,j);
variable z;

equation obj, const1, const2, const3, const4, const5;

obj..
         z=e=sum((i,j)$(IsArc(i,j)=1), c(i,j)*delta(i,j));

const1..
         sum(i$(IsArc('1',i)=1),delta('1',i))-sum(i$(IsArc(i,'1')=1),delta(i,'1'))=e=1;

const2..
         sum(i$(IsArc(i,'5')=1),delta(i,'5'))-sum(i$(IsArc('5',i)=1),delta('5',i))=e=1;

const3(j)$(j.val<>1 and j.val<>5)..
         sum(i$(IsArc(i,j)=1), delta(i,j))=e=sum(i$(IsArc(j,i)=1), delta(j,i));

const4..
         delta('1','3')+delta('3','5')=l=1;

const5..
         delta('1','3')+delta('3','4')+delta('4','5')=l=2;


model shp /obj, const1, const2, const3/;
model second_shp /obj, const1, const2, const3, const4/;
model third_shp /obj, const1, const2, const3, const4, const5/;

solve third_shp using MIP minizing z;
display z.l, delta.l, c, IsArc;














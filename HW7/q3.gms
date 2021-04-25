option MIP=CPLEX;
option LP=CPLEX;
option NLP=BARON;
option MINLP=BARON;

option optcr=0;

set
         i /1*5/
         j/1*8/;

alias (i,i_prim);

parameter
         c(i,j)
         d(i,i_prim,j)
         k;

c(i,j)=0;
c('1','1')=2;
c('1','2')=3;
c('1','3')=1;
c('1','4')=1;
c('1','5')=1;
c('1','6')=2;
c('1','7')=1;
c('1','8')=2;

c('2','1')=1;
c('2','2')=1;
c('2','3')=1;
c('2','4')=1;
c('2','5')=3;
c('2','6')=1;
c('2','7')=2;
c('2','8')=1;

c('3','1')=3;
c('3','2')=4;
c('3','3')=2;
c('3','4')=3;
c('3','5')=2;
c('3','6')=2;
c('3','7')=3;
c('3','8')=2;

c('4','1')=2;
c('4','2')=2;
c('4','3')=2;
c('4','4')=2;
c('4','5')=2;
c('4','6')=1;
c('4','7')=2;
c('4','8')=3;

c('5','1')=1;
c('5','2')=1;
c('5','3')=1;
c('5','4')=2;
c('5','5')=1;
c('5','6')=1;
c('5','7')=1;
c('5','8')=2;

d(i,i_prim,j)=0;
d(i,i_prim,j)$(i.val<>i_prim.val and c(i,j)<>c(i_prim,j))=1;

k=3;

binary variable delta(j);
variable z;

equation obj, const1;

obj..
         z=e=sum(j,delta(j));

const1(i,i_prim)$(i.val<>i_prim.val)..
         sum(j,d(i,i_prim,j)*delta(j))=g=k;


model disease /obj, const1/;
solve disease minimizing z using MIP;
display z.l, delta.l,k , c, d;

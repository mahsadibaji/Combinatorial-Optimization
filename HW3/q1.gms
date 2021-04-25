option MIP=CPLEX;
option LP=CPLEX;
option NLP=BARON;
option MINLP=BARON;

option optcr=0;

set i/1*7/;

binary variable delta(i);
variable z;

equation obj,const1, const11,const12,const13,const21,const22,const23,const24,const3,const41,const42,const5;

obj..
         z=e=3*(delta('1')+delta('5')+delta('6'))+2*(delta('2')+delta('3'))+delta('4')+delta('7');
const1..
         sum(i,delta(i))=e=5;
const11..
         delta('1')+delta('3')+delta('5')+delta('7')=g=4;
const12..
         delta('3')+delta('4')+delta('5')+delta('6')+delta('7')=g=2;
const13..
         delta('2')+delta('4')+delta('6')=g=1;
const21..
         3*(delta('1')+delta('5')+delta('6')+delta('7'))+2*(delta('2')+delta('3'))+delta('4')=g=10;
const22..
         3*(delta('1')+delta('3')+delta('4')+delta('5'))+delta('2')+delta('6')+2*delta('7')=g=10;
const23..
         3*(delta('2')+delta('4')+delta('5'))+2*(delta('3')+delta('6')+delta('7'))+delta('1')=g=10;
const24..
         3*(delta('1')+delta('5')+delta('6'))+2*(delta('2')+delta('3'))+delta('4')+delta('7')=g=10;
const3..
         delta('3')+delta('6')=l=1;
const41..
         delta('1')=l=delta('4');
const42..
         delta('1')=l=delta('5');
const5..
         delta('2')+delta('3')=g=1;

model player /obj,const1,const11,const12,const13,const21,const22,const23,const24,const3,const41,const42,const5/;
solve player maximizing z using MIP;
display z.l, delta.l;

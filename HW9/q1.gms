option MIP=CPLEX;
option LP=CPLEX;
option NLP=BARON;
option MINLP=BARON;

option optcr=0;

set
         i /0*2/
         j/0*3/;
parameter
         a(i) /0 -2, 1 0, 2 2/
         a_p(i) /0 1, 1 1.5, 2 2/
         a_z(i) /0 -1, 1 0, 2 1/
         b(j) /0 -0.5, 1 0, 2 1, 3 2/
         b_p(j) /0 -2, 1 -1, 2 0, 3 0.5/
         f1(i) /0 36, 1 0, 2 36/
         f2(i) /0 1, 1 2.25, 2 4/
         f3(i) /0 9, 1 0, 2 9/
         g11(j) /0 0.25, 1 0, 2 1, 3 4/
         g12(j) /0 -4, 1 -1, 2 0, 3 -0.25/;

$ontext
binary variable
         delta(k)
         delta_p(k)
         delta_z(k)
         alpha(l)
         alpha_p(l);
$offtext

*„ €Ì—Â«Ì „Ê—œ‰Ì«“ „ ‰«Ÿ— »« ‰ﬁ«ÿ ‘ò” 
SOS2 Variable
                 lambda(i)
                 lambda_p(i)
                 lambda_z(i)
                 gama(j)
                 gama_p(j);

variable z;

equation obj, const1, const2, const3, const4, const5, const6, const7, const8, const9, const10,
         const11, const12, const39, const40;

obj..
         z=e=sum(i,f1(i)*lambda(i))+sum(i,lambda_p(i)*f2(i))+sum(i,lambda_z(i)*f3(i));
const1..
         sum(j,g11(j)*gama(j))+sum(j,g12(j)*gama_p(j))=g=1;
const2..
         sum(i,lambda(i))=e=1;
const3..
         sum(i,lambda_p(i))=e=1;
const4..
         sum(i,lambda_z(i))=e=1;
const5..
         sum(j,gama(j))=e=1;
const6..
         sum(j,gama_p(j))=e=1;
const7..
         sum(i,a(i)*lambda(i))=g=-2;
const8..
         sum(i,a(i)*lambda(i))=l=2;
const9..
         sum(i,a_p(i)*lambda_p(i))=g=1;
const10..
         sum(i,a_p(i)*lambda_p(i))=l=2;
const11..
         sum(i,a_z(i)*lambda_z(i))=g=-1;
const12..
         sum(i,a_z(i)*lambda_z(i))=l=1;

*ÀÌÊœ „Ã«Ê—  òÂ »Â Ã«Ì ¬‰ Â« «“ SOS2 «” ›«œÂ ‘œ
$ontext
const13..
         sum(j,b(j)*gama(j))=g=-0.5;
const14..
         sum(j,b(j)*gama(j))=l=2;
const15..
         sum(j,b_p(j)*gama_p(j))=g=-2;
const16..
         sum(j,b_p(j)*gama_p(j))=l=0.5;
const17..
         lambda('0')=l=delta('1');
const18..
         lambda('1')=l=delta('1')+delta('2');
const19..
         lambda('2')=l=delta('2');
const20..
         lambda_p('0')=l=delta_p('1');
const21..
         lambda_p('1')=l=delta_p('1')+delta_p('2');
const22..
         lambda_p('2')=l=delta_p('2');
const23..
         lambda_z('0')=l=delta_z('1');
const24..
         lambda_z('1')=l=delta_z('1')+delta_z('2');
const25..
         lambda_z('2')=l=delta_z('2');
const26..
         gama('0')=l=alpha('1');
const27..
         gama('1')=l=alpha('1')+alpha('2');
const28..
         gama('2')=l=alpha('2')+alpha('3');
const29..
         gama('3')=l=alpha('3');
const30..
         gama_p('0')=l=alpha_p('1');
const31..
         gama_p('1')=l=alpha_p('1')+alpha_p('2');
const32..
         gama_p('2')=l=alpha_p('2')+alpha_p('3');
const33..
         gama_p('3')=l=alpha_p('3');
const34..
         sum(k,delta(k))=e=1;
const35..
         sum(k,delta_p(k))=e=1;
const36..
         sum(k,delta_z(k))=e=1;
const37..
         sum(l,alpha(l))=e=1;
const38..
         sum(l,alpha_p(l))=e=1;
$offtext

const39..
         sum(j,b(j)*gama(j))=e=0.5*(sum(i,a(i)*lambda(i))+sum(i,a_p(i)*lambda_p(i)));
const40..
          sum(j,b_p(j)*gama_p(j))=e=0.5*(sum(i,a(i)*lambda(i))-sum(i,a_p(i)*lambda_p(i)));

model approx /all/;
solve approx minimizing z using MIP;
display z.l, lambda.l, lambda_p.l, lambda_z.l,gama.l, gama_p.l;

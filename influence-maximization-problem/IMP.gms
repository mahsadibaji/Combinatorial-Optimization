option MIP=CPLEX;
option optcr=0;
option decimals=4;

*A,W niaz b vared kardan baraye in example nist

*i->V,r->R
set
         i /1*5/
         r /1*32/;

alias (i,j);

*seed set size
Scalar k  /2/ ;

*Probability of scenario r occurrence
parameter miu(r);
$call GDXXRW imp_data_miu.xlsx par=miu cdim=1 rdim=0 rng=sheet1!A1:AF1
$GDXIN imp_data_miu.gdx
$LOAD miu
$GDXIN


parameter p(j,i,r);

p(j,i,r)=0;
p(j,i,r)$(i.val=j.val)=1;
p('1','2','2')=1;
p('2','4','3')=1;
p('3','4','4')=1;
p('4','2','5')=1;
p('4','5','6')=1;

p('1','4','7')=1;
p('2','4','7')=1;
p('1','2','7')=1;

p('3','4','8')=1;
p('1','2','8')=1;

p('2','4','9')=1;
p('3','4','9')=1;

p('1','2','10')=1;
p('4','2','10')=1;

p('4','2','11')=1;
p('2','4','11')=1;

p('3','2','12')=1;
p('4','2','12')=1;
p('3','4','12')=1;

p('1','2','13')=1;
p('4','5','13')=1;

p('2','4','14')=1;
p('2','5','14')=1;
p('4','5','14')=1;

p('3','4','15')=1;
p('3','5','15')=1;
p('4','5','15')=1;

p('4','2','16')=1;
p('4','5','16')=1;

p('1','2','17')=1;
p('2','4','17')=1;
p('3','4','17')=1;

p('1','2','18')=1;
p('4','2','18')=1;
p('1','4','18')=1;
p('2','4','18')=1;

p('1','2','19')=1;
p('3','2','19')=1;
p('4','2','19')=1;
p('3','4','19')=1;

p('3','2','20')=1;
p('4','2','20')=1;
p('2','4','29')=1;
p('3','4','20')=1;

p('1','2','21')=1;
p('1','4','21')=1;
p('2','4','21')=1;
p('1','5','21')=1;
p('2','5','21')=1;
p('4','5','21')=1;

p('1','2','22')=1;
p('3','4','22')=1;
p('3','5','22')=1;
p('4','5','22')=1;

p('2','4','23')=1;
p('3','4','23')=1;
p('2','5','23')=1;
p('3','5','23')=1;
p('4','5','23')=1;

p('1','2','24')=1;
p('4','2','24')=1;
p('4','5','24')=1;

p('4','2','25')=1;
p('2','4','25')=1;
p('2','5','25')=1;
p('4','5','25')=1;

p('3','2','26')=1;
p('4','2','26')=1;
p('3','4','26')=1;
p('3','5','26')=1;
p('4','5','26')=1;

p('1','2','27')=1;
p('3','2','27')=1;
p('4','2','27')=1;
p('1','4','27')=1;
p('2','4','27')=1;
p('3','4','27')=1;

p('1','2','28')=1;
p('1','4','28')=1;
p('2','4','28')=1;
p('3','4','28')=1;
p('1','5','28')=1;
p('2','5','28')=1;
p('3','5','28')=1;
p('4','5','28')=1;

p('1','2','29')=1;
p('4','2','29')=1;
p('1','4','29')=1;
p('2','4','29')=1;
p('1','5','29')=1;
p('2','5','29')=1;
p('4','5','29')=1;

p('1','2','30')=1;
p('3','2','30')=1;
p('4','2','30')=1;
p('3','4','30')=1;
p('3','5','30')=1;
p('4','5','30')=1;

p('3','2','31')=1;
p('4','2','31')=1;
p('2','4','31')=1;
p('3','4','31')=1;
p('2','5','31')=1;
p('3','5','31')=1;
p('4','5','31')=1;

p('1','2','32')=1;
p('3','2','32')=1;
p('4','2','32')=1;
p('1','4','32')=1;
p('2','4','32')=1;
p('3','4','32')=1;
p('1','5','32')=1;
p('2','5','32')=1;
p('3','5','32')=1;
p('4','5','32')=1;



variable
                 z;
binary variable
                 x(i,r)
                 y(i);

equation
         obj
         const1
         const2;

obj..
         z=e=sum((i,r),miu(r)*x(i,r));

const1..
         sum(i,y(i))=e=k;

const2(i,r)..
         x(i,r)=l=sum(j$(p(j,i,r)=1),y(j));

model    IMP_ex /all/;
solve    IMP_ex maximizing z using MIP;

parameter contribution(r);

contribution(r)=miu(r)*sum(i,x.l(i,r));

display  z.l,x.l,y.l, miu, p,contribution;




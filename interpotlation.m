function [Aout,Bout,Cout,Kout,fai1,Q0,W0]= interpotlation(A,B,C,K,fai,Q,W,C1,C2,Cave)
%ÄÚ²å
Aout = (Cave - C2)./(C1 - C2).*(A(1)-A(2))+A(2);
Bout = (Cave - C2)./(C1 - C2).*(B(1)-B(2))+B(2);
Cout = (Cave - C2)./(C1 - C2).*(C(1)-C(2))+C(2);
Kout = (Cave - C2)./(C1 - C2).*(K(1)-K(2))+K(2);
fai1 = (Cave - C2)./(C1 - C2).*(fai(1)-fai(2))+fai(2);
Q0 = (Cave - C2)./(C1 - C2).*(Q(1)-Q(2))+Q(2);
W0 = (Cave - C2)./(C1 - C2).*(W(1)-W(2))+W(2);
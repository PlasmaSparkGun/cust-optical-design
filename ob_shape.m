function [r,t,d,x] = ob_shape(Aout,Kout,fai1,W0,Q0,Pave,Wave,P0,f1_,n,D_wai)

%形状系数
Q1_1 = Q0 + sqrt((Pave - P0)/Aout); 
Q1_2 = Q0 - sqrt((Pave - P0)/Aout);
Q_ = Q0 + (Wave - W0)/Kout;
if abs(Q1_1 - Q_) > abs(Q1_2-Q_)
   Q1 = Q1_2;
else
    Q1 = Q1_1;
end
Q = (Q1+Q_)/2;

%折射面曲率
rho2 = fai1+Q;
rho1 = n(1)/(n(1)-1)*fai1+Q;
rho3 = n(2)/(n(2)-1)*fai1+Q-(1/(n(2)-1));
%半径
r = [f1_/rho1 f1_/rho2 f1_/rho3];

%矢高
for ii = 1:3
    if r(ii) > 0
        x(ii) = r(ii)-sqrt(r(ii).^2 - (D_wai/2).^2);
    else
        x(ii) = r(ii) + sqrt(r(ii).^2 - (D_wai/2).^2);
    end
end
%边缘厚度
t = [(D_wai+3*x(2)-3*x(1))/10 (D_wai+8*x(3)-8*x(2))/10];
%中心厚度
d = [t(1)-x(2)+x(1) t(2)-x(3)+x(2)];

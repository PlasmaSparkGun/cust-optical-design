function [P,W,C,P0,um_] = abberation(Do,fo_,fov,Dr,L,n,v)
%ABBERATION 此处显示有关此函数的摘要
%   此处显示详细说明
%棱镜像差
um_= atan(Do./2./fo_);
uz = - fov;%物方视场角一半
LA_p = (n.^2-1)/(2.*n.^3).*L.*um_.^2;
SC_p = LA_p.*(uz./(Dr./2));
dLFC_p = L.*(n-1)./(v.*n.^2);
J = 1.* um_.*(Dr./2);
%物镜初级像差
LA_o = -LA_p;
SC_o = -SC_p;
dLFC_o = -dLFC_p;
%求双胶合物镜的结构参数
S1 = -2.*1.*um_.^2.*LA_o;
S2 = -2.*J.*SC_o;
C1 = -1.*um_.^2.*dLFC_o;
%归一化
P = S1.*fo_.^3./(Do./2).^4;
W = S2.*fo_.^2.*J./(Do./2).^2;
C = C1.*fo_./(Do./2).^2;
P0 = P - 0.85.*(W + 0.1).^2;

end


function [P,W,C,P0,um_] = abberation(Do,fo_,fov,Dr,L,n,v)
%ABBERATION �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%�⾵���
um_= atan(Do./2./fo_);
uz = - fov;%�﷽�ӳ���һ��
LA_p = (n.^2-1)/(2.*n.^3).*L.*um_.^2;
SC_p = LA_p.*(uz./(Dr./2));
dLFC_p = L.*(n-1)./(v.*n.^2);
J = 1.* um_.*(Dr./2);
%�ﾵ�������
LA_o = -LA_p;
SC_o = -SC_p;
dLFC_o = -dLFC_p;
%��˫�����ﾵ�Ľṹ����
S1 = -2.*1.*um_.^2.*LA_o;
S2 = -2.*J.*SC_o;
C1 = -1.*um_.^2.*dLFC_o;
%��һ��
P = S1.*fo_.^3./(Do./2).^4;
W = S2.*fo_.^2.*J./(Do./2).^2;
C = C1.*fo_./(Do./2).^2;
P0 = P - 0.85.*(W + 0.1).^2;

end


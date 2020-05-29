% w = 8; %unit ��
% d = 4;
% p=10.5;
% alpha = 7; %unit ''
% k = 0.66;%����ϵ��
% a = 0.25;%�⾵�ĳ�������ֻ���֮��ľ���
clear
Am = 8;%�Ŵ���

%Ŀ���������
%D---��ֱͫ�� 
%f_--------�񷽽���
eyepiece(1).f_ = 15.597;
eyepiece(2).f_ = 20.216;
%Ŀ���������
%r----�������ʰ뾶
eyepiece(1).r = [66.18 22.18 -19.055 62.37 -26.12 22.01 -22.01 79.07];
eyepiece(2).r = [inf -25.24 50.93 -50.93 25.53 -25.53 17.989 -157.04];
%d----����֮�����
eyepiece(1).d = [1.5 7.4 0.55 5.2 0.5 8.4 1.5];
eyepiece(2).d = [5.3 0.2 5.5 0.2 10.0 1.8 6.0];
%nD----D��������
eyepiece(1).nD = [1.7398 1.5163 1 1.5163 1 1.5163 1.7398];
eyepiece(2).nD = [1.5524 1 1.5524 1 1.4874  1.7280 1.4874];
%v-----������
eyepiece(1).v = [28.2 64.1 inf 64.1 inf 64.1 28.2];
eyepiece(2).v = [63.3 inf 63.3 inf 70.0 28.3 70.0];
%����
paraxial = litrace(-flip(eyepiece(1).r),flip(eyepiece(1).d),flip(eyepiece(1).nD),inf,10,'paraxial');
% reality = litrace(eyepiece.fr,eyepiece.fd,eyepiece.fnD,inf,10,'real');
%�����ͫ��
Sf = paraxial(12,8);
opsys.p = Sf + eyepiece(1).f_/Am;
%�����ﾵ�ṹ��ʽ
objective.f_ = Am * eyepiece(1).f_;
objective.fov = 4*(pi/180);%�﷽�ӳ��ǵ�һ��
objective.D = 4*Am;
objective.RA = objective.D/objective.f_;
%����ֻ���
reticle = RETICLE(2*tan(objective.fov)*objective.f_);
[reticle.T,reticle.T_e]= reticle.get_thickness();
reticle.Detectablity = reticle.get_detectablity(objective.D);
%�����⾵
 lieman = PRISM(4.619,0.66,25,1.5163,64.1);
 [lieman.D,lieman.L,lieman.d,lieman.b] = lieman.get_parameters(objective.D,reticle.D,objective.f_);
 %�������
 [Pave,Wave,Cave,P0ave,um_] = abberation(objective.D,objective.f_,objective.fov,reticle.D,lieman.L,lieman.n,lieman.v);
 
 Data = [];
 for ii = [0.005,0.002]
     data = xlsread('glass.xlsx',[num2str(ii)]);
     Data = cat(3,Data,data);
 end
[x,y,P0]= selection(Data,P0ave,Cave,0.005,0.002);

%������״ϵ��
objective.D_wai = objective.D+2;%���9-19
objective.nD = [1.5688 1.6725];%���
A = [2.351859 2.369825];
B = [18.26974 21.5241];
C =[36.24661 48.90792];
K = [1.675929 1.684912];
fai = [1.974117 2.201411];
Q = [-3.884106 -4.541285];
W = [-0.094868 -0.076496];
[objective.A,objective.B,objective.C,objective.K,objective.fai1,objective.Q0,objective.W0]=interpotlation(A,B,C,K,fai,Q,W,0.005,0.002,Cave);
[objective.r,objective.t,objective.d,objective.x] = ob_shape(objective.A,objective.K,objective.fai1,objective.W0,objective.Q0,Pave,Wave,P0,objective.f_,objective.nD,objective.D_wai);
%���ļӺ�
objective.d = objective.d + 1.5;
%׷��˫���Ϲ���
doublet = litrace(objective.r,[0,0],objective.nD,inf,10,'paraxial');
%�޸İ뾶
h = zeros(1,3);
h(1) = objective.D_wai/2;
h(2) = h(1)-objective.d(1)*doublet(7,1);
h(3) = h(2)- objective.d(2)*doublet(7,2);
% objective.r = objective.r.* (h./h(1));
objective.r = [89.994072 -52.228571 -170.773181]
%׷��
doublet2 = litrace(objective.r,objective.d,objective.nD,inf,2,'paraxial');
lieman.b = doublet2(12,3) - lieman.a - lieman.d;%�ȶԼӺ����ﾵ׷����
r = [objective.r inf inf];
d = [objective.d lieman.b lieman.L];
n = [objective.nD 1 lieman.n];
ob_pr_paraxial = litrace(r,d,n,inf,10,'paraxial');
ob_pr_margin = litrace(r,d,n,inf,objective.D_wai/2,'real');
ob_pr_main = litrace(r,d,n,objective.x(1),objective.fov,'paraxial');
ob_pr_707 = litrace(r,d,n,inf,0.707*objective.D_wai/2,'real');
%������������ơ�
L_m = 0.00055/sin(um_).^2;
L_07 = 6*L_m;
L_FC = L_m;
%����ʵ������
opsys.Am = doublet2(12,3)/eyepiece(1).f_;

opsys.dia = objective.D_wai/opsys.Am;
opsys.alpha = 140*(pi/(180*60*60))/objective.D_wai;


    

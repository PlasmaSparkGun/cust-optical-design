classdef PRISM
    %�⾵��
    %   �˴���ʾ��ϸ˵��
    
    properties
       K = [];%�ṹ����
       D = [];%ͨ��ھ�
       k = [];%����ϵ��
       a = [];%�⾵����ƽ�����
       L = [];%�⾵չ������
       n = [];%�⾵������
       b = [];%�⾵���ﾵ����
       d = [];%����ƽ����
       v = [];%�⾵���ϰ�����
    end
    
    methods
        function obj = PRISM(K,k,a,n,v)
            %�����⾵
            %   �˴���ʾ��ϸ˵��
            obj.K = K;
            obj.k = k;
            obj.a = a;
            obj.n = n;
            obj.v = v;
            
        end
        
        function [Dp,L,d,b] = get_parameters(obj,Do,Dr,fo_)
            %METHOD1 �˴���ʾ�йش˷�����ժҪ
            %   D_r �ֻ���ֱ�� D_o �ﾵͨ��ھ� 
            %   f_1 �ﾵ����
            tga = (obj.k.*Do-Dr)/(2.*fo_);
            Dp = (Dr+2.*obj.a.*tga).*(obj.n./(obj.n-2.*obj.K.*tga))+2;
            L = obj.K.*Dp;
            d = L/obj.n;
            b = fo_ - d - obj.a;
        end
    end
end


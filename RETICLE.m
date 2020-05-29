classdef RETICLE
    %�ֻ�����
    %   ����
    
    properties
        D = [];%�ֻ���ֱ��
        T = [];%���
        T_e = [];%������
        Detectablity = [];%������
    end
    
    methods
        function obj = RETICLE(d)
            %RETICLE ��������ʵ��
            %   �˴���ʾ��ϸ˵��
            obj.D = d;
        end
        
        function  [T,T_e]= get_thickness(obj)
            %METHOD1 �˴���ʾ�йش˷�����ժҪ
            %   �˴���ʾ��ϸ˵��
            if obj.D <=10
                T = 1.5;
                T_e = 0.3;
            elseif obj.D <= 18
                T = 2;
                T_e = 0.3;
            elseif obj.D <= 30
                T = 3;
                T_e = 0.5;
            elseif obj.D <= 50
                T = 4;
                T_e = 0.5;
            elseif obj.D <= 80
                T = 5;
                T_e = 0.5;
            end
        end
        function out = get_detectablity(obj,Do)
            out = 140*(pi/(180*60*60))/Do;
        end
    end
end


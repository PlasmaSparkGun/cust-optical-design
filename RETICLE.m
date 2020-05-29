classdef RETICLE
    %分划板类
    %   方法
    
    properties
        D = [];%分化板直径
        T = [];%厚度
        T_e = [];%厚度误差
        Detectablity = [];%鉴别率
    end
    
    methods
        function obj = RETICLE(d)
            %RETICLE 构造此类的实例
            %   此处显示详细说明
            obj.D = d;
        end
        
        function  [T,T_e]= get_thickness(obj)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
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


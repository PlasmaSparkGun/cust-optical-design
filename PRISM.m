classdef PRISM
    %棱镜类
    %   此处显示详细说明
    
    properties
       K = [];%结构参数
       D = [];%通光口径
       k = [];%渐晕系数
       a = [];%棱镜距像平面距离
       L = [];%棱镜展开长度
       n = [];%棱镜折射率
       b = [];%棱镜至物镜距离
       d = [];%空气平板厚度
       v = [];%棱镜材料阿贝数
    end
    
    methods
        function obj = PRISM(K,k,a,n,v)
            %构造棱镜
            %   此处显示详细说明
            obj.K = K;
            obj.k = k;
            obj.a = a;
            obj.n = n;
            obj.v = v;
            
        end
        
        function [Dp,L,d,b] = get_parameters(obj,Do,Dr,fo_)
            %METHOD1 此处显示有关此方法的摘要
            %   D_r 分划板直径 D_o 物镜通光口径 
            %   f_1 物镜焦距
            tga = (obj.k.*Do-Dr)/(2.*fo_);
            Dp = (Dr+2.*obj.a.*tga).*(obj.n./(obj.n-2.*obj.K.*tga))+2;
            L = obj.K.*Dp;
            d = L/obj.n;
            b = fo_ - d - obj.a;
        end
    end
end


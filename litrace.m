function output = litrace(r,d,n,l,h,mode)
%光线追
% 输入参数
% l--初始物距
%h ---初始物高
no = 1;%初始物方折射率，空气
if l ==inf
    u = 0;%初始物方孔径角
else
    u = h;
end

num = numel(r);%折射面个数q
output = zeros(13,num);
n = [n, 1];%加上最后的像方折射率
for ii = 1:num
    output(1,ii) = l;%物距
    ni = n(ii);%像方折射率
    radius = r(ii);%折射面曲率半径
    output(2,ii) = radius;
    if radius == inf | radius == -inf
        i = -u;
        i_ = no/ni*i;
        u_ = -i_;
        lu = l*u;
        l_ = ni/no*l;
        output(3,ii) = l - radius;
        output(8,ii) = i_*radius/u_;
        output(12,ii) = lu/u_;
    else
    switch mode
        case 'paraxial'
            if l == inf
                %平行光入射时
                output(3,ii) = h;
                i = h/radius;%入射角
                lu = h;%计算高度
            else
                output(3,ii) = l - radius;
                i = (l - radius)*u/radius;%计算入射角
                lu = l*u;%计算高度
            end
            i_ = i*(no/ni);%计算出射角
            u_ = u + i - i_;%计算像方孔径角
            output(8,ii) = i_*radius/u_;
            l_ = i_*radius/u_ + radius;%计算像距
            output(12,ii) = lu/u_;%根据高度计算像距
        case 'real'
            if l == inf
                %平行光入射时
                output(3,ii) = h;
                i = h/radius;%入射角
                lu = h;%计算高度
            else
                output(3,ii) = l - radius;
                i = asin((l - radius)*sin(u)/radius);
                lu = l*tan(u);
            end
            i_ = asin(sin(i)*(no/ni));
            u_ = u + i - i_;%计算像方孔径角
            output(8,ii) = sin(i_)*radius/sin(u_);
            l_ = sin(i_)*radius/sin(u_) + radius;%计算像距
            output(12,ii) = lu/tan(u_);
    end
    end
    
    output(4,ii) = i;
    output(11,ii) = lu;
    output(5,ii) = no/ni;
    output(6,ii) = i_ ;
    output(7,ii) = u_;
    output(9,ii) = radius;
    output(10,ii) = l_;
    
    %过渡公式
    if ii < num
        output(13,ii) = d(ii);
        l = l_ - d(ii);
        no = ni;
        u = u_;
    end
end
end


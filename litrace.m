function output = litrace(r,d,n,l,h,mode)
%����׷
% �������
% l--��ʼ���
%h ---��ʼ���
no = 1;%��ʼ�﷽�����ʣ�����
if l ==inf
    u = 0;%��ʼ�﷽�׾���
else
    u = h;
end

num = numel(r);%���������q
output = zeros(13,num);
n = [n, 1];%����������������
for ii = 1:num
    output(1,ii) = l;%���
    ni = n(ii);%��������
    radius = r(ii);%���������ʰ뾶
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
                %ƽ�й�����ʱ
                output(3,ii) = h;
                i = h/radius;%�����
                lu = h;%����߶�
            else
                output(3,ii) = l - radius;
                i = (l - radius)*u/radius;%���������
                lu = l*u;%����߶�
            end
            i_ = i*(no/ni);%��������
            u_ = u + i - i_;%�����񷽿׾���
            output(8,ii) = i_*radius/u_;
            l_ = i_*radius/u_ + radius;%�������
            output(12,ii) = lu/u_;%���ݸ߶ȼ������
        case 'real'
            if l == inf
                %ƽ�й�����ʱ
                output(3,ii) = h;
                i = h/radius;%�����
                lu = h;%����߶�
            else
                output(3,ii) = l - radius;
                i = asin((l - radius)*sin(u)/radius);
                lu = l*tan(u);
            end
            i_ = asin(sin(i)*(no/ni));
            u_ = u + i - i_;%�����񷽿׾���
            output(8,ii) = sin(i_)*radius/sin(u_);
            l_ = sin(i_)*radius/sin(u_) + radius;%�������
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
    
    %���ɹ�ʽ
    if ii < num
        output(13,ii) = d(ii);
        l = l_ - d(ii);
        no = ni;
        u = u_;
    end
end
end


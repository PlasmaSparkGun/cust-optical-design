function [x,y,P0] = selection(P,P0,C,C1,C2)
Pout = (C - C2)./(C1 - C2).*(P(:,:,1)-P(:,:,2))+P(:,:,2);
Diff = abs(Pout - P0);
% [x,y,z] = ind2sub(size(Diff),find(Diff == min(Diff(:))));
[x,y]= find(Diff == min(Diff(:)));
P0 = Pout(x,y);
end
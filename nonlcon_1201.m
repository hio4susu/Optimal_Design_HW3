function [g,geq]=nonlcon_1201(x)
g(1)= -((x(1)^2*x(2)/20)-1);
g(2)= -(((x(1)+x(2)-5)^2)/30+((x(1)-x(2)-12)^2)/120-1);
g(3)= -((80/(x(1)^2+8*x(2)+5))-1);
geq=[];
end

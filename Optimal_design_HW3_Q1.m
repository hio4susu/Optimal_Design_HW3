clear all;clc;close all;
 
x0 = [0 0]; 
A = []; 
b = []; 
Aeq = []; 
beq = []; 
ub = [10 10]; 
lb = [0 0]; 
[x1 , fval1 , exitflag1] = fmincon('obj_1201', x0, A, b, Aeq, beq, lb, ub, 'nonlcon_1201');
[x2 , fval2 , exitflag2] = fmincon('obj_1201_2', x0, A, b, Aeq, beq, lb, ub, 'nonlcon_1201');

figure(1)
hold on
plot(fval1 , fval2 , 'rx');
text(fval1+0.1,  fval2-2, 'Utopia', 'Interpreter','Latex', 'Color', 'r');
title('Pareto Optima')
xlabel('f1')
ylabel('f2')
global fi
for i = 0:10
fi = fval1 + (obj_1201(x2) - fval1)/10*i;
[x, fval, exitflag] = fmincon('obj_1201_2', x0, A, b, Aeq, beq, lb, ub, 'nonlcon_1201_2');
plot(obj_1201(x), obj_1201_2(x), 'bx');
text(5.2, -26, 'A$$\{{f_1}^*, {f_2(x_1^*)}\}$$', 'Interpreter','Latex', 'Color', 'b')
text(9.7, -75, 'B$$\{{f_1(x_2^*)}, {f_2}^*\}$$', 'Interpreter','Latex', 'Color', 'b')
axis([4.5 11 -80 -20]);
x_pareto(i+1, :) = x;
f(i+1, :) = [obj_1201(x) obj_1201_2(x)];
end

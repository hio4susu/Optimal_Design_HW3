clear all;clc;close all;
x0 = [0 0]; 
A = []; 
b = []; 
Aeq = []; 
beq = []; 
ub = [10 10]; 
lb = [0 0]; 
[x, fval , exitflag] = fmincon('obj_1201', x0, A, b, Aeq, beq, lb, ub, 'nonlcon_1201');

%MCS
mux=[x(1),x(2)]; 
stdx=[0.3, 0.3]; 
covX=[stdx(1)^2, 0; 0, stdx(2)^2];

% ctrl+shft+r to uncomment for Q1, Q2, Q3 or Q4 
% Q1
% N=10; 
% times=1;
% Q2
% N=10; 
% times=20;
% Q3
% N=10^6; 
% times=1;
% Q4
N=10^6; 
times=20;


for i = 1:times

RandX=mvnrnd(mux, covX, N);
X1=RandX(:,1);
X2=RandX(:,2);

g1=zeros(N,1);
g2=zeros(N,1);
g3=zeros(N,1);
g1 = -(X1.^2.*X2 ./ 20 - 1);
g2 = -((X1+X2-5).^2 ./ 30 + (X1-X2-12).^2 ./ 120 - 1);
g3 = -(80 ./ (X1.^2+8*X2+5) - 1);

Nf_1(i)=sum(g1>0);
pf_1(i)=Nf_1(i)/N;
Nf_2(i)=sum(g2>0);
pf_2(i)=Nf_2(i)/N;
Nf_3(i)=sum(g3>0);
pf_3(i)=Nf_3(i)/N;

sprintf('Failure probability using MCS with %d samples is %0.5g percent ', N, pf_1*100)
sprintf('Failure probability using MCS with %d samples is %0.5g percent ', N, pf_2*100)
sprintf('Failure probability using MCS with %d samples is %0.5g percent ', N, pf_3*100)
end

avg_pf = [mean(pf_1) mean(pf_2) mean(pf_3)];
std_pf = [std(pf_1) std(pf_2) std(pf_3)];
figure
hold on
plot(1:times , pf_1, 'bo-', 1:times , pf_2, 'ro-', 1:times , pf_3, 'ko-');
xlabel('times'); 
ylabel('Failure probability');
legend('g_{1}', 'g_{2}', 'g_{3}');
axis([0 times+1 -0.5 1.5]);
txt = sprintf('avg: g_{1}=%.3f, g_{2}=%.3f, g_3=%d\nstd: g_{1}=%f, g_{2}=%f, g_3=%d',avg_pf(1), avg_pf(2), avg_pf(3), std_pf(1), std_pf(2), std_pf(3));
text(0.2, 1.3, txt)







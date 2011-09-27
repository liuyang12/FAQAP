%% make cubic figure for QAP paper
clear, close all
load('../data/digraph_qap.mat')

ns = digraph_qap.ms;
[times,errors,iters]=bench_qap(ns);

x=ns; %digraph_qap.ms;
y=times; %digraph_qap.times;
p=polyfit(x,y,3);

n=10000;
np=p(1)*n^3+p(2)*n^2+p(3)*n+p(4);
nyears=np/60/60/24/365;

save('../data/digraph_qap2.mat')


%%
clc
figure(1), clf
hold all

% figure(gcf), 
plot(x,y,'.','markersize',8,'markeredgecolor',0.25*[1 1 1])
xlabel('n','fontsize',18)
ylabel('time (seconds)','fontsize',18)
title('Cubic Scaling of QAP','fontsize',18)
legend('off')
grid('on')


xs=100:100:1000;

yhat=p(1)*xs.^3+p(2)*xs.^2+p(3)*xs+p(4);
plot(xs,yhat,'k','linewidth',2)

str=['$\hat{y}=6.1\!e\!^-\!^{7}x^3 - 4.5\!e\!^-\!^4x^2 + 0.18x - 16.7$'];
text(120,350,str,'fontsize',12,'Interpreter','latex')
axis([min(x) max(x) min(y) max(y)])

%
figname='../figs/digraph_qap2';
wh=[3 2]*1.5;   %width and height
set(gcf,'PaperSize',wh,'PaperPosition',[0 0 wh],'Color','w');
print('-dpdf',figname)

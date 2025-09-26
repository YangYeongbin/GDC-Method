%% 数据处理
IterativeU(IterativeU==0)=[];
IterativeP(IterativeP==0)=[];
%% 画图
h_fig1=figure('Name','TwoMemberPv 迭代过程4');
plot(Uv_sumlast1(:,1),Fv_sumlast1(:,1),...
    '-','Color',[0 0 1],'LineWidth',1.2,'MarkerSize',7,'MarkerFaceColor',[0 0 0]);
hold on
plot(Uv_sumlast2(:,1),Fv_sumlast2(:,1),...
    '-','Color',[1 0 0],'LineWidth',1.2,'MarkerSize',7,'MarkerFaceColor',[0 0 0]);
hold on
plot(IterativeU(:,1),IterativeP(:,1),...
    '-*','Color',[0 0 0],'LineWidth',1.2,'MarkerSize',7,'MarkerFaceColor',[0 0 0]);
hold on
% text(5,-15,'numerical divergence','interpreter','latex','FontSize',20)
plot([0,100],[0,0],'Color',[0 0 0],'LineWidth',0.75);

%% 捕捉迭代区域
% x轴
Iter_Umax=max(IterativeU(:,1));
Iter_Umin=min(IterativeU(:,1));
ChaZhiU=Iter_Umax-Iter_Umin;
U_x1=Iter_Umin-ChaZhiU*0.5;
U_x2=Iter_Umax+ChaZhiU*0.5;
% y轴
Iter_Pmax=max(IterativeP(:,1));
Iter_Pmin=min(IterativeP(:,1));
ChaZhiP=Iter_Pmax-Iter_Pmin;
P_x1=Iter_Pmin-ChaZhiP*0.5;
P_x2=Iter_Pmax+ChaZhiP*0.5;
%% 绘图参数设置
axis([U_x1,U_x2,P_x1,P_x2]); 
set(gca,'xtick',U_x1:ChaZhiU:U_x2);
set(gca,'ytick',P_x1:ChaZhiP:P_x2);
set(gca,'linewidth',0.75);
set(gca,'TickDir','out');
set(gca,'XMinorTick','on')
set(gca,'YMinorTick','on')
ax=gca;
ax.XAxis.MinorTickValues=5:10:55;
ax.YAxis.MinorTickValues=-500:200:500;
leg=legend({'Yang and Chiou','Present','Iterative step'}, ...
    'interpreter','latex','FontSize',20,'box','off'); 
set(leg,'Position',[0.6,0.3,0.2,0.12]); 
leg.ItemTokenSize=[40,10]; 
xlabel('Displacement $$v$$ (in)','interpreter','latex','FontName','Times New Roman','FontSize',20);
ylabel('Load $$P_v$$ (lb)','interpreter','latex','FontName','Times New Roman','FontSize',20);
set(gca,'FontName','Times New Roman','FontSize',18);
set(gcf,'unit','centimeters','position',[5,5,22,16]);
set(gca,'LooseInset',[0,0,0,0]);
saveas(h_fig1,h_fig1.Name,'svg');
grid off                                                                    
box off
ax2=axes('position',get(gca,'position'),'Color','none','XAxislocation','top','YAxislocation','right','XColor','k','YColor','k');
set(ax2,'YTick',[]);
set(ax2,'XTick',[]);

%% 画图
h_fig1=figure('Name','shallowArch_sym');
Mk2 = round(length(U_sumlast3(:,1))/35);
Mk1 = round(length(U_sumlast2(:,1))/35);
plot(U_sumlast3(:,1),F_sumlast3(:,1),...
    '--','Color',[1 0 0],'LineWidth',1.2,'MarkerSize',9,'MarkerFaceColor',[0 0 1],'MarkerIndices',200:Mk2:length(U_sumlast3(:,1)));
hold on
plot(U_sumlast1(:,1),F_sumlast1(:,1),...
    '-','Color',[0 0 1],'LineWidth',1.2,'MarkerSize',9,'MarkerFaceColor',[0 0 0]);
hold on
plot(U_sumlast3(:,1),F_sumlast3(:,1),...
    '+','Color',[1 0 1],'LineWidth',1.2,'MarkerSize',9,'MarkerFaceColor',[0 0 1],'MarkerIndices',200:Mk2:length(U_sumlast3(:,1)));
hold on
plot(U_sumlast2(:,1),F_sumlast2(:,1),...
    '*','Color',[0.2 0 0.2],'LineWidth',1.2,'MarkerSize',9,'MarkerFaceColor',[0 0 0],'MarkerIndices',1:Mk1:length(U_sumlast2(:,1)));
hold on
plot(arc_sym(:,1),arc_sym(:,2),...
    '^','Color',[0 0 1],'LineWidth',1.2,'MarkerSize',7,'MarkerFaceColor',[0 0 1],'MarkerIndices',200:Mk2:length(U_sumlast3(:,1)));
hold on
plot(arc_nsym(:,1),arc_nsym(:,2),...
    's','Color',[0,0.62,0.45],'LineWidth',1.2,'MarkerSize',7,'MarkerFaceColor',[0,0.62,0.45],'MarkerIndices',1:Mk1:length(U_sumlast2(:,1)));
hold on
plot([-100,100],[0,0],'Color',[0 0 0],'LineWidth',1.2);
plot([0,0],[-600,600],'Color',[0 0 0],'LineWidth',1.2);
%% 绘图参数设置
axis([0,12,-0.6,1.8]); 
set(gca,'xtick',0:3:12);
set(gca,'ytick',-0.6:0.6:1.8);
set(gca,'linewidth',1.2);
set(gca,'TickDir','out');
set(gca,'XMinorTick','on')
set(gca,'YMinorTick','on')
ax=gca;
ax.XAxis.MinorTickValues=1.5:3:12;
ax.YAxis.MinorTickValues=-0.3:0.6:1.8;
leg=legend({'Per. P1C1','Imp. P1C1','Per. P3C1','Imp. P3C1','Per. ALM','Imp. ALM'}, ...
    'interpreter','latex','FontSize',22,'box','off'); 
set(leg,'Position',[0.57,0.70,0.2,0.12]); 
leg.ItemTokenSize=[40,10]; 
xlabel('Displacement $$v$$ (in)','interpreter','latex','FontName','Times New Roman','FontSize',24);
ylabel('Load $$P_v$$ (lb)','interpreter','latex','FontName','Times New Roman','FontSize',24);
set(gca,'FontName','Times New Roman','FontSize',24);
set(gcf,'unit','centimeters','position',[5,5,22,16]);
set(gca,'LooseInset',[0,0,0,0]);
grid off                                                                    
box off
ax2=axes('position',get(gca,'position'),'Color','none','XAxislocation','top','YAxislocation','right','XColor','k','YColor','k');
set(ax2,'YTick',[]);
set(ax2,'XTick',[]);
set(ax2,'linewidth',1.2);
saveas(h_fig1,h_fig1.Name,'svg');

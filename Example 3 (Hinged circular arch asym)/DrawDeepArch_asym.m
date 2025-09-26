% -------------------------------------------
% Displacement-Load curve
% -------------------------------------------
function h_fig1 = DrawDeepArch_asym(U1,F1,U2,F2,U3,F3,arc_u,arc_p)
h_fig1=figure('Name','DisplVsLoad');
plot(U1(:,1),F1(:,1),...
    '-','Color',[0 0 0],'LineWidth',1.5,'MarkerSize',7,'MarkerFaceColor',[0 0 0]);
hold on
Mk1 = round(length(U2(:,1))/100);
plot(U2(:,1),F2(:,1),...
    '^','Color',[0 0 1],'LineWidth',1.5,'MarkerSize',7,'MarkerFaceColor',[0 0 1],'MarkerIndices',1:Mk1:length(U2(:,1)));
hold on
Mk3 = round(length(U3(:,1))/90);
plot(U3(:,1),F3(:,1),...
    's','Color',[0,0.62,0.45],'LineWidth',1.5,'MarkerSize',7,'MarkerFaceColor',[0,0.62,0.45],'MarkerIndices',1:Mk3:length(U3(:,1)));
hold on
Mk2 = round(length(arc_u)/50);
plot(arc_u,arc_p,...
    '*','Color',[1 0 0],'LineWidth',1.5,'MarkerSize',7,'MarkerFaceColor',[0 0 1],'MarkerIndices',round(Mk2/2):Mk2:length(arc_u));
hold on
plot([-100,100],[0,0],'Color',[0 0 0],'LineWidth',1.2);
plot([0,0],[-600,600],'Color',[0 0 0],'LineWidth',1.2);
% parameter setting
axis([0,110,-180,180]);                                     
set(gca,'xtick',0:20:110);                                                  
set(gca,'ytick',-180:60:180);
set(gca,'linewidth',1.2);                                            
set(gca,'TickDir','out');
set(gca,'XMinorTick','on')
set(gca,'YMinorTick','on')
ax=gca;
ax.XAxis.MinorTickValues=10:20:120;
ax.YAxis.MinorTickValues=-150:60:200;
leg=legend({'P1C1','P3C1','Yang and Shieh','ALM'}, ...
    'interpreter','latex','FontSize',24,'box','off');             
set(leg,'Position',[0.6,0.77,0.2,0.12]);                              
leg.ItemTokenSize=[40,10]; 
xlabel('Displacement $$v$$ (in)','interpreter','latex','FontName','Times New Roman','FontSize',24);
ylabel('Load $$P_v$$ (lb)','interpreter','latex','FontName','Times New Roman','FontSize',24);
set(gca,'FontName','Times New Roman','FontSize',24);
set(gcf,'unit','centimeters','position',[5,5,22,16]);                  
set(gca,'LooseInset',[0.01,0.01,0.02,0.02]);                                 
grid off                                                              
box off
ax2=axes('position',get(gca,'position'),'Color','none','XAxislocation','top','YAxislocation','right','XColor','k','YColor','k');
set(ax2,'YTick',[]);
set(ax2,'XTick',[]);
set(ax2,'linewidth',1.2);
saveas(h_fig1,h_fig1.Name,'svg');
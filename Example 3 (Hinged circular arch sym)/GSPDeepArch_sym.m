% -------------------------------------------
% Displacement-GSP curve
% -------------------------------------------
function h_fig1 = GSPDeepArch_sym(U1,GSP1,U2,GSP2,U3,GSP3)
h_fig1=figure('Name','GSP');
plot(U1(:,1),GSP1(:,1),...
    '-','Color',[0 0 0],'LineWidth',1.5,'MarkerSize',7,'MarkerFaceColor',[0 0 0]);
hold on
Mk1 = round(length(U2(:,1))/80);
plot(U2(:,1),GSP2(:,1),...
    '^','Color',[0 0 1],'LineWidth',1.2,'MarkerSize',7,'MarkerFaceColor',[0 0 1],'MarkerIndices',round(Mk1/2):Mk1:length(U2(:,1)));
hold on
Mk2 = round(length(U3(:,1))/50);
plot(U3(:,1),GSP3(:,1),...
    '--s','Color',[0,0.62,0.45],'LineWidth',1.5,'MarkerSize',7,'MarkerFaceColor',[0,0.62,0.45],'MarkerIndices',1:Mk2:length(U3(:,1)));
hold on
plot([-100,100],[0,0],'Color',[0 0 0],'LineWidth',1.2);
plot([0,0],[-600,600],'Color',[0 0 0],'LineWidth',1.2);
%% paremeter setting
axis([0,100,-100,400]);                                             
set(gca,'xtick',0:20:100);                                             
set(gca,'ytick',-100:100:400);
set(gca,'linewidth',1.2);                                   
set(gca,'TickDir','out');
set(gca,'XMinorTick','on')
set(gca,'YMinorTick','on')
ax=gca;
ax.XAxis.MinorTickValues=10:20:100;
ax.YAxis.MinorTickValues=-250:100:250;
leg=legend({'P1C1','P3C1','Yang and Shieh'}, ...
    'interpreter','latex','FontSize',24,'box','off');             
set(leg,'Position',[0.4,0.8,0.2,0.12]);                           
leg.ItemTokenSize=[40,10]; 
xlabel('Displacement $$v$$ (in)','interpreter','latex','FontName','Times New Roman','FontSize',24);
ylabel('GSP','interpreter','latex','FontName','Times New Roman','FontSize',24);
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
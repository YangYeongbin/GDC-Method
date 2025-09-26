% -------------------------------------------
% Displacement-GSP curve
% -------------------------------------------
function h_fig1 = GSPTwoMemberTruss(U1,GSP1,U2,GSP2)
h_fig1=figure('Name','GSP');
plot(U1(:,1),GSP1(:,1),...
    '-','Color',[0 0 0],'LineWidth',1.5,'MarkerSize',7,'MarkerFaceColor',[0 0 0]);
hold on
Mk1 = round(length(U2(:,1))/20);
plot(U2(:,1),GSP2(:,1),...
    's','Color',[0,0.62,0.45],'LineWidth',1.5,'MarkerSize',7,'MarkerFaceColor',[0,0.62,0.45],'MarkerIndices',1:Mk1:length(U2(:,1)));
hold on
% Mk2 = round(length(U2(:,1))/25);
% plot(U2(:,1),GSP2(:,1),...
%     'o','Color',[0,0.45,0.62],'LineWidth',1.5,'MarkerSize',7,'MarkerFaceColor',[0,0.45,0.62],'MarkerIndices',1:Mk2:length(U2(:,1)));
% hold on
plot([0,100],[0,0],'Color',[0 0 0],'LineWidth',1.2);
% parameter setting
axis([0,60,-0.2,1]); 
set(gca,'xtick',0:10:60);
set(gca,'ytick',-0.2:0.2:1);
set(gca,'linewidth',1.2);
set(gca,'TickDir','out');
set(gca,'XMinorTick','on')
set(gca,'YMinorTick','on')
ax=gca;
ax.XAxis.MinorTickValues=5:10:55;
ax.YAxis.MinorTickValues=-0.1:0.2:1;
leg=legend({'P1C1','P3C1 (Yang and Shieh)'}, ...
    'interpreter','latex','FontSize',24,'box','off'); 
set(leg,'Position',[0.4,0.8,0.2,0.12]); 
leg.ItemTokenSize=[40,10]; 
xlabel('Displacement $$v$$ (in)','interpreter','latex','FontName','Times New Roman','FontSize',24);
ylabel('GSP','interpreter','latex','FontName','Times New Roman','FontSize',24);
set(gca,'FontName','Times New Roman','FontSize',24);
set(gcf,'unit','centimeters','position',[5,5,22,16]);
set(gca,'LooseInset',[0,0,0.02,0.02]);
grid off                                                                    
box off
ax2=axes('position',get(gca,'position'),'Color','none','XAxislocation','top','YAxislocation','right','XColor','k','YColor','k');
set(ax2,'YTick',[]);
set(ax2,'XTick',[]);
set(ax2,'linewidth',1.2);  
saveas(h_fig1,h_fig1.Name,'svg');

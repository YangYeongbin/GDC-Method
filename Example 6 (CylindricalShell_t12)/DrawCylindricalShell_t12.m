% -------------------------------------------
% Displacement-Load curve
% -------------------------------------------
function h_fig1 = DrawCylindricalShell_t12(U1,F1,U2,F2,U3,F3,U4,F4,Sez_t12_u,Sez_t12_P)
h_fig1=figure('Name','L-P');
plot(U1(:,1),F1(:,1),...
    '-','Color',[0 0 0],'LineWidth',1.5,'MarkerSize',8,'MarkerFaceColor',[0 0 0]);
hold on
Mk1 = round(length(U2(:,1))/20);
plot(U2(:,1),F2(:,1),...
    '^','Color',[0 0 1],'LineWidth',1.5,'MarkerSize',8,'MarkerFaceColor',[0 0 1],'MarkerIndices',1:Mk1:length(U2(:,1)));
hold on
Mk2 = round(length(U3(:,1))/20);
plot(U3(:,1),F3(:,1),...
    's','Color',[0,0.62,0.45],'LineWidth',1.5,'MarkerSize',8,'MarkerFaceColor',[0,0.62,0.45],'MarkerIndices',round(Mk2/2):Mk2:length(U3(:,1)));
hold on
Mk3 = round(length(U4(:,1))/20);
plot(U4(:,1),F4(:,1),...
    '*','Color',[1 0 0],'LineWidth',1.5,'MarkerSize',8,'MarkerFaceColor',[1 0 0],'MarkerIndices',round(Mk3/2):Mk3:length(U3(:,1)));
hold on
Mk5 = round(length(U4(:,1))/20);
plot(U4(:,1),F4(:,1),...
    'o','Color',[0,0.45,0.62],'LineWidth',1.5,'MarkerSize',8,'MarkerFaceColor',[0,0.45,0.62],'MarkerIndices',round(Mk5/2):Mk5:length(U3(:,1)));
hold on
Mk4 = length(Sez_t12_u);
scatter(Sez_t12_u(1:2:Mk4),Sez_t12_P(1:2:Mk4),100,'+','m','LineWidth',1);
plot([-100,100],[0,0],'Color',[0 0 0],'LineWidth',1.2);
plot([0,0],[-600,600],'Color',[0 0 0],'LineWidth',1.2);
% Parameter setting
axis([0,30,0,4]); 
set(gca,'xtick',0:5:30);
set(gca,'ytick',0:1:4);
set(gca,'linewidth',1.2);
set(gca,'TickDir','out');
set(gca,'XMinorTick','on')
set(gca,'YMinorTick','on')
ax=gca;
ax.XAxis.MinorTickValues=2.5:5:35;
ax.YAxis.MinorTickValues=0.5:1:4;
leg=legend({'P1C1','P2C1','P3C1','P4C1','ALM','Sze'}, ...
    'interpreter','latex','FontSize',24,'box','off'); 
set(leg,'Position',[0.6,0.7,0.2,0.12]); 
leg.ItemTokenSize=[40,10]; 
xlabel('Displacement of central point (mm)','interpreter','latex','FontName','Times New Roman','FontSize',24);
ylabel('Load $$P$$ (kN)','interpreter','latex','FontName','Times New Roman','FontSize',24);
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

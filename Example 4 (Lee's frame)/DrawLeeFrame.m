% -------------------------------------------
% Displacement-Load curve
% -------------------------------------------
function h_fig1 = DrawLeeFrame(U1,F1,U2,F2,U3,F3,U4,F4,Ref_U,Ref_P)
h_fig1=figure('Name','DisplVsLoad');
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
Mk4 = length(Ref_U);
scatter(Ref_U(1:2:Mk4),Ref_P(1:2:Mk4),100,'+','m','LineWidth',1.5)
Mk5 = round(length(U4(1:75,1))/8);
plot(U4(1:75,1),F4(1:75,1),...
    'o','Color',[0,0.45,0.62],'LineWidth',1.5,'MarkerSize',8,'MarkerFaceColor',[0,0.45,0.62],'MarkerIndices',round(Mk5/2):Mk5:round(length(U4(1:75,1))));
hold on
plot([-100,100],[0,0],'Color',[0 0 0],'LineWidth',1.5);
plot([0,0],[-600,600],'Color',[0 0 0],'LineWidth',1.5);
text(0.3,2.2,'Numerical divergence','Color',[0,0.45,0.62],'FontSize',20,'FontName','Times New Roman')
% parameter setting
axis([0,1,-1.5,2.5]);                                                 
set(gca,'xtick',0:0.2:1);                                                
set(gca,'ytick',-1.5:1:2.5);
set(gca,'linewidth',1.5);                                               
set(gca,'TickDir','out');
set(gca,'XMinorTick','on')
set(gca,'YMinorTick','on')
ax=gca;
ax.XAxis.MinorTickValues=0.1:0.2:1.0;
ax.YAxis.MinorTickValues=-1:0.5:8;
leg=legend({'P1C1','P2C1','P3C1','P4C1','Schweizerhof et al.','ALM'}, ...
    'interpreter','latex','FontSize',23,'box','off'); 
set(leg,'Position',[0.27,0.33,0.2,0.12]); 
leg.ItemTokenSize=[40,10]; 
xlabel('Displacement $$v$$ (m)','interpreter','latex','FontName','Times New Roman','FontSize',24);
ylabel('Load $$P_v$$ (kN)','interpreter','latex','FontName','Times New Roman','FontSize',24);
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
% -------------------------------------------
% Displacement-load curve
% -------------------------------------------
function h_fig1 = DrawTwoMemberTruss(U1,F1,U2,F2,Papadrakakis_u,Papadrakakis_P,U3,F3,U4,F4)
h_fig1 = figure('Name','DisplVsLoad');
plot(U1(:,1),F1(:,1),...
    '-','Color',[0 0 0],'LineWidth',1.5,'MarkerSize',7,'MarkerFaceColor',[0 0 0]);
hold on
Mk1 = round(length(U2(:,1))/20);
plot(U2(:,1),F2(:,1),...
    's','Color',[0,0.62,0.45],'LineWidth',1.5,'MarkerSize',7,'MarkerFaceColor',[0,0.62,0.45],'MarkerIndices',1:Mk1:length(U2(:,1)));
hold on
% Mk5 = round(length(U2(:,1))/25);
% plot(U2(:,1),F2(:,1),...
%     'o','Color',[0,0.45,0.62],'LineWidth',1.5,'MarkerSize',7,'MarkerFaceColor',[0,0.45,0.62],'MarkerIndices',1:Mk5:length(U2(:,1)));
% hold on
Mk3 = length(Papadrakakis_P);
scatter(Papadrakakis_u(1:1000:Mk3),Papadrakakis_P(1:1000:Mk3),100,'+','m','LineWidth',1);
% Mk2 = round(length(U3)/20);
% plot(U3,F3,...
%     '*','Color',[1 0 0],'LineWidth',1.5,'MarkerSize',7,'MarkerFaceColor',[0 0 1],'MarkerIndices',1:Mk2:length(U3));
% hold on
Mk4 = round(length(U4)/10);
plot(U4,F4,'*','Color',[1 0 0],'LineWidth',1.5,'MarkerSize',7,'MarkerFaceColor',[1 0 0],'MarkerIndices',1:Mk4:length(U4));
hold on
text(3,550,'Numerical divergence','Color',[1 0 0],'FontName','Times New Roman','FontSize',16); hold on
plot([0,100],[0,0],'Color',[0 0 0],'LineWidth',1.2);
% parameter setting
axis([0,60,-600,600]); 
set(gca,'xtick',0:10:60);
set(gca,'ytick',-600:200:600);
set(gca,'linewidth',1.2);
set(gca,'TickDir','out');
set(gca,'XMinorTick','on')
set(gca,'YMinorTick','on')
ax=gca;
ax.XAxis.MinorTickValues=5:10:55;
ax.YAxis.MinorTickValues=-500:200:500;
leg=legend({'P1C1','P3C1 (Yang and Shieh)','Pecknold et al.','ALM'}, ...
    'interpreter','latex','FontSize',20,'box','off'); 
set(leg,'Position',[0.58,0.7,0.2,0.12]); 
leg.ItemTokenSize=[40,10]; 
xlabel('Displacement $$v$$ (in)','interpreter','latex','FontName','Times New Roman','FontSize',24);
ylabel('Load $P_v$ (lb)','interpreter','latex','FontName','Times New Roman','FontSize',24);
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
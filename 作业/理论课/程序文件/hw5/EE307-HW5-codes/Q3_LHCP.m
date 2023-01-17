wt=linspace(0,6*pi,900);
a=cos(wt);
b=cos(wt+pi/6);
for i=1:900
    plot(a,b,'k','LineWidth',2);
    hold on
    scatter(0,0,108,'k','filled');
    title('11911303 吉辰卿，LHCP 传播方向是+z方向')
    hold on;
    axis equal;
    quiver(0,0,a(i),b(i),1,'k','LineWidth',2);
    quiver(0,0,a(i),0,1,'r','LineWidth',2);
    quiver(0,0,0,b(i),1,'b','LineWidth',2);
    hold off
    getframe;
end

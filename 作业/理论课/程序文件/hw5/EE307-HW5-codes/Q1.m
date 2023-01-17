wt=linspace(0,6*pi,900);
b1=cos(wt+pi/2);
a1=cos(wt);
for i=1:1:900
    plot(a1,b1,'k','LineWidth',2);
    hold on
    scatter(0,0,108,'k','filled');
    title('11911303 吉辰卿,传播方向是+z方向')
    hold on
    axis equal;
    quiver(0,0,a1(i),b1(i),1,'b','LineWidth',2);
    hold off
    getframe;
end

%%
f=2.4e9;
c=3e8;
len=c/f;
d=dipole('Length',len/200,'Width',len/20000);
figure(1);
pattern(d,2.4e9);
figure(2);
pattern(d,2.4e9,0,1:1:360);
%%
clear
clc
epsilon= 8.85e-12;%fre space permitivity
f = 3e9;%frequency
c = 3e8;%speed of light
w = 2*pi*f;%omega
lambda = c/f;%wavelength
B = 2*pi/lambda; %beta
dl = lambda/500; %length of antenna
dt=1/f/20;
I0 = 1;%current
[x,z]=meshgrid(-lambda:dl:lambda,-lambda:dl:lambda);
r = (x.^2+z.^2).^(1/2);
theta = atan(x./z);
n = B/(w*epsilon);
E1 = n*I0*dl/(2*pi);
E2 = cos(theta);
E3 = r.^(-2)-r.^(-3)*1i/B;
E4 = exp(-1i*B*r);
E =E1*E2.*E3.*E4;%r component of the field
n= 100;
% % M = moviein(n);
M(n) = struct('cdata',[],'colormap',[]);%Initializing Matrix to store frames
h = figure;
ax = gca;
ax.NextPlot = 'replaceChildren';
h.Visible = 'off';%Hiding figure for speed up 
v = -1:0.13:1;%parameter for scaling contour plots
for xx=1:n
    t=xx*dt;
    Et=real(E*exp(1j*w*t));%converting to time domain
    contour(Et,v)
    drawnow
    M(xx) = getframe;
end
h.Visible = 'on';
movie(M);shg

%%
clc;
clear;
antenna = phased.ShortDipoleAntennaElement(...
    'FrequencyRange',[1,2]*1e9,'AxisDirection','Z');
el = [-90:90];
az = zeros(size(el));
fc = 1.5e9;
resp = antenna(fc,[az;el]);
az = 180.0*ones(size(el));
resp1 = antenna(fc,[az;el]);
figure(1);
subplot(121);
polarplot(el*pi/180.0,abs(resp.V.'),'b');
hold on;
polarplot((el+180)*pi/180.0,abs(resp1.V.'),'b');
str = sprintf('%s\n%s','Vertical Polarization','vs Elevation Angle');
title(str);
hold off;
subplot(122);
polarplot(el*pi/180.0,abs(resp.H.'),'b');
hold on;
polarplot((el+180)*pi/180.0,abs(resp1.H.'),'b');
str = sprintf('%s\n%s','Horizontal Polarization','vs Elevation Angle');
title(str);
hold off;
figure(2);
pattern(antenna,fc);
figure(3);
pattern(antenna,fc,0);
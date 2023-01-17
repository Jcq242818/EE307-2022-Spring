clear
clc
%定义一些常量
er=2.33;
e0=8.854187817e-12;
gamm=0.577216; 
miu0=(4*pi)*1e-7;   %定义磁导率常量
yita0=376.7303;
sigma=3e7;
f= 1.575e9;
h=1.575e-3;
c= 3e8;
lambda0=c/f;       
w=2*pi*f;
k0=2*pi/lambda0;
W_divi_L=1.5; %定义长与宽相除的常量--1.5      
sigm=3e7;           
tand=0.001;     
Rin=50;   %在该频率下的输入阻抗是50欧       
R_resonance = 50; %在该频段下的谐振频率
a=0.635e-3; 

% 第一问:计算贴片的长与宽
% L=lambda0/(2*sqrt(er));
% W=L*1.5;
% L_cm = L*100
% W_cm = W*100
% 
W=c/(2*f) * sqrt(2/(er+1));
ereff=(er+1)/2 + (er-1)/2 * (1+12*h/W)^(-1/2);
Leff=c/(2*f*sqrt(er));
dL=h*0.412*(ereff+0.3)*(W/h+0.264)/((ereff-0.258)*(W/h+0.8));
L=(Leff-2*dL);
W=L*1.5;
L_cm = L*100
W_cm = W*100

Rs=sqrt(w*miu0/2/sigma); %Rs is the surface resistance of the metal

%与辐射效率有关的常量定义
c1=1-1/er+2/5/(er)^2;
c2=-0.0914153;
a2=-0.16605;
a4=0.00761;
p=1+a2/10*(k0*W)^2+(a2^2+2*a4)*(3/560)*(k0*W)^4+c2*(1/5)*(k0*L)^2+a2*c2*(1/70)*(k0*W)^2*(k0*L)^2;
e_rhed=1/(1+3/4*pi*(k0*h)*(1/c1)*(1-1/er)^3);

%第二问:计算馈电位置——x0
Re=(4*yita0/pi)*(1/W_divi_L)*(h/lambda0)/(tand+(Rs/pi/yita0)*(1/(h/lambda0))+(16/3)*(p*c1/er)*(W_divi_L)*(h/lambda0)*(1/e_rhed));
x0=(L/pi)*acos(sqrt(Rin/Re))*1e2;
x0

%第三四五问
%计算带宽与辐射效率
BW=1/(sqrt(2))*(tand+(Rs/pi/yita0)*(1/(h/lambda0))+(16/3)*(p*c1/er)*(h/lambda0)*(W_divi_L)*(1/e_rhed));
BW=BW*100;  %转化为百分比
BW
eff=e_rhed/(1+e_rhed*(tand+(Rs/pi/yita0)*(1/(h/lambda0)))*(3/16)*(er/p/c1)*(1/W_divi_L)*(1/(h/lambda0))); 
effiency=eff*100;
effiency
%计算probe reactance
Xp=(yita0/2/pi)*(k0*h)*(-gamm+log( 2/(sqrt(er)*k0*a)));
Xp

%第六七八问
%计算输入复阻抗
Zin=Rin+1i*Xp;
Zin

%计算方向性与增益
k1=k0*sqrt(er);
D=(3/p/c1)*(er/(er+(tan(k1*h)^2))*(tan(k1*h)/(k1*h))^2);
G=D*eff;
D
G






f_test=linspace(1.5e9,1.65e9,2000);  %对频段进行扫描
k_test=2*pi*f_test/c;  %由频率推出k值
Q=1/(BW/100*sqrt(2));
Q
R=R_resonance./(1+(Q*(f_test./f-f./f_test)).^2);  %计算在某一频率处天线端的阻抗
Zin_test = 1i*Xp + R_resonance./(1+1i*Q.*(f_test./f-f./f_test));
Xin = imag(Zin_test);
plot(f_test, R,'lineWidth',2)
hold on
plot(f_test, Xin,'-r','lineWidth',2)
axis([1.5e9,1.65e9,-20,50]);
% set(gca,'ytick',-20:10:60);
grid on
set(gca, 'FontWeight','bold','LineWidth',2);
title('Relationship between Input Impedance and Frequency')
xlabel('Frequency');
ylabel('Input Impedance');
legend('Rin','Xin');
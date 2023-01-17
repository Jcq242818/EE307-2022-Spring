%第一问:确定参数
N = 10;  %10 turn
lanmuda0 = 1; %默认的波长量,因为后面的量都是以波长为基准的，因此该量置为1即可
C_lanmuda = 1; % the circumference in wavelengths is 1
alpha = 14;   % alpha为14度
S_lanmuda = C_lanmuda*tand(alpha); %separation between turns (in wavelengths)
S_lanmuda

%第二问:确定HPBW
HPBW = (52*lanmuda0^(1.5))/(C_lanmuda*sqrt(N*S_lanmuda));
HPBW

%第三问:计算方向性
D0 = (15*N*C_lanmuda^(2)*S_lanmuda)/lanmuda0^(3);
D0
%将D0单位转化为dBi
D0_dBi = 10*log10(D0);
D0_dBi




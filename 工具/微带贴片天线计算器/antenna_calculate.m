c = 3e8;
f = 2.4e9;
er = 2.2;
h = 2e-3;

W = c/(2*f)*sqrt(2/(er+1))  %辐射贴片的宽度
er_eff = (er+1)/2 +(er-1)/2* (1+12*h/W)^(-0.5); %有效介电常数的计算
dL = (0.412*(er_eff+0.3)*(W/h+0.264)*h) / ((er_eff-0.258)*(W/h+0.8)); %计算等效的辐射缝隙长度
L_eff = c/(2*f*sqrt(er_eff));
L = L_eff - 2*dL  %计算实际的辐射贴片长度L

%微带线馈电的贴片天线
lambda_0 = c/f;
if W<= lambda_0
    G = W^2 / (90*lambda_0^2);
else
    G = W^2 / (120*lambda_0^2);
end

Y_in = 2*G;
R_in = 1/Y_in %计算出天线贴片的等效阻抗
Z_T0 = sqrt(R_in*50)  %计算出1/4变换器的等效阻抗
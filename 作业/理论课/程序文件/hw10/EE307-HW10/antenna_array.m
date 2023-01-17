for i=0:6
    theta = linspace (0,2*pi,100);
    N=10;
    fi =pi*cos(theta)+i*pi/3;
    AF =sin(N*fi/2)./(N*sin(fi/2));
    figure(i+1);
    polarplot(theta,AF);
    switch i
    case 0
        title('phaseshift= 0');
    case 1
        title('phaseshift= pi/3');
    case 2
        title('phaseshift= 2*pi/3');
    case 3
        title('phaseshift= pi');
    case 4
        title('phaseshift= 4*pi/3');
    case 5
        title('phaseshift= 5*pi/3');
    case 6
        title('phaseshift= 2*pi');
    otherwise
        break
    end
end
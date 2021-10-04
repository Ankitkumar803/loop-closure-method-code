clear all;clearvars;
syms theta_1 theta_2 theta_3 l1 l2 l3 l4 l5 l omega_1 omega_2 omega_3 alpha_2 alpha_3 dl3 ddl3

l1=0.4
l2=0.2
l4=0.7
l5=0.5
l=0.6


theta_1=0*pi/180


theta_2 = 30*pi/180;l3=0.4
x = [theta_2;l3]
dx = [100;100]

V1 = [0;0]
omega_1=7*pi

theta_3 = 30*pi/180;s=0.1;
x1 = [theta_3;s]
dx1 = [100;100]

f = [l3*cos(theta_2)-l1-l2*cos(theta_1);l3*sin(theta_2)-l2*sin(theta_1)]
J = [-l3*sin(theta_2) cos(theta_2); l3*cos(theta_2) sin(theta_2)]

f1 = [l4*cos(theta_2)+l5*sin(theta_3)-l;l4*sin(theta_2)+l5*cos(theta_3)-s]
J1 = [l5*cos(theta_3) 0;-l5*sin(theta_3) -1]


figure
xlabel('\theta_{1}')
title('acceleration Analysis')
hold on

i = 1

while theta_1 < 2*pi
    
    while abs(dx(1,:))>0.01 && abs(dx(2,:))>0.01
        dx = -inv(J)*f
        x = x + dx

        theta_2= x(1,:);l3=x(2,:)
        f = [l3*cos(theta_2)-l1-l2*cos(theta_1);l3*sin(theta_2)-l2*sin(theta_1)]
        J = [-l3*sin(theta_2) cos(theta_2); l3*cos(theta_2) sin(theta_2)]
        
        V1 = inv(J)*omega_1*[-l2*sin(theta_1);l2*cos(theta_1)]
        omega_2 = V1(1,:)
        dl3 = V1(2,:)
        
        a1 = inv(J)*[-l2*cos(theta_1)*omega_1^2+cos(theta_2)*l3*omega_2^2+2*sin(theta_2)*dl3*omega_2;
            -l2*sin(theta_1)*omega_1^2+l3*sin(theta_2)*omega_2^2-2*cos(theta_2)*dl3*omega_2]
        alpha_2=a1(1,:)
        ddl3 = a1(2,:)
        
        
        
        dx1 = -inv(J1)*f1
        x1 = x1 + dx1
        
        theta_3=x1(1,:);s=x1(2,:)
        f1 = [l4*cos(theta_2)+l5*sin(theta_3)-l;l4*sin(theta_2)+l5*cos(theta_3)-s]
        J1 = [l5*cos(theta_3) 0;-l5*sin(theta_3) -1]
        
        
        V2 = inv(J1)*omega_2*[l4*sin(theta_2);-l4*cos(theta_2)]
        omega_3 = V2(1,:)
        ds = V2(2,:)
        
        a2 = inv(J1)*[l4*cos(theta_2)*omega_2^2+l5*sin(theta_3)*omega_3^2+l4*sin(theta_2)*alpha_2;
            l4*sin(theta_2)*omega_2^2+l5*cos(theta_3)*omega_3^2-l4*cos(theta_2)*alpha_2]
        alpha_3=a2(1,:)
        dds = a2(2,:)
    end
    
    yyaxis left
    plot(180*theta_1/pi,alpha_3,'b.')
    ylabel('\alpha_{3}')
    
    
    yyaxis right
    plot(180*theta_1/pi,dds,'r.')
    ylabel('a_{s}')
    legend('\omega_{3}','a_{s}')
    
    if 180*theta_1/pi > 59 && 180*theta_1/pi < 62
        yyaxis left
        plot(180*theta_1/pi,alpha_3,'go')
        labelstr = sprintf('(%.2f,%.2f)',180*theta_1/pi,alpha_3);
        text(180*theta_1/pi,alpha_3,labelstr)
        yyaxis right
        plot(180*theta_1/pi,dds,'mo')
        labelstr1 = sprintf('(%.2f,%.2f)',180*theta_1/pi,dds);
        text(180*theta_1/pi,dds,labelstr1) 
    end

    
    theta_1 = theta_1 + pi/60
    dx=[100;100]
    
    %hold on
    disp(i)
    i = i + 1
end

disp(180*x(1,:)/pi)
disp(x(2,:))
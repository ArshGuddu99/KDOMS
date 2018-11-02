rb=input('Enter the radius of the base circle: ');
L = input('Enter the lift of the follower: ');
e= input('Enter value of offset: ');
rr=input('Enter the value of roller radius: ');
rp=rr+rb;
d=sqrt(rp*rp-e^2);
%pax = gca;
%pax.ThetaZeroLocation='top';
Theta_base=0:0.01:2*pi;
y=zeros(1,length(Theta_base));
Phi=zeros(1,length(Theta_base));
y_dash=zeros(1,length(Theta_base));
Theta_init=0;
x_point=zeros(1,length(Theta_base));
y_point=zeros(1,length(Theta_base));
r_point=zeros(1,length(Theta_base));
Theta_point=zeros(1,length(Theta_base));
figure(1)
%for i=1:length(Theta_base)
%    polar(Theta_base(i),rb,'r');
%end
polar(Theta_base,rb*ones(1,length(Theta_base)));
hold on;
Theta_rise_acc=60*pi/180;
Theta_rise_dec=90*pi/180;
Theta_rise=150*pi/180;
Theta_dwell=30*pi/180;
Theta_fall_acc=60*pi/180;
Theta_fall_dec=90*pi/180;
Theta_fall=150*pi/180;
Theta_rd=Theta_rise+Theta_dwell;
Theta_rdf_d=Theta_rd+Theta_fall_dec;
Theta_rdf=Theta_rd+Theta_fall;
Theta_cycle=Theta_rdf+Theta_dwell;
for i=1:length(Theta_base)
    if(Theta_base(i)>Theta_init && Theta_base(i)<=Theta_rise_acc)
        y(i)=3.6*L/(pi*pi)*(Theta_base(i)*Theta_base(i));
        y_dash(i)=(7.2*L/(pi*pi))*(Theta_base(i)^2);
    elseif(Theta_base(i)>=Theta_rise_acc && Theta_base(i)<=Theta_rise)
        y(i)=-(2.4*L/(pi*pi))*(Theta_base(i)^2)+((4/pi)*L)*Theta_base(i) - (2*L/3);
        y_dash(i)=-4.8*(L/(pi*pi))*Theta_base(i) + 4/pi*Theta_base(i);
    elseif(Theta_base(i)>=Theta_rise && Theta_base(i)<Theta_rd)
        y(i)=y(i-1);
        y_dash(i)=0;
    elseif(Theta_base(i)>=Theta_rd && Theta_base(i)<=Theta_rdf_d)
        y(i)=(-2.4*L/(pi*pi))*(Theta_base(i)^2)+(4.8*L/pi)*Theta_base(i)-1.4*L;
        y_dash(i)=(-4.8*L/(pi*pi))*Theta_base(i) + (4.8*L/pi);
    elseif(Theta_base(i)>=Theta_rdf_d && Theta_base(i)<=Theta_rdf)
        y(i)=(3.6*L/(pi*pi))*(Theta_base(i)^2)-(13.2*L/pi)*Theta_base(i)+12.1*L;
        y_dash(i)=(7.2*L/(pi*pi))*Theta_base(i) - (13.2*L/pi);
    elseif(Theta_base(i)>=Theta_rdf && Theta_base(i)<=Theta_cycle)
        y(i)=y(i-1);
        y_dash(i)=0;
    end
    Phi(i)=atan((y_dash(i)-e)/(y(i)+d));
    x_point(i)=e+rr*sin(Phi(i));
    y_point(i)=d+y(i)-rr*cos(Phi(i));
    r_point(i)=sqrt((x_point(i)^2)+(y_point(i)^2));
    Theta_point(i)=-(Theta_base(i)+atan(x_point(i)/y_point(i)));
    %polarplot(Theta_point(i),r_point(i),'b','LineWidth',8);
end
polar(Theta_point,r_point);
hold off;
figure(2)
plot(Theta_base,Phi);
hold on;
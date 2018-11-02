rb=input("Enter the value base circle radius: ");
e= input("Enter offset value: ");
Emax_rise=input("Enter the maximum driving eccentricity during rise: ");
Emax_fall=input("Enter the maximum driving eccentricity during fall: ");
Rho_min= input("Enter the minimum radius of curvature of cam profile: ");
n= input("Enter the number of cycles: ");
Alpha=0:0.01:360;
Alp=Alpha*pi/180;
hold on;
axis('equal');
polar(Alp,rb*ones(1,length(Alp)));
plot([0,1],[0,0],'--r','linewidth',8);
Theta_initial=0;
r_point=rb*ones(1,100);
for i=1:n
  C1=input("Enter the follower motion for cycle \n1: 1.SHM\n 2. Parabolic\n 3. Cycloidal\n 4. Dwell\n");
  if(C1==1||C1==2||C1==3)
  C2=input("1. rise or 2. fall :");
  if(C2==1)
    L=input("Enter the value of lift:");
    Theta_r=input("Enter the angle of rise: ");
    Theta_rise=Theta_r*pi/180;
  else
    F=input("Enter the value of fall: ");
    Theta_f=input("Enter the angle of fall: ");
    Theta_fall=Theta_f*pi/180;
  endif;
  if(C1==1)
    if(C2==1)
      Theta_rise_1=linspace(Theta_initial,Theta_initial+Theta_rise,100);
      for j=1:100
        Theta_point(j)=(pi/2)-atan((L/2*pi/Theta_rise*sin(Theta_rise_1(j)*pi/Theta_rise))/(rb+((L/2)*(1-cos(Theta_rise_1(j)*pi/Theta_rise)))));
        r_point(j)=sqrt((rb+(L/2*cos(Theta_rise_1(j)*pi/Theta_rise)))^2 + (L/2*pi/Theta_rise*sin(Theta_rise_1(j)*pi/Theta_rise))^2);
        polar(Theta_point(j),r_point(j),'r');
      end;
      Theta_initial+=Theta_rise;
    endif;
    if(C2==2)
      Theta_fall_1=linspace(Theta_initial,Theta_initial+Theta_fall,100);
      for j=1:100
        Theta_point(j)=(pi/2)-atan((L/2*pi/Theta_fall*sin(Theta_fall_1(j)*pi/Theta_fall))/(rb+((L/2)*(1-cos(Theta_fall_1(j)*pi/Theta_fall)))));
        r_point(j)=sqrt((rb+(L/2*cos(Theta_fall_1(j)*pi/Theta_fall)))^2 + (L/2*pi/Theta_fall*sin(Theta_fall_1(j)*pi/Theta_fall))^2);
        polar(Theta_point(j),r_point(j),'r');
      end;
      Theta_initial+=Theta_fall;  
    endif;
  endif; 
  endif;
  if(C1==4)
    Theta_d=input("angle of dwell: ");
    Theta_dwell=Theta_d*pi/180;
    r_point=r_point(100)*ones(1,100);
    Theta_dwell_1=linspace(Theta_initial,Theta_initial+Theta_dwell,100);
    Theta_point(j)=(pi/2)-atan((L/2*pi/Theta_dwell*sin(Theta_dwell_1(j)*pi/Theta_dwell))/(rb+((L/2)*(1-cos(Theta_dwell_1(j)*pi/Theta_dwell)))));
    r_point(j)=sqrt((rb+(L/2*cos(Theta_dwell_1(j)*pi/Theta_dwell)))^2 + (L/2*pi/Theta_dwell*sin(Theta_dwell_1(j)*pi/Theta_dwell))^2);
    for j=1:100
      polar(Theta_point(j),r_point(j),'r');
    end;
    Theta_initial+=Theta_dwell;
    endif;
 end;
 
 
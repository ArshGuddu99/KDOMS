r = input('Enter the Base circle radius of the cam in mm :');
h = input('Enter the Height follower is needed to move in mm: ');
e = input("Enter the value of offset: ");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
alp = 0:0.01:2*pi;
polar(alp,r*ones(1,length(alp)),'r')
%%pax = gca;
%%pax.ThetaZeroLocation = 'top';
hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n =input('Enter the number of motions follower as to complete in one cycle ');
H=0;th=0; % Initialization of H, and th which will be used in loop
for j=1:n
    
    if H==0
        fprintf('Enter the Angle till where %d  Motion is followed\n',j)
        th1 = input('Enter the Angle ');
        fprintf('Options for different follower motions are \n1.SHM\n2.DWELL\n3.UV\n')
        fprintf('Enter the type of %d  Motion is followed\n',j)
        S1S = input('Enter the type of motion the knife edge should follow ');
        if S1S>3 || S1S<1 
            error('Please enter number between 1 and 3, both included')
        end
        th1div = linspace(th,th1,100);
        if S1S == 1
            ThetaCircle=linspace(0,180,100);
            h1=zeros(1,100);
            for i=1:length(th1div)
                if ThetaCircle(i)<=90
                    h1(i)=h/2 - cosd(ThetaCircle(i))*h/2 ;
                else
                    h1(i)=h/2 + cosd(180-ThetaCircle(i))*h/2 ;
                end
            end
            P1=polar(th1div*pi/180,h1+r,'b');
            
        elseif S1S == 2
            h1 = zeros(1,100);
            P1 = polar(th1div*pi/180,r*ones(1,100),'b');
        
        else
            h1=zeros(1,100);
            for i=2:length(th1div)
                h1(i) = (i-1)*h/99 ;
            end
            P1 = polar(th1div*pi/180,h1+r,'b');
        end
        
        hold on
        th=th1;
    elseif H==h
        fprintf('Enter the Angle till where %d  Motion is followed\n',j)
        th2 = input('Enter the Angle ');
        fprintf('Options for different follower motions are \n1.SHM\n2.DWELL\n3.UV\n')
        fprintf('Enter the type of %d  Motion is followed\n',j)
        S2S = input('Enter the type of motion the knife edge should follow ');
        if S2S>3 || S2S<1 
            error('Please enter number between 1 and 3, both included')
        end
        
        th2div = linspace(th,th2,100);
        if S2S == 1
            ThetaCircle=linspace(0,180,100);
            h1=zeros(1,100);
            for i=1:length(th2div)
                if ThetaCircle(i)<=90
                    h1(i)=h/2 + cosd(ThetaCircle(i))*h/2 ;
                else
                    h1(i)=h/2 - cosd(180-ThetaCircle(i))*h/2 ;
                end
            end
            P2=polar(th2div*pi/180,h1+r,'b');
            
        elseif S2S == 2
            h1 = h*ones(1,100);
            P2 = polar(th2div*pi/180,h1+r,'b');
            
        else
            h1=zeros(1,100); h1(1)=h;
            for i= 2:length(th2div)
                h1(i) = h - (i-1)*h/99 ;
            end
            P2 = polar(th2div*pi/180,h1+r,'b');
        end  
        th=th2;
 
    end
    
    hold on
    H=h1(100);
end
grid on
grid minor
title('\fontsize{16} Cam Profile')
legend('Base Circle','Cam Profile')
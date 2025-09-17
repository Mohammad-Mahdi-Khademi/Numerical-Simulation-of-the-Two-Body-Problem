clc;
clear;
close all;

%initial state
H = 0.0001;
n = 60 / H;
t = zeros(1,n);
t(1) = 0;


G = 10;

x1 = zeros(1,n);
y1 = zeros(1,n);

x2 = zeros(1,n);
y2 = zeros(1,n);

Vx1 = zeros(1,n);
Vy1 = zeros(1,n);

Vx2 = zeros(1,n);
Vy2 = zeros(1,n);

x2(1) = 0;   %[m]
y2(1) = 0;  %[m]

x1(1) = 30;  %[m]
y1(1) = input ('h = : ');  %[m]

Vx1(1) =0 ; %[m/s]
Vy1(1) = 0; %[m/s]

Vx2(1) = input ('V0 = : '); %[m/s]
Vy2(1) = 0; %[m/s]

m1 = 2000; %[kg]
m2 = 2000; %[kg]



%main functions
fFx1 = @(t,x1,Vx1,y1,Vy1,x2,Vx2,y2,Vy2) (G*m2*(x2-x1))/(((x1-x2)^2+(y1-y2)^2)^1.5);
fFy1 = @(t,x1,Vx1,y1,Vy1,x2,Vx2,y2,Vy2) (G*m2*(y2-y1))/(((x1-x2)^2+(y1-y2)^2)^1.5);

fFx2 = @(t,x1,Vx1,y1,Vy1,x2,Vx2,y2,Vy2) (G*m1*(x1-x2))/(((x1-x2)^2+(y1-y2)^2)^1.5);
fFy2 = @(t,x1,Vx1,y1,Vy1,x2,Vx2,y2,Vy2) (G*m1*(y1-y2))/(((x1-x2)^2+(y1-y2)^2)^1.5);

fVx1 = @(t,x1,Vx1,y1,Vy1,x2,Vx2,y2,Vy2) Vx1;
fVy1 = @(t,x1,Vx1,y1,Vy1,x2,Vx2,y2,Vy2) Vy1;

fVx2 = @(t,x1,Vx1,y1,Vy1,x2,Vx2,y2,Vy2) Vx2;
fVy2 = @(t,x1,Vx1,y1,Vy1,x2,Vx2,y2,Vy2) Vy2;

for i = 1:n

t(i+1)= t(i)+H;

k11 = H*fVx1(t(i), x1(i), Vx1(i), y1(i), Vy1(i), x2(i), Vx2(i), y2(i), Vy2(i));
k12 = H*fFx1(t(i), x1(i), Vx1(i), y1(i), Vy1(i), x2(i), Vx2(i), y2(i), Vy2(i));
k13 = H*fVy1(t(i), x1(i), Vx1(i), y1(i), Vy1(i), x2(i), Vx2(i), y2(i), Vy2(i));
k14 = H*fFy1(t(i), x1(i), Vx1(i), y1(i), Vy1(i), x2(i), Vx2(i), y2(i), Vy2(i));
k15 = H*fVx2(t(i), x1(i), Vx1(i), y1(i), Vy1(i), x2(i), Vx2(i), y2(i), Vy2(i));
k16 = H*fFx2(t(i), x1(i), Vx1(i), y1(i), Vy1(i), x2(i), Vx2(i), y2(i), Vy2(i));
k17 = H*fVy2(t(i), x1(i), Vx1(i), y1(i), Vy1(i), x2(i), Vx2(i), y2(i), Vy2(i));
k18 = H*fFy2(t(i), x1(i), Vx1(i), y1(i), Vy1(i), x2(i), Vx2(i), y2(i), Vy2(i));

k21 = H*fVx1(t(i)+1/2*H, x1(i)+1/2*k11, Vx1(i)+1/2*k12, y1(i)+1/2*k13, Vy1(i)+1/2*k14, x2(i)+1/2*k15, Vx2(i)+1/2*k16, y2(i)+1/2*k17, Vy2(i)+1/2*k18);
k22 = H*fFx1(t(i)+1/2*H, x1(i)+1/2*k11, Vx1(i)+1/2*k12, y1(i)+1/2*k13, Vy1(i)+1/2*k14, x2(i)+1/2*k15, Vx2(i)+1/2*k16, y2(i)+1/2*k17, Vy2(i)+1/2*k18);
k23 = H*fVy1(t(i)+1/2*H, x1(i)+1/2*k11, Vx1(i)+1/2*k12, y1(i)+1/2*k13, Vy1(i)+1/2*k14, x2(i)+1/2*k15, Vx2(i)+1/2*k16, y2(i)+1/2*k17, Vy2(i)+1/2*k18);
k24 = H*fFy1(t(i)+1/2*H, x1(i)+1/2*k11, Vx1(i)+1/2*k12, y1(i)+1/2*k13, Vy1(i)+1/2*k14, x2(i)+1/2*k15, Vx2(i)+1/2*k16, y2(i)+1/2*k17, Vy2(i)+1/2*k18);
k25 = H*fVx2(t(i)+1/2*H, x1(i)+1/2*k11, Vx1(i)+1/2*k12, y1(i)+1/2*k13, Vy1(i)+1/2*k14, x2(i)+1/2*k15, Vx2(i)+1/2*k16, y2(i)+1/2*k17, Vy2(i)+1/2*k18);
k26 = H*fFx2(t(i)+1/2*H, x1(i)+1/2*k11, Vx1(i)+1/2*k12, y1(i)+1/2*k13, Vy1(i)+1/2*k14, x2(i)+1/2*k15, Vx2(i)+1/2*k16, y2(i)+1/2*k17, Vy2(i)+1/2*k18);
k27 = H*fVy2(t(i)+1/2*H, x1(i)+1/2*k11, Vx1(i)+1/2*k12, y1(i)+1/2*k13, Vy1(i)+1/2*k14, x2(i)+1/2*k15, Vx2(i)+1/2*k16, y2(i)+1/2*k17, Vy2(i)+1/2*k18);
k28 = H*fFy2(t(i)+1/2*H, x1(i)+1/2*k11, Vx1(i)+1/2*k12, y1(i)+1/2*k13, Vy1(i)+1/2*k14, x2(i)+1/2*k15, Vx2(i)+1/2*k16, y2(i)+1/2*k17, Vy2(i)+1/2*k18);

k31 = H*fVx1(t(i)+1/2*H, x1(i)+1/2*k21, Vx1(i)+1/2*k22, y1(i)+1/2*k23, Vy1(i)+1/2*k24, x2(i)+1/2*k25, Vx2(i)+1/2*k26, y2(i)+1/2*k27, Vy2(i)+1/2*k28);
k32 = H*fFx1(t(i)+1/2*H, x1(i)+1/2*k21, Vx1(i)+1/2*k22, y1(i)+1/2*k23, Vy1(i)+1/2*k24, x2(i)+1/2*k25, Vx2(i)+1/2*k26, y2(i)+1/2*k27, Vy2(i)+1/2*k28);
k33 = H*fVy1(t(i)+1/2*H, x1(i)+1/2*k21, Vx1(i)+1/2*k22, y1(i)+1/2*k23, Vy1(i)+1/2*k24, x2(i)+1/2*k25, Vx2(i)+1/2*k26, y2(i)+1/2*k27, Vy2(i)+1/2*k28);
k34 = H*fFy1(t(i)+1/2*H, x1(i)+1/2*k21, Vx1(i)+1/2*k22, y1(i)+1/2*k23, Vy1(i)+1/2*k24, x2(i)+1/2*k25, Vx2(i)+1/2*k26, y2(i)+1/2*k27, Vy2(i)+1/2*k28);
k35 = H*fVx2(t(i)+1/2*H, x1(i)+1/2*k21, Vx1(i)+1/2*k22, y1(i)+1/2*k23, Vy1(i)+1/2*k24, x2(i)+1/2*k25, Vx2(i)+1/2*k26, y2(i)+1/2*k27, Vy2(i)+1/2*k28);
k36 = H*fFx2(t(i)+1/2*H, x1(i)+1/2*k21, Vx1(i)+1/2*k22, y1(i)+1/2*k23, Vy1(i)+1/2*k24, x2(i)+1/2*k25, Vx2(i)+1/2*k26, y2(i)+1/2*k27, Vy2(i)+1/2*k28);
k37 = H*fVy2(t(i)+1/2*H, x1(i)+1/2*k21, Vx1(i)+1/2*k22, y1(i)+1/2*k23, Vy1(i)+1/2*k24, x2(i)+1/2*k25, Vx2(i)+1/2*k26, y2(i)+1/2*k27, Vy2(i)+1/2*k28);
k38 = H*fFy2(t(i)+1/2*H, x1(i)+1/2*k21, Vx1(i)+1/2*k22, y1(i)+1/2*k23, Vy1(i)+1/2*k24, x2(i)+1/2*k25, Vx2(i)+1/2*k26, y2(i)+1/2*k27, Vy2(i)+1/2*k28);

k41 = H*fVx1(t(i)+H, x1(i)+k31, Vx1(i)+k32, y1(i)+k33, Vy1(i)+k34, x2(i)+k35, Vx2(i)+k36, y2(i)+k37, Vy2(i)+k38);
k42 = H*fFx1(t(i)+H, x1(i)+k31, Vx1(i)+k32, y1(i)+k33, Vy1(i)+k34, x2(i)+k35, Vx2(i)+k36, y2(i)+k37, Vy2(i)+k38);
k43 = H*fVy1(t(i)+H, x1(i)+k31, Vx1(i)+k32, y1(i)+k33, Vy1(i)+k34, x2(i)+k35, Vx2(i)+k36, y2(i)+k37, Vy2(i)+k38);
k44 = H*fFy1(t(i)+H, x1(i)+k31, Vx1(i)+k32, y1(i)+k33, Vy1(i)+k34, x2(i)+k35, Vx2(i)+k36, y2(i)+k37, Vy2(i)+k38);
k45 = H*fVx2(t(i)+H, x1(i)+k31, Vx1(i)+k32, y1(i)+k33, Vy1(i)+k34, x2(i)+k35, Vx2(i)+k36, y2(i)+k37, Vy2(i)+k38);
k46 = H*fFx2(t(i)+H, x1(i)+k31, Vx1(i)+k32, y1(i)+k33, Vy1(i)+k34, x2(i)+k35, Vx2(i)+k36, y2(i)+k37, Vy2(i)+k38);
k47 = H*fVy2(t(i)+H, x1(i)+k31, Vx1(i)+k32, y1(i)+k33, Vy1(i)+k34, x2(i)+k35, Vx2(i)+k36, y2(i)+k37, Vy2(i)+k38);
k48 = H*fFy2(t(i)+H, x1(i)+k31, Vx1(i)+k32, y1(i)+k33, Vy1(i)+k34, x2(i)+k35, Vx2(i)+k36, y2(i)+k37, Vy2(i)+k38);

x1(i+1) = x1(i)+1/6*(k11+2*k21+2*k31+k41);
y1(i+1) = y1(i)+1/6*(k13+2*k23+2*k33+k43);
Vx1(i+1) = Vx1(i)+1/6*(k12+2*k22+2*k32+k42);
Vy1(i+1) = Vy1(i)+1/6*(k14+2*k24+2*k34+k44);

x2(i+1) = x2(i)+1/6*(k15+2*k25+2*k35+k45);
y2(i+1) = y2(i)+1/6*(k17+2*k27+2*k37+k47);
Vx2(i+1) = Vx2(i)+1/6*(k16+2*k26+2*k36+k46);
Vy2(i+1) = Vy2(i)+1/6*(k18+2*k28+2*k38+k48);

end

figure

subplot(2,1,1);
plot(x1,y1,'g','linewidth',3);
xlabel('x1')
ylabel('y1')
grid on 

hold on
subplot(2,1,2);
plot(x2,y2,'r')
xlabel('x2')
ylabel('y2')
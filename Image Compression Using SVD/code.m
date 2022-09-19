clc
clear
A =flipud(double(imread('MyImage.jpg')));
pcolor(A(:,:,2)); shading interp; colormap('gray'); axis equal 
A =  mat2gray(A);  
A = rgb2gray(A); 
[U,S,V] = svd(A,'econ');
SV=diag(S);
semilogy(SV)
num=ceil(0.3*length(SV));
S2 = S*diag([ones(1,num),zeros(1,size(S,2)-num)]);

M=U*S2*V';
pcolor(M); shading interp; colormap('gray'); axis equal 

n1=ceil(0.01*length(SV));
S3 = S*diag([ones(1,n1),zeros(1,size(S,2)-n1)]);
M2=U*S3*V';
pcolor(M2); shading interp; colormap('gray'); axis equal

n2=ceil(0.05*length(SV));
S4 = S*diag([ones(1,n2),zeros(1,size(S,2)-n2)]);
M3=U*S4*V';
pcolor(M3); shading interp; colormap('gray'); axis equal

n3=ceil(0.1*length(SV));
S5 = S*diag([ones(1,n3),zeros(1,size(S,2)-n3)]);
M4=U*S5*V';
pcolor(M4); shading interp; colormap('gray'); axis equal

n4=ceil(0.15*length(SV));
S6 = S*diag([ones(1,n4),zeros(1,size(S,2)-n4)]);
M5=U*S6*V';
pcolor(M5); shading interp; colormap('gray'); axis equal

n5=ceil(0.2*length(SV));
S7 = S*diag([ones(1,n5),zeros(1,size(S,2)-n5)]);
M6=U*S7*V';
pcolor(M6); shading interp; colormap('gray'); axis equal

n6=ceil(0.25*length(SV));
S8 = S*diag([ones(1,n6),zeros(1,size(S,2)-n6)]);
M7=U*S8*V';
pcolor(M7); shading interp; colormap('gray'); axis equal

imwrite(flip(rescale(M4)),'Compressed.png')
imwrite(flip(rescale(A)),'Main.png')

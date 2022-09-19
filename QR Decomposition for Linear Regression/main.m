clc
clear
rng(1);
x1=normrnd(0,1,10000,1);
x2=normrnd(0,1,10000,1);
x3=normrnd(0,1,10000,1);
train1=x1(1:8000);
train2=x2(1:8000);
train3=x3(1:8000);
ytrain=2*train1.^2+3*train2-5*train3;
A=[train1.^2 train2 train3];
theta=inv(A'*A)*A'*ytrain;
test1 = sort(x1(8001:10000));
test2 = sort(x2(8001:10000));
test3 = sort(x3(8001:10000));
ytest = 2*test1.^2 + 3*test2 + -5*test3;
yhat = theta(1)*test1.^2 + theta(2)*test2 + theta(3)*test3;
figure(1)
plot(ytest,'blue','LineWidth',2);
hold on
plot(yhat,'b--o','MarkerFaceColor','red','MarkerSize',0.5,...
'MarkerEdgeColor','red','LineWidth',2,'MarkerIndices',...
1:100:length(yhat),'color','red');
xlabel('Sample')
ylabel('Function Value')
legend('actual','predicted')
hold off


[Q,R]=myQR(A);
qy=Q'*ytrain;
zz = upperTri(R,qy,length(qy));
yhat2 = zz(1)*test1.^2 + zz(2)*test2 + zz(3)*test3;
figure(2)
plot(ytest,'blue','LineWidth',2);
hold on
plot(yhat2,'b--o','MarkerFaceColor','red','MarkerSize',0.5,...
'MarkerEdgeColor','red','LineWidth',2,'MarkerIndices',...
1:100:length(yhat2),'color','red');
xlabel('Sample')
ylabel('Function Value')
legend('actual','predicted')
title('QR decomposition method')
hold off

% xprep=train1;
% xprep2=train2-dot(train2,xprep)/(norm(xprep)^2);
% xprep3=train3-dot(train3,xprep)/(norm(xprep)^2)-dot(train3,xprep2)/(norm(xprep2)^2);
% ytrainprep=2*xprep+3*xprep2-4*xprep3;
% A=[xprep xprep2 xprep3];
% theta_new=inv(A'*A)*A'*ytrainprep;
% yhat_new = theta_new(1)*test1 + theta_new(2)*test2 + theta_new(3)*test3;
% figure(3)
% plot(ytest,'blue');
% hold on
% plot(yhat_new,'red');
% hold off
% 
% figure(3)
% plot(ytest-yhat);
% 
% figure(4)
% plot(ytest-yhat_new);
function [Q, R] = myQR(A)
  [m, n] = size(A);
  u = zeros(m,n);
  Q = zeros(m,n);
  R = zeros(n,n);
 for i = 1:n
      temp = 0;
      for j = 1:i-1
          temp = temp + (dot(A(:,i),u(:,j)))/(dot(u(:,j),u(:,j))) * u(:,j);
      end
      u(:,i) = A(:,i) - temp;
      Q(:,i) = u(:,i)/norm(u(:,i));
      for k = 1:i
          R(k,i) = dot(A(:,i),Q(:,k));
      end
 end 
end

function x = upperTri(A,b,N)
    x = zeros(N,1);
    for i = N:-1:1
        temp=0;
        for l = i+1:N
           temp = temp + A(i,l) * x(l,1);          
        end
        x(i) = (b(i) - temp)/A(i,i);
    end
end


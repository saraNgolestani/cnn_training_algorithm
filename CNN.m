clc
clear all

load ZigZagmove1mmps-3x6magnetHorizontal-Calibrated-Height10mmFromSensorBoard.mat

for i=1:76866
    for j=1:30
        Amplitude(i,j)=sqrt(sen1to30(i,3*(j)-2)^2+sen1to30(i,3*(j)-1)^2+sen1to30(i,3*(j))^2);
    end
end
ConvolutionBox = [0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];

for i = 1:2
    for j = 1:2
        ConvolutionBox = Amplitude(i:i+2,j:j+2);
        Con1 = ConvolutionBox(i:i+1,j:j+1);
        Con2 = ConvolutionBox(i+1:i+2,j:j+1);
        Con3 = ConvolutionBox(i:i+1,j+1:j+2);
        Con4 = ConvolutionBox(i+1:i+2,j+1:j+2);
        
        
    end  
end



 X=(Amplitude');


T=[magnetpos(:,1:2)'];

net.output.processFcns = {'mapminmax'};
net = layrecnet(1,[10 7 3]);%layrecnet(5,2);%feedforwardnet([7 3]);%feedforwardnet([10 6]);%[15 10 7]
net.trainFcn = 'trainbr';%trainscg trainrp trainoss
net.trainParam.lr=0.1;%0.2
net.trainParam.max_fail=60;%20
net.trainParam.mc=0.01;%0.05
net.trainParam.epochs=10000;%2000
net = train(net,X,T,'useGPU','yes');

clear X T Amplitude magnetpos

load Curvemove1mmps-3x6magnetHorizontal-Calibrated-Height10mmFromSensorBoard.mat

for i=1:9566
    for j=1:30
        Amplitude(i,j)=sqrt(sen1to30(i,3*(j)-2)^2+sen1to30(i,3*(j)-1)^2+sen1to30(i,3*(j))^2);
    end
end

 X=(Amplitude');

T=[magnetpos(:,1:2)'];

y =net(X);
subplot(4,2,2)
plot(y(1,:))
hold on
plot(T(1,:))
legend('Estimated','Real')
xlabel('Samples')
ylabel('Position (X axis)')
title('FNN Neural Network')

subplot(4,2,4)
plot(-y(2,:))
hold on
plot(T(2,:))

legend('Estimated','Real')
xlabel('Samples')
ylabel('Position (Y axis)')

subplot(4,2,6)
plot(y(1,:),-y(2,:))
hold on
plot(T(1,:),T(2,:))
legend('Estimated','Real')
xlabel('Position (X axis)')
ylabel('Position (Y axis)')

subplot(4,2,8)
plot(sum([(y(1,:)-T(1,:)).^2;(-y(2,:)-T(2,:)).^2]))
xlabel('Samples')
ylabel('Squered Error')
title(['Sumation of Squered Error is ',num2str(sum(sum([(y(1,:)-T(1,:)).^2;(-y(2,:)-T(2,:)).^2])))])

error2=sum(sum([(y(1,:)-T(1,:)).^2;(-y(2,:)-T(2,:)).^2]))



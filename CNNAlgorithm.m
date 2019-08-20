load ZigZagmove1mmps-3x6magnetHorizontal-Calibrated-Height10mmFromSensorBoard.mat

for i=1:76866
    for j=1:30
        Amplitude(i,j)=sqrt(sen1to30(i,3*(j)-2)^2+sen1to30(i,3*(j)-1)^2+sen1to30(i,3*(j))^2);
    end
    
end
for i = 1:76000
 
    Amplitude(i,:) =abs(log(Amplitude(i,:)));
    Max = max(abs(Amplitude(i,:)));
    Min = min(abs(Amplitude(i,:)));
end
First = (min(Min));
Forth = (max(Max));
Second  = abs(2*(Forth)/4);
Third = (abs(3*(Forth)/4));


ConvolutionBox = [0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];


for i =1:10
    for j =1:10
        ConvolutionBox = Amplitude(i:i+2,j:j+2);
   
        Con1(1:2,1:2) = ConvolutionBox(1:2,1:2);
        Con2(1:2,1:2) = ConvolutionBox(2:3,1:2);
        Con3(1:2,1:2) = ConvolutionBox(1:2,2:3);
        Con4(1:2,1:2) = ConvolutionBox(2:3,2:3);
        
        
         sum1 = sum(sum(Con1))/i;
         sum2 = sum(sum(Con2))/i;
         sum3 = sum(sum(Con3))/i;
         sum4 = sum(sum(Con4))/i;
%         sum1 = log(sum(sum(Con1)))/4;
%         sum2 = log(sum(sum(Con2)))/4;
%         sum3 = log(sum(sum(Con3)))/4;
%         sum4 = log(sum(sum(Con4)))/4;
        if sum1 > Forth 
            ConB(i,j) = 1;
        else if Forth > sum1 >Third
            ConB(i,j) = 0.75;
            else if Third > sum1 > Second
              ConB(i,j) = 0.5;
                else 
                  ConB(i,j) = 0;

                end
            end
        end
        if sum2 > Forth 
            ConB(i+1,j) = 1;
        else if Forth > sum2 >Third
            ConB(i+1,j) = 0.75;
            else if Third > sum2 > Second
              ConB(i+1,j) = 0.5;
                else 
                  ConB(i+1,j) = 0;

                end
            end
        end
        if sum3 > Forth 
            ConB(i,j+1) = 1;
        else if Forth > sum3 >Third
            ConB(i,j+1) = 0.75;
            else if Third > sum3 > Second
              ConB(i,j+1) = 0.5;
                else 
                  ConB(i+1,j+1) = 0;

                end
            end
        end
        if sum4 > Forth 
            ConB(i+1,j+1) = 1;
        else if Forth > sum4 >Third
            ConB(i+1,j+1) = 0.75;
            else if Third > sum4 > Second
              ConB(i+1,j+1) = 0.5;
                else 
                  ConB(i+1,j+1) = 0;

                end
            end
        end
        
   
    end  
end

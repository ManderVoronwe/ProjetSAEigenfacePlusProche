function Recognized_index = Recognition(TestImage, m, A, Eigenfaces, Threshold, Nimages)
%This function compares two faces by projecting the image into the face space, and then measures the Euclidean distance between them.
%             TestImage                 - Path of the picture to be detected
%
%                m                      -(M * Nx1)Training database average
%                                       - " EigenfaceCore"Function output.
%
%                Eigenfaces            - ％Characteristic faces-(M * Nx(P-1))Eigenvectors
%                                      - Percentage of covariance matrix trained
%                                      -" EigenfaceCore"Function output.
%
%                A                      -(M * NxP)Center image matrix
%                                       - " EigenfaceCore"The output of the function.
%%%%%%%%%%%%%%%%%%%%%%%%Project the centered image vector into face space
%All the centered images are multiplied by the projection to the basis of the eigenfaces of the face space. 
%The projection vector of each face will be its corresponding eigenvector.
ProjectedImages = [];
    Train_Number = size(Eigenfaces,2);
    for i = 1 : Train_Number
        temp = Eigenfaces'*A(:,i);%Project the center image into the face space
        ProjectedImages = [ProjectedImages temp]; 
    end

%%%%%%%%%%%%%%%%%%%%%%%% Extract from test image PCA function
    InputImage = imread(TestImage);
    temp = InputImage(:,:,1);

    [irow,icol] = size(temp);
    InImage = reshape(temp',irow*icol,1);
    Difference = double(InImage)-m; %Center test image percentage
    ProjectedTestImage = Eigenfaces'*Difference; % Test image eigenvector

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calculate the Euclidean distance percentage between the Euclidean distance projection test image and the projection calculate the percentage of all centered training images. 
%The person who tested the picture should think that there is a minimum distance training database with the corresponding image in the picture.

    Euc_dist = [];
    for i = 1 : Train_Number
        q = ProjectedImages(:,i)/1e7;
        temp = ( norm( ProjectedTestImage/1e7 - q ) )^2;
        Euc_dist = [Euc_dist temp];
    end
    
%     e = min(Euc_dist)
%     [minValue,Recognized_index] = min(Euc_dist);
%     
%  if minValue > Threshold
%      Recognized_index = 0;
%  end
%  OutputName = strcat(int2str(Recognized_index),'.pgm');

% Find Nimages minimum distances
[xs, index] = mink(Euc_dist,Nimages);
Recognized_index = [];
for i = 1:length(index)
    if xs(i) <= Threshold
        Recognized_index = [Recognized_index index(i)];
    end
end
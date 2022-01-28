% Clear variables
clear all
clc
close all

% Training directory
TrainDatabasePath = uigetdir('./att_faces', 'Select training database path' );

% Choose a file to test
[filename, pathname] = uigetfile('*.pgm', 'Pick a PGM file');
File2Test = strcat(pathname,filename);
im = imread(File2Test);

[T,list] = CreateDatabase(TrainDatabasePath); %Generate 2D matrix based on training picture path

[m, A, Eigenfaces] = EigenfaceCore(T); %Generating characteristic quantity
Threshold = 500;
Nimages = 3;
OutputIndex = Recognition(File2Test, m, A, Eigenfaces, Threshold, Nimages);
% Select the picture you want to recognize
% SelectedImage = strcat(TrainDatabasePath,'\',list{OutputIndex});
% Select the picture you want to recognize
if ~isempty(OutputIndex)
    
    % display picture
    figure
    imshow(im)                   %Display the original picture of the picture to be tested

    title(strcat('Original picture: ', filename));  
    figure,
    % im1=rgb2gray(im);
    imshow(im);                 %Display the gray scale of the picture to be tested
    title(strcat('The gray scale of the picture: ', filename));
    
    % Output
    for i = 1:length(OutputIndex)
        SelectedImage = strcat(TrainDatabasePath,'\',list{OutputIndex(i)});
        SelectedImage = imread(SelectedImage);
        figure,imshow(SelectedImage);%Show matching pictures
        title(strcat('Equivalent Image: ', list{OutputIndex(i)}));
        str = strcat('Matched image is :  ',list{OutputIndex(i)});
        disp(str)
    end

else
    str = strcat('Image not found');
    disp(str)
end

% SelectedImage = imread(SelectedImage);
% % display picture
% imshow(im)                   %Display the original picture of the picture to be tested
% 
% title(strcat('Original picture: ', filename));  
% figure,
% % im1=rgb2gray(im);
% imshow(im);                 %Display the gray scale of the picture to be tested
% title(strcat('the gray scale of the picture: ', filename));  
% figure,imshow(SelectedImage);%Show matching pictures
% title(strcat('Equivalent Image:', list{OutputIndex}));
% 
% str = strcat('Matched image is :  ',list{OutputIndex});
% disp(str)


% TestDatabasePath = uigetdir('./att_faces', 'Select test database path');
% 
% prompt = {'Select the picture number to be tested (1~10)Between'};
% %Select the picture to be matched, and enter the known library to search for matching
% dlg_title = 'Input of PCA-Based Face Recognition System';
% num_lines= 1;
% def = {'1'};
% 
% TestImage  = inputdlg(prompt,dlg_title,num_lines,def);
% TestImage = strcat(TestDatabasePath,'\',char(TestImage),'.pgm');
%         %Each cycle TestImage All that remains is TestDatabasePathTest\TestImage.jpg
% im = imread(TestImage);
%         %Returned array A Contains image data.
%         %If the file contains a gray image, A yes M*N If the file contains a true color image, A yes M*N*3 The array.
% 
% % Create face database
% T = CreateDatabase(TrainDatabasePath); %Generate 2D matrix based on training picture path
% [m, A, Eigenfaces] = EigenfaceCore(T); %Generating characteristic quantity
% OutputName = Recognition(TestImage, m, A, Eigenfaces);
% % Select the picture you want to recognize
% SelectedImage = strcat(TrainDatabasePath,'\',OutputName);
% SelectedImage = imread(SelectedImage);
% % display picture
% imshow(im)                   %Display the original picture of the picture to be tested
% title('Test Image');  
% figure,
% % im1=rgb2gray(im);
% imshow(im);                 %Display the gray scale of the picture to be tested
% title('Test Image Gray');
% figure,imshow(SelectedImage);%Show matching pictures
% title('Equivalent Image');
% 
% str = strcat('Matched image is :  ',OutputName);
% disp(str)
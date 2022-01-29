function [T,list] = CreateDatabase(TrainDatabasePath)
%This function reshapes all 2 of the training database D The image is placed in a one-dimensional column vector. 
%Then, put these one-dimensional column vectors in one row to construct 2 D Matrix " T". 

%One 2 D Matrix, including all 1 D Image vector.
%Assume that all of the P Image MxN Same size. 
%So the length column vector of one dimension is MN，" T"will be MNxP 2D Matrix.

%%%%%%%%%%%%%%%%%%%%%%%% file management
TrainFiles = dir(TrainDatabasePath);
Train_Number = 0;

%%%%%%%%%%%%%%%%%%%%%%%% One dimensional image vector to construct two dimensional matrix
T = [];
list = {};
Nfile = 0;
for i = 1:size(TrainFiles,1)
    
    if contains(TrainFiles(i).name,'.pgm')
        Nfile = Nfile + 1;
        str = strcat(TrainDatabasePath,'\',TrainFiles(i).name);
        list{Nfile} = TrainFiles(i).name;
        img = imread(str);
        [irow ,icol] = size(img);
   
        temp = reshape(img',irow*icol,1);   % Will 2 D Image remodel to 1 D Image vector
        T = [T temp]; % Update 2 D matrix'T'           
    end
    
end
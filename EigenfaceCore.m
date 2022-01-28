function [m, A, Eigenfaces] = EigenfaceCore(T)
%Using principal component analysis( PCA)It is determined that the features between the face images can be distinguished at most.
%%This function obtains a two-dimensional matrix, which contains all the training image vectors, and returns three outputs extracted from the training database.
%
%      T             - %One 2 D Matrix, including all 1 D Image vector.
%                    - Assume that all of the P Image MxN Same size. 
%                    - So the length column vector of one dimension is MN，" T"will be MNxP 2D Matrix.
% 
%      m             - (M*Nx1) Training database average
%      Eigenfaces    - (M*Nx(P-1)) Characteristic vector of covariance matrix in training database
%      A             - (M*NxP) Center image vector matrix
                
 
%%%%%%%%%%%%%%%%%%%%%%%% Calculate average image
m = mean(T,2); %Calculate average face image m =(1 / P)* sum(Tj's)(j = 1: P)
Train_Number = size(T,2);

%%%%%%%%%%%%%%%%%%%%%%%% Calculate the deviation between each image and the average image
A = [];  
for i = 1 : Train_Number
    temp = double(T(:,i)) - m; % Computing training set Ai = Ti-m Difference image for each image in
    A = [A temp]; % Merge all centered images
end

%%%%%%%%%%%%%%%%%%%%%%%% Snapshot method of feature face method
%From the theory of linear algebra, we know that for a PxQ Matrix, the maximum number of nonzero eigenvalues that the matrix can have is min(P-1，Q-1).  
%Due to the number of training images( P)Usually less than the number of pixels( M * N)，So the lowest eigenvalue that can be found is equal to P-1. 
%So we can calculate A'* A(One PxP Matrix) instead of A * A'(One M * NxM * N Matrix). 
%Obviously, A * A'Size ratio A'* A Much bigger. Therefore, the dimension will be reduced.

L = A'*A; % L It's a covariance matrix C = A * A'Substitution.
[V,D] = eig(L); %D The diagonal element of is L = A'* A and C = A * A'The characteristic value of.

%%%%%%%%%%%%%%%%%%%%%%%% Sorting and eliminating eigenvalues
%matrix L All eigenvalues of are sorted, less than the specified threshold, and are eliminated.
%Therefore, the number of non-zero eigenvectors may be less than( P-1). 
L_eig_vec = [];
for i = 1 : size(V,2) 
    if( D(i,i)>1 )
        L_eig_vec = [L_eig_vec V(:,i)];
    end
end

%%%%%%%%%%%%%%%%%%%%%%%% Calculate covariance matrix'C'Eigenvector of
%Can from L Recovery covariance matrix in eigenvector of C The percentage of the feature vector of (the "feature face").
Eigenfaces = A * L_eig_vec; % A: Centered image vector
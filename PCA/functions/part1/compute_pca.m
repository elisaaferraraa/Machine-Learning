function [Mu, Covariance, EigenVectors, EigenValues] = compute_pca(X)
%COMPUTE_PCA Step-by-step implementation of Principal Component Analysis
%   In this function, the student should implement the Principal Component 
%   Algorithm
%
%   input -----------------------------------------------------------------
%   
%       o X      : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%
%   output ----------------------------------------------------------------
%
%       o Mu              : (N x 1), Mean Vector of Dataset
%       o C               : (N x N), Covariance matrix of the dataset
%       o EigenVectors    : (N x N), Eigenvectors of Covariance Matrix.
%       o EigenValues     : (N x 1), Eigenvalues of Covariance Matrix


%1) Demean the data
Mu=mean(X,2);
X=X-Mu;

%2)Covariance Matrix Computation
M=size(X,2); %contains the number of samples
Covariance=1/(M-1)*X*(X');

%3) Eigenvalue decomposition

[V, D] = eig(Covariance);
%V's columns are eigenvectors
%D is a diagonal matrix in which the diagonal is composed of the eigenvalues
V*D*V' - Covariance < 1e-4;           

%Sorting eigenvalues and eigenvectors:
[EigenValues,idx]=sort(diag(D),'descend');
EigenVectors=V(:,idx);

end


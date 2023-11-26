function [ Sigma ] = compute_covariance( X, X_bar, type )
%MY_COVARIANCE computes the covariance matrix of X given a covariance type.
%
% Inputs -----------------------------------------------------------------
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                          each column corresponds to a datapoint
%       o X_bar : (N x 1), an Nx1 matrix corresponding to mean of data X
%       o type  : string , type={'full', 'diag', 'iso'} of Covariance matrix
%
% Outputs ----------------------------------------------------------------
%       o Sigma : (N x N), an NxN matrix representing the covariance matrix of the 
%                          Gaussian function
%%

[N,M] = size(X);

% Centering the data
X_centered = X - repmat(X_bar, 1, M);

switch type 
    case 'full'
        Sigma = 1/(M-1) * X_centered * X_centered';
    case 'diag'
        tempSigma = 1/(M-1) * X_centered * X_centered';
        Sigma = diag(diag(tempSigma));
    case 'iso'
        sigma = 1/(N*M) * sum(vecnorm(X_centered).^2);
        Sigma = sigma * eye(N);
end





end


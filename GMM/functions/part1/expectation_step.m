function [Pk_x] = expectation_step(X, Priors, Mu, Sigma, params)
%EXPECTATION_STEP Computes the expection step of the EM algorihtm
% input------------------------------------------------------------------
%       o X         : (N x M), a data set with M samples each being of 
%                           dimension N, each column corresponds to a datapoint.
%       o Priors    : (1 x K), the set of updated priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu        : (N x K), an NxK matrix corresponding to the CURRENT centroids mu^(0) = {mu^1,...mu^K}
%       o Sigma     : (N x N x K), an NxNxK matrix corresponding to the CURRENT Covariance matrices   
% 					Sigma^(0) = {Sigma^1,...,Sigma^K} 
%       o params    : The hyperparameters structure that contains k, the number of Gaussians
% output----------------------------------------------------------------
%       o Pk_x      : (K, M) a KxM matrix containing the posterior probabilty that a k Gaussian is responsible
%                     for generating a point m in the dataset 
%%
[N,M] = size(X);
K= params.k;
prob=zeros(K,M);

% NOT OPTIMIZED VERSION----------------------------------------------
% Pk_x=zeros(K,M);
% for k = 1:K
%      prob(k,:) = gaussPDF(X, Mu(:,k), Sigma(:,:,k));
% end
% 
% for i =1:M
%     for k =1:K
%         Pk_x(k,i)=Priors(1,k)*prob(k,i)/(Priors*prob(:,i));
%     end
% end

% OPTIMIZED VERSION-----------------------------------------------
for k = 1:K
    diff = bsxfun(@minus, X, Mu(:,k));
    invSigma = inv(Sigma(:,:,k));
    temp = sum((diff' * invSigma) .* diff', 2);
    coeff = (2 * pi) ^ (-N / 2) * sqrt(det(Sigma(:,:,k)));
    prob(k, :) = exp(-0.5 * temp') / coeff;
end

weightedProb = bsxfun(@times, prob, Priors');
Pk_x = bsxfun(@rdivide, weightedProb, sum(weightedProb, 1));

end


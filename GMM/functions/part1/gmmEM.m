function [  Priors, Mu, Sigma, iter ] = gmmEM(X, params)
%MY_GMMEM Computes maximum likelihood estimate of the parameters for the 
% given GMM using the EM algorithm and initial parameters
%   input------------------------------------------------------------------
%       o X         : (N x M), a data set with M samples each being of 
%                           dimension N, each column corresponds to a datapoint.
%       o params : Structure containing the paramaters of the algorithm:
%           * cov_type: Type of the covariance matric among 'full', 'iso',
%           'diag'
%           * k: Number of gaussians
%           * max_iter: Max number of iterations

%   output ----------------------------------------------------------------
%       o Priors    : (1 x K), the set of FINAL priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu        : (N x K), an NxK matrix corresponding to the FINAL centroids 
%                           mu = {mu^1,...mu^K}
%       o Sigma     : (N x N x K), an NxNxK matrix corresponding to the
%                   FINAL Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%       o iter      : (1 x 1) number of iterations it took to converge

iter = 0;
threshold= 1e-5;
[Priors, Mu, Sigma ] = gmmInit(X, params);
logl = 0;
while iter < params.max_iter
   Pk_x = expectation_step(X, Priors, Mu, Sigma, params);
   [Priors,Mu,Sigma] = maximization_step(X, Pk_x, params);
   logl_new = gmmLogLik(X, Priors, Mu, Sigma);
   if  norm(logl_new-logl) <= threshold
       break
   end
   logl= logl_new;
   iter = iter+1;

end


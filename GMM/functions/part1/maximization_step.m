function [Priors,Mu,Sigma] = maximization_step(X, Pk_x, params)
% %MAXIMISATION_STEP Compute the maximization step of the EM algorithm
% %   input------------------------------------------------------------------
% %       o X         : (N x M), a data set with M samples each being of 
% %       o Pk_x      : (K, M) a KxM matrix containing the posterior probabilty
% %                     that a k Gaussian is responsible for generating a point
% %                     m in the dataset, output of the expectation step
% %       o params    : The hyperparameters structure that contains k, the number of Gaussians
% %                     and cov_type the coviariance type
% %   output ----------------------------------------------------------------
% %       o Priors    : (1 x K), the set of updated priors (or mixing weights) for each
% %                           k-th Gaussian component
% %       o Mu        : (N x K), an NxK matrix corresponding to the updated centroids 
% %                           mu = {mu^1,...mu^K}
% %       o Sigma     : (N x N x K), an NxNxK matrix corresponding to the
% %                   updated Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%------------------------------------------------------------------------------------
[N,M]= size(X);
K = params.k;   % Number of Gaussian components                    
Priors=zeros(1,K);
Mu=zeros(N,K);
Sigma=zeros(N,N,K);

epsilon=1e-5;
for k= 1:K
    Priors(1,k)=sum(Pk_x(k,:))/M;
    Mu(:,k)=(X*Pk_x(k,:)')/(sum(Pk_x(k,:)));
    
    if strcmp(params.cov_type,'full') || strcmp(params.cov_type,'diag')
        for j=1:size(X,2)
            Sigma(:,:,k)=Sigma(:,:,k)+Pk_x(k,j)*(X(:,j)-Mu(:,k))*(X(:,j)-Mu(:,k))'/sum(Pk_x(k,:));
        end
    end
    if strcmp(params.cov_type,'iso')
        for j=1:size(X,2)
            Sigma(:,:,k)=Sigma(:,:,k)+Pk_x(k,j)*norm((X(:,j)-Mu(:,k)))^2/(size(X,1)*sum(Pk_x(k,:)));
        end
    end

    if strcmp(params.cov_type,'diag') || strcmp(params.cov_type,'iso')
       Sigma(:,:,k)=diag(diag(Sigma(:,:,k))); 
    end
    
    Sigma(:,:,k) = Sigma(:,:,k) + epsilon * eye(N);

end


end

function [ y_est ] =  knn(X_train,  y_train, X_test, params)
%MY_KNN Implementation of the k-nearest neighbor algorithm
%   for classification.
%
%   input -----------------------------------------------------------------
%   
%       o X_train  : (N x M_train), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_train  : (1 x M_train), a vector with labels y \in {1,2} corresponding to X_train.
%       o X_test   : (N x M_test), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o params : struct array containing the parameters of the KNN (k, d_type)
%
%   output ----------------------------------------------------------------
%
%       o y_est   : (1 x M_test), a vector with estimated labels y \in {1,2} 
%                   corresponding to X_test.
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~,M_train]= size(X_train);
[~,M_test]=size(X_test);
y_est=zeros(1,M_test);

for i = 1:M_test
    %------------------Compute Pairwise Distances--------------------------
    dist=zeros(1,M_train);
    for j=1: M_train
        dist(j)=compute_distance(X_test(:, i), X_train(:, j), params);
    end
    
    
    %------------------Extract k-Nearest Neighbors-------------------------    
    [~, sorted_idx]=sort(dist,'ascend');
    yknn_temp= y_train(sorted_idx);
    yknn= yknn_temp(1:params.k);

    %-----------------------Majority Vote-------------------------------------

    % C=unique(yknn);
    % elem_per_class=zeros(1,length(C));
    % 
    % for j = 1 : length(C)
    %     class=C(j);
    %     elem_per_class = sum(yknn==class);
    % end
    % 
    % 
    % [~,label]= max(elem_per_class);
    % y_est(i) = C(label);
    y_est(i) = mode(yknn);

end
end
function [acc_curve] = knn_eval( X_train, y_train, X_test, y_test, params)
%KNN_EVAL Implementation of kNN evaluation.
%
%   input -----------------------------------------------------------------
%   
%       o X_train   : (N x M_train), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_train   : (1 x M_train), a vector with labels y \in {1,2} corresponding to X_train.
%       o X_test    : (N x M_test), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_test    : (1 x M_test), a vector with labels y \in {1,2} corresponding to X_test.
%       o params : struct array containing the parameters of the KNN (k,
%                  d_type). Also include the k_range for the
%                  evaluation
%
%   output ----------------------------------------------------------------
%       o acc_curve : (1 X K), Accuracy for each value of K
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Note: When selecting the value of k for the k-nearest neighbors (KNN) algorithm, there are some important considerations:
% 
    % Odd vs. Even k:
% Choose an odd value for k when dealing with an even-class problem. This helps avoid ties during the majority voting step.
% Conversely, use an even number for k when you have an odd-class problem.
    % Choosing the Right k:
% Selecting the appropriate k is a critical step in the KNN algorithm.
% If k is too small (e.g., k → 1), the result may be sensitive to noise or outliers in the data.
% If k is too large (e.g., k → M, where M is the total number of training samples), it can lead to increased computation time,
% as KNN has a computational complexity of O(Mk). Moreover, using a large k contradicts the fundamental idea of KNN, which is 
% that points closer together are more likely to belong to the same class.
% Intuitively, you can consider a reasonable range for k as k ≈ κ * M / C, where 0 < κ ≤ 1, and C is the number of classes.
% This ratio is based on the number of data points (M) and the number of classes (C). It's not a strict rule, but it provides 
% a starting point for selecting k. You can also make an informed decision by considering factors like the distribution of data
% points, class balance, and other characteristics of your dataset.

acc_curve=zeros(1,length(params.k_range));

for i = 1: length(params.k_range)
    params.k=params.k_range(i);
    [ y_est ] =  knn(X_train,  y_train, X_test, params);
    acc_curve(i) =  accuracy(y_test, y_est);
end




end


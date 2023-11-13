function [ TP_rate, FP_rate ] = knn_ROC( X_train, y_train, X_test, y_test,  params )
%KNN_ROC Implementation of ROC curve for kNN algorithm.
%
%   input -----------------------------------------------------------------
%
%       o X_train  : (N x M_train), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_train  : (1 x M_train), a vector with labels y \in {1,2} corresponding to X_train.
%       o X_test   : (N x M_test), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_test   : (1 x M_test), a vector with labels y \in {1,2} corresponding to X_test.
%       o params : struct array containing the parameters of the KNN (k,
%                  d_type and k_range)
%
%   output ----------------------------------------------------------------

%       o TP_rate  : (1 x K), True Positive Rate computed for each value of k.
%       o FP_rate  : (1 x K), False Positive Rate computed for each value of k.
%        
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[ y_est ] =  knn(X_train,  y_train, X_test, params);

classes = unique(y_test);
positive= classes(1);
negative= classes(2);
K=length(params.k_range);
TP_rate=zeros(1,K);
FP_rate=zeros(1,K);
for i = 1:K
    params.k=params.k_range(i);
    [ y_est ] =  knn(X_train,  y_train, X_test, params);
  
    TP= sum((y_est==positive )&(y_test==positive));
    TN= sum((y_est==negative )&(y_test==negative));
    FP= sum((y_est==positive )&(y_test==negative));
    FN= sum((y_est==negative )&(y_test==positive));

    TP_rate(i)=TP/(TP+FN);
    FP_rate(i)=FP/(FP+TN);
end






end
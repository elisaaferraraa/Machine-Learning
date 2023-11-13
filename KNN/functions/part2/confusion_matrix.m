function [C] =  confusion_matrix(y_test, y_est)
%CONFUSION_MATRIX Implementation of confusion matrix 
%   for classification results.
%   input -----------------------------------------------------------------
%
%       o y_test    : (1 x M), a vector with true labels y \in {1,2} 
%                        corresponding to X_test.
%       o y_est     : (1 x M), a vector with estimated labels y \in {1,2} 
%                        corresponding to X_test.
%
%   output ----------------------------------------------------------------
%       o C          : (2 x 2), 2x2 matrix of |TP & FN|
%                                             |FP & TN|.
%
%   where positive is encoded by the label 1 and negative is encoded by the label 2.        
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % c=length(unique(y_test));
    % C = zeros(c,c);
    % 
    % 
    % for i = 1:length(y_test)
    %     true_class = y_test(i);
    %     est_class = y_est(i);
    % 
    % 
    %     C(true_class, est_class) = C(true_class, est_class) + 1;
    % end

C=confusionmat(y_test, y_est);




end


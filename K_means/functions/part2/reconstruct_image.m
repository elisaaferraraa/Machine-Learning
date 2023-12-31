function [rimg] = reconstruct_image(cimg, ApList, muList)
%RECONSTRUCT_IMAGE Reconstruct the image given the compressed image, the
%projection matrices and mean vectors of each channels
%
%   input -----------------------------------------------------------------
%   
%       o cimg : The compressed image
%       o ApList : List of projection matrices for each independent
%       channels
%       o muList : List of mean vectors for each independent channels
%
%   output ----------------------------------------------------------------
%
%       o rimg : The reconstructed image

    [~,w,c]=size(cimg);
    h=size(ApList,2);
    rimg=zeros(h,w,c);
    for i= 1:c
        rimg(:,:,i)= reconstruct_pca(cimg(:,:,i), ApList(:,:,i), muList(:,i));
    end
    



end


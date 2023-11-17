function [cimg, ApList, muList] = compress_image(img, p)
%COMPRESS_IMAGE Compress the image by applying the PCA over each channels 
% independently
%
%   input -----------------------------------------------------------------
%   
%       o img : (height x width x 3), an image of size height x width over RGB channels
%       o p : The number of components to keep during projection 
%
%   output ----------------------------------------------------------------
%
%       o cimg : (p x width x 3) The projection of the image on the eigenvectors
%       o ApList : (p x height x 3) The projection matrices for each channels
%       o muList : (height x 3) The mean vector for each channels

%1)Extract the image matrix for the current channel.
%-->It's the same for the three colors
    [h,w,c]=size(img);
%2)Compute the PCA over this matrix.
%--> I am doing al toghether on the three channels with a for
    cimg=zeros(p, w, c); 
    ApList=zeros(p, h, c);
    muList=zeros(h,c);
        for i=1:3
            X=img(:,:,i) ;  
            [Mu, Covariance, EigenVectors, EigenValues] = compute_pca(X);
            [Yproj, Ap] = project_pca(X, Mu, EigenVectors, p);
            cimg(:,:,i)=Yproj;
            ApList(:,:,i)=Ap;
            muList(:,i)=Mu;
        end


end


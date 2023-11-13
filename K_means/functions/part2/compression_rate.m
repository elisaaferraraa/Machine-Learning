function [cr, compressedSize] = compression_rate(img,cimg,ApList,muList)
%COMPRESSION_RATE Calculate the compression rate based on the original
%image and all the necessary components to reconstruct the compressed image
%
%   input -----------------------------------------------------------------
%       o img : The original image   
%       o cimg : The compressed image
%       o ApList : List of projection matrices for each independent
%       channels
%       o muList : List of mean vectors for each independent channels
%
%   output ----------------------------------------------------------------
%
%       o cr : The compression rate
%       o compressedSize : The size of the compressed elements

%I calculate the dimention in the memory for each element I need
sY=numel(cimg)*64;
sAp=numel(ApList)*64;
smu=numel(muList)*64;
simg=numel(img)*64;

%Compression rate

cr=1-(sY+sAp+smu)/simg;


% convert the size to megabits
compressedSize=sY+sAp+smu;
compressedSize = compressedSize/1048576; 
end


function [data, param1, param2] = normalize(data, normalization, param1, param2)
%NORMALIZE Normalize the data wrt to the normalization technique passed in
%parameter. If param1 and param2 are given, use them during the
%normalization step
%
%   input -----------------------------------------------------------------
%   
%       o data : (N x M), a dataset of M sample points of N features
%       o normalization : String indicating which normalization technique
%                         to use among minmax, zscore and none
%       o param1 : (optional) first parameter of the normalization to be
%                  used instead of being recalculated if provided
%       o param2 : (optional) second parameter of the normalization to be
%                  used instead of being recalculated if provided
%
%   output ----------------------------------------------------------------
%
%       o X : (N x M), normalized data
%       o param1 : first parameter of the normalization
%       o param2 : second parameter of the normalization
    if nargin~=4
        Xmin=min(data,[],2);
        Xmax=max(data,[],2);
        stdev=std(data,0,2);
        mu=mean(data,2);
    else
        Xmin=param1;
        Xmax=param2;
        stdev=param2;
        mu=param1;

    end



    if normalization=="minmax"
        assert(all(size(Xmin) == [size(data,1),1]));
        assert(all(size(Xmax) == [size(data,1),1]));

        data=(data-Xmin)./(Xmax-Xmin);
        param1=Xmin;
        param2=Xmax;

    elseif normalization == "zscore"
        assert(all(size(stdev) == [size(data,1),1]));
        assert(all(size(mu) == [size(data,1),1]));

        data=(data-mu)./stdev;
        param1=mu;
        param2=stdev;

    elseif normalization == "none"
        param1=0;
        param2=0;

    end

end


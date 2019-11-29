function [dims] = tensorOrder(tsr)
%TENSORORDER Returns number of dimensions of the input argument.

    if nargin < 1 || isempty(tsr)
        error('A non-empty input argument is required.');
    end

    if isscalar(tsr)
        dims = 0;
        return;
    end
    
    dims = length(size(tsr));
    
    if dims > 2
        return;
    end
    
    if isvector(tsr)
        dims = 1;
    else
        dims = 2;
    end

end

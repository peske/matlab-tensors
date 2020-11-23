function dims = tensorOrder(tsr)
%TENSORORDER Returns number of dimensions of the input argument.

    if nargin < 1 || isempty(tsr)
        error('The input argument is required and cannot be empty.');
    end

    if isscalar(tsr)
        dims = 0;
    elseif isvector(tsr)
        dims = 1;
    else
        dims = length(size(tsr));
    end

end


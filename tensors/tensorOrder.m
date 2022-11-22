function dims = tensorOrder( tsr )
% Get the order (number of dimensions) of the input tensor.
%
% Args:
%   tsr: Input tensor whose order we want to determine.
%
% Returns:
%   dims: The order (number of dimensions) of the input tensor. If the
%       input value is a scalar, the function will return ``0``; if it's a 
%       vector, the function will return ``1``, etc.
%

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


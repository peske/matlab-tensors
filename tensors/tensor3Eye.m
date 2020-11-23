function c = tensor3Eye( n )
%TENSOR3EYE Creates an eye (identity) third order tensor of specified size.
%   
%   The resulting identity third order tensor is such that its all elements are 0, expect for the elements on the main 
%   diagonal of the cube (where indexes in all three dimensions are equal, i.e. [1,1,1], [2,2,2], etc.).
%
%   Input arguments:
%
%   n - Size of the tensor. The resulting tensor will have all its dimensions equal to this value.
%
%   Output arguments:
%
%   c - The resulting eye (identity) tensor.
%
%   See also: TENSOR4EYE

    if nargin < 1 || isempty(m)
        error('The first argument is mandatory and cannot be empty.');
    end

    if ~isscalar(n) || n < 0 || ~isWholeNumber(n)
        error('The input argument must be a scalar, non-negative, whole number.');
    end

    if n < 1
        c = [];
        return;
    end

    c = zeros([n, n, n]);

    for i = 1:n
        c(i,i,i) = 1;
    end

end


function c = tensor3Eye( n )
% Create an *eye* (*identity*) third order tensor of specified size.
%   
% The resulting *identity* third order tensor is such that its all elements 
% are ``0``, expect for the elements on the main diagonal of the cube
% (where indexes in all three dimensions are equal, i.e. ``[1,1,1]``,
% etc.).
%
% Args:
%   n: Size of the tensor. The resulting tensor will have all its
%       dimensions equal to this value.
%
% Returns:
%   c: The resulting *eye* (*identity*) tensor.
%
% See also:
%   :func:`tensor4Eye`
%

    if nargin < 1 || isempty(m)
        error('The first argument is mandatory and cannot be empty.');
    end

    if ~isscalar(n) || ~wholeNumbers(n) || n < 0
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


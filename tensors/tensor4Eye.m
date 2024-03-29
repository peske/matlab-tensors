function te = tensor4Eye( m, n )
% Create *eye* (*identity*) fourth order tensor with dimensions ``[m,n,m,n]``.
%
% The resulting *identity* tensor is such that its flattened version 
% (:func:`tensor4Flatten`) is equal to ``eye(m * n)``.
%
% Args:
%   m: 1st and 3rd dimension of the resulting tensor. It has to be a
%       scalar, positive whole number.
%   n: Optional. 2nd and 4th dimension of the resulting tensor. If not 
%       specified or empty, it will default ``m``.
%
% Returns:
%   te: The resulting *eye* tensor (*identity* tensor).
%
% See Also:
%   :func:`tensor3Eye`
%

    if nargin < 1 || isempty(m)
        error('The first argument is mandatory and cannot be empty.');
    end

    if ~isscalar(m) || ~all(wholeNumbers(m), 'all') || m < 1
        error('The first argument has to be a scalar, positive whole number.');
    end

    if nargin < 2 || isempty(n)
        n = m;
    elseif ~isscalar(n) || ~wholeNumbers(n) || n < 1
        error('The second argument has to be a scalar, positive whole number.');
    end

    te = reshape(eye(m * n), m, n, m, n);
    
end


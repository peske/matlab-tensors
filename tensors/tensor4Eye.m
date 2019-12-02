function [ te ] = tensor4Eye( m, n )
%TENSOR4EYE Returns eye tensor4 (identity tensor4) with dimensions [m,n,m,n].
%
%   The resulting identity tensor4 is such that its flattened version ('tensor4Flatten') is equal to eye(m * n).
%
%   Input arguments:
%
%    m -       1st and 3rd dimension of the resulting tensor4. It has to be a scalar, positive whole number.
%
%    n -       Optional. 2nd and 4th dimension of the resulting tensor4. If not specified or empty, it'll default to the
%              same value as the first argument ('m').
%
%   Output arguments:
%
%    te -      The resulting eye tensor4 (identity tensor4).
%
%   See also: TENSOR3EYE

    if nargin < 1 || isempty(m)
        error('The first argument (''m'') is mandatory.');
    end

    if ~isscalar(m) || ~isWholeNumber(m) || m < 1
        error('The first argument (''m'') has to be a scalar, positive whole number.');
    end

    if nargin < 2 || isempty(n)
        n = m;
    elseif ~isscalar(n) || ~isWholeNumber(n) || n < 1
        error('The second argument (''n'') has to be a scalar, positive whole number.');
    end

    te = reshape(eye(m * n), m, n, m, n);
    
end

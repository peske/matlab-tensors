function tf = tensor4Flatten( tsr )
% Flatten the input fourth-order tensor ``[m, n, o, p]`` to matrix ``[m * n, o * p]``.
%
% The flattening is performed by using MATLAB's `reshape
% <https://www.mathworks.com/help/matlab/ref/reshape.html>`_ function.
%
% Args:
%   tsr: Fourth-order tensor to flatten.
%
% Returns:
%   tf: The resulting matrix.
%

    if nargin < 1 || isempty(tsr)
        error('The input argument is mandatory and cannot be empty.');
    end

    [isTsr, tSize] = isTensor(tsr, 4);

    if ~isTsr
        error('The input argument must be a four-dimensional tensor.');
    end

    tf = reshape(tsr, [tSize(1) * tSize(2), tSize(3) * tSize(4)]);

end


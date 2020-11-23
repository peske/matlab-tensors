function tf = tensor4Flatten( tsr )
%TENSOR4FLATTEN Flattens the input tensor4 [m, n, o, p] to matrix [m * n, o * p].
%   The flattening is performed by using MATLAB's <a href="matlab: 
%   web('https://www.mathworks.com/help/matlab/ref/reshape.html')">reshape</a> function.

    if nargin < 1 || isempty(tsr)
        error('The input argument is mandatory and cannot be empty.');
    end

    [isTsr, tSize] = isTensor(tsr, 4);

    if ~isTsr
        error('The input argument must be a four-dimensional tensor.');
    end

    tf = reshape(tsr, [tSize(1) * tSize(2), tSize(3) * tSize(4)]);

end


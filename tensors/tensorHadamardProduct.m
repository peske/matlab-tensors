function [ tsr ] = tensorHadamardProduct( tsr, a, dimA, varargin )
%TENSORHADAMARDPRODUCT Element-wise multiplies the input tensors with tensors gotten from other arguments.
%
%   The purpose of the function is explained in 'tensorHadamardProduct_alt' function.
%
%   Input arguments:
%
%    tsr - The input tensor.
%
%    The rest of the arguments are equivalent to the corresponding arguments of 'tensor' function.
%
%   Output arguments:
%
%    tsr - The resulting box.
%
%   See also: TENSORHADAMARDCOLLAPSED
%

    if nargin < 2 || isempty(tsr) || isempty(a)
        error('The first two arguments are required.');
    end

    tsr = tsr .* tensorMany_private(size(tsr), a, dimA, varargin{:});

end

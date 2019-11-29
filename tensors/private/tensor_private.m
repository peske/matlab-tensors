function [ b ] = tensor_private( bSize, a, dimA )
%TENSOR_PRIVATE Creates a tensor of specified size by repeating input value along defined dimension(s).
%
%   NOTE: This function is intended only for internal use (it should not be called directly by an external code). For 
%         this reason input argument validation isn't implemented.
%
%   Input arguments: The meaning of the input arguments is the same as the meaning of the corresponding arguments of 
%   'tensor' function, with a few differences:
%   - This function accepts only one 'a' / 'dimA' pair;
%   - Here 'dimA' has to be sorted;
%   - Here 'bSize' cannot contain zeros.
%
%   Output arguments:
%
%     b     - The resulting tensor.
%

    if nargin < 3 || isempty(dimA) || length(dimA) == length(bSize)
        b = a + zeros(bSize);
        return;
    end

    aDims = length(dimA);
    boxDims = length(bSize);

    % Vector tha defines which dimensions are comming from 'a':
    fromA = ismember(1:boxDims, dimA);

    % Initialize permutation vector:
    pm = zeros(size(fromA));

    % Fill the dimensions which are comming from 'a' with values in range 1 to length(dimA):
    pm(fromA) = 1:aDims;

    % Fill the dimensions which aren't comming from 'a' with values in range length(dimA) + 1 to length(bSize):
    pm(~fromA) = aDims+1:boxDims;

    b = permute(a, pm);

    bSize(dimA) = 1;

    b = repmat(b, bSize);

end

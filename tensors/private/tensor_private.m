function [ tsr ] = tensor_private( tSize, a, dimA )
%TENSOR_PRIVATE Creates a tensor of specified size by repeating input value along defined dimension(s).
%
%   Input arguments: The meaning of the input arguments is the same as the meaning of the corresponding arguments of 
%   'tensor' function, with a few differences:
%   - This function accepts only one 'a' / 'dimA' pair;
%   - Here 'dimA' has to be sorted;
%   - Here 'tSize' cannot contain zeros.
%
%   Output arguments:
%
%     tsr - The resulting tensor.
%

    if nargin < 3 || isempty(dimA) || length(dimA) == length(tSize)
        tsr = a + zeros(tSize);
        return;
    end

    aDims = length(dimA);
    tDims = length(tSize);

    % Vector which defines which dimensions are comming from 'a':
    fromA = ismember(1:tDims, dimA);

    % Initialize permutation vector:
    pm = zeros(size(fromA));

    % Fill the dimensions which are comming from 'a' with values in range 1 to length(dimA):
    pm(fromA) = 1:aDims;

    % Fill the dimensions which aren't comming from 'a' with values in range length(dimA) + 1 to length(tSize):
    pm(~fromA) = aDims+1:tDims;

    tsr = permute(a, pm);

    tSize(dimA) = 1;

    tsr = repmat(tsr, tSize);

end

function [ r ] = tensorHadamardProduct_alt( tsr, a, dimA )
%TENSORHADAMARDPRODUCT_ALT The original calculation for which I've created 'tensorHadamardProduct' function.
%
%   This function should always produce the same output as 'tensorHadamardProduct', but it's much slower. The purpose of 
%   this function is only to demonstrate scenarios in which 'tensorHadamardProduct' can be used.
%
%   Input arguments
%
%    tsr     - A tensor;
%
%    a, dimA - The same meaning as in 'tensor' function.

    if nargin < 2 || isempty(tsr) || isempty(a)
        error('The first two arguments are required.');
    end

    if nargin < 3 || isempty(dimA)

        if isscalar(a)
            dimA = [];
        else
            dimA = 1:tensorOrder(a);
        end

    elseif ~isrow(dimA) || ~all(isWholeNumber(dimA)) || any(dimA < 1) || length(dimA) ~= length(unique(dimA))
        error('The third argument (''dimA'') has to be a row vector, containing only unique positive integer values.');
    elseif length(dimA) < tensorOrder(a)
        
        order = tensorOrder(a);
        
        error('The third argument (''dimA'') must have at least %d arguments becase the second argument (''a'') is of order %d.', ...
            order, order);
        
    elseif ~issorted(dimA, 'ascend')

        [dimA, pm] = sort(dimA, 'ascend');

        a = permute(a, pm);

    end
    
    tSize = size(tsr);

    r = zeros(tSize);

    tDims = length(tSize);

    idxes = cell(1, tDims);
    idxes(:) = {1};

    idxPointer = tDims;

    while idxPointer > 0

        if isempty(dimA)
            aValue = a;
        else
            aIdxes = idxes(dimA);
            aValue = a(aIdxes{:});
        end

        r(idxes{:}) = r(idxes{:}) + tsr(idxes{:}) * aValue;

        idxPointer = tDims;

        while idxPointer > 0

            if idxes{idxPointer} < tSize(idxPointer)

                idxes{idxPointer} = idxes{idxPointer} + 1;

                break;

            else

                idxes{idxPointer} = 1;

                idxPointer = idxPointer - 1;

            end

        end

    end

end

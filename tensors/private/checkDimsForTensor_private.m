function [ tSize, a, dimA ] = checkDimsForTensor_private( tSize, a, dimA )
%CHECKDIMSFORTENSOR_PRIVATE Cheks dimensions of values that should be used for creating a tensor of the specified size.
%
%   Input arguments: The meaning of the input arguments is the same as in 'tensor' function, with only difference that 
%   here the function accepts only one 'a' / 'dimA' pair.
%
%   Output arguments:
%
%    tSize - The same as the input, but with zero elements replaced with the actual lengths.
%
%    a -     The same as the input, or permuted if the input 'dimA' wasn't sorted.
%
%    dimA  - The same as the input, but sorted in ascending order.

    if nargin < 2 || isempty(tSize) || isempty(a)
        error('The first two arguments are mandatory.');
    end

    if ~isrow(tSize) || ~all(isWholeNumber(tSize)) || any(tSize < 0)
        error('The first argument (''tSize'') has to be a row vector which contains only non-negative integers.');
    end

    if nargin < 3 || isempty(dimA)

        if isscalar(a)
            dimA = [];
        else
            dimA = 1:tensorOrder(a);
        end

    else

        if ~isvector(dimA)
            error('The third argument (''dimA'') must be a scalar or a vector.');
        end

        if ~all(isWholeNumber(dimA)) || any(dimA < 1) || length(dimA) ~= length(unique(dimA))
            error('The third argument (''dimA'') must contain unique positive integers.');
        end

        if length(dimA) < tensorOrder(a)
            
            aDims = tensorOrder(a);
            
            error('The third argument (''dimA'') must have at least %d arguments becase the second argument (''a'') is of order %d.', ...
                aDims, aDims);
            
        end

        % Ensure row vector
        if size(dimA, 1) > 1
            dimA = dimA.';
        end

        if ~issorted(dimA, 'ascend')

            [dimA, dimAPermute] = sort(dimA, 'ascend');

            a = permute(a, dimAPermute);

        end

    end
    
    if isscalar(dimA)
        aSize = length(a);
    else
        aSize = size(a);
    end

    for i = 1:length(dimA)

        if dimA(i) > length(tSize) || tSize(dimA(i)) == 0
            tSize(dimA(i)) = aSize(i);
        elseif tSize(dimA(i)) ~= aSize(i)
            error('Inconsistent dimensions.');
        end

    end

end

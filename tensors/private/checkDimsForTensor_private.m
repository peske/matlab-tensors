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

    if nargin < 2
        error('The first two arguments (''bSize'' and ''a'') are mandatory.');
    end

    if isempty(a)
        error('The second argument (''a'') cannot be empty.');
    end

    if ~isrow(tSize) || ~all(isWholeNumber(tSize)) || any(tSize < 0)
        error('The first argument (''bSize'') has to be a row vector which contains only non-negative integers.');
    end

    aDims = tensorOrder(a);

    if nargin < 3 || isempty(dimA)

        if aDims < 1
            dimA = [];
        else
            dimA = 1:aDims;
        end

    else

        if ~isvector(dimA)
            error('The third argument (''dimA'') must be a scalar or a vector.');
        end

        if ~all(isWholeNumber(dimA)) || any(dimA < 1)
            error('The third argument (''dimA'') can contain only whole positive numbers.');
        end

        if length(dimA) ~= length(unique(dimA))
            error('The third argument (''dimA'') cannot contain duplicated elements.');
        end

        if length(dimA) < aDims
            error('The third argument (''dimA'') has to have more elements to define all dimensions of the second argument (''a'').');
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

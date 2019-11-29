function [ r ] = tensorHadamardCollapsed_alt(tsr, a, dimA)
%TENSORHADAMARDCOLLAPSED_ALT The original calculation for which I've created 'tensorHadamardCollapsed' function.
%
%   This function should always produce the same output as 'tensorHadamardCollapsed', but it's much slower. The purpose 
%   of this function is only to demonstrate scenarios in which 'tensorHadamardCollapsed' can be used.
%
%   Input arguments
%
%    tsr -     A tensor;
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
        error('The third argument (''dimA'') needs more elements in order to describe all the dimensions of the second one (''a'').');
    elseif ~issorted(dimA, 'ascend')

        [dimA, pm] = sort(dimA, 'ascend');

        a = permute(a, pm);

    end
    
    order = tensorOrder(tsr);

    [~, tSize] = isTensor(tsr, order);

    otherDims = setdiff(1:order, dimA);

    switch length(otherDims)

        case 0
            % The result is a scalar:
            r = 0;

        case 1
            % The result is a column vector:
            r = zeros(tSize(otherDims), 1);

        otherwise
            r = zeros(tSize(otherDims));

    end

    pm = [otherDims, dimA];

    if ~issorted(pm, 'ascend')

        tsr = permute(tsr, pm);
        
        order = tensorOrder(tsr);
        
        [~, tSize] = isTensor(tsr, order);

    end
    
    aDims = length(dimA);

    idxes = cell(1, order);
    idxes(:) = {1};

    idxPointer = order;

    %#ok<*AGROW>
    
    while idxPointer > 0

        if aDims == 0
            r(idxes{:}) = r(idxes{:}) + tsr(idxes{:}) .* a;
        elseif aDims == order
            r = r + tsr(idxes{:}) .* a(idxes{:});
        else
            r(idxes{1:order-aDims}) = r(idxes{1:order-aDims}) + tsr(idxes{:}) .* a(idxes{order-aDims+1:order});
        end

        idxPointer = order;

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

function [ t, tSize ] = tensorHadamard( tSize, a, dimA, varargin )
%TENSORHADAMARD Creates a tensor of specified size from the input values.
%
%   Input arguments:
%
%    tSize - Desired size of the tensor. It is a vector whose elements are representing desired lengths per dimension. 
%            For every non-zero element of this vector, the length of the corresponding dimesion of 'a' has to be equal 
%            to this value, or an error will be thrown. Zero elements are ignored, and the length of their corresponding 
%            dimension is inferred from other arguments, if possible. If it cannot be inferred, an error will be thrown.
%            If this argument is a scalar, then it represents the desired order (total number of dimensions) of the
%            tensor, and the lengths per dimension are assumed to be 0. For example, setting this argument to 4 has the 
%            same meaning as setting it to four-element zero row vector [0, 0, 0, 0].
%
%            Note that 'tSize' specifies dimension of the resulting tensor - the output one, not the input one, in case 
%            that they are different (if the input 'a' is permuted due to unsorted 'dimA').
%
%    a -     The value which will be used for creating the tensor. It can be a scalar, vector, matrix, or a tensor. If 
%            it's a vector, it isn't important if it is a row or column vector - both are treated in the same way, based 
%            on 'dimA'.
%
%    dimA -  Vector that defines mapping of dimensions of 'a' to the dimensions of the final tensor. For example, if 'a' 
%            is a matrix, and 'dimA' is [2, 3], it means that rows of matrix 'a' will end up along 2nd dimension, and 
%            columns of matrix 'a' will end up along 3rd dimension of the resulting tensor. Since 'dimA' relates to 
%            dimensions of 'a', there are some rules on how many elements it may contain:
%            - If 'dimA' contains one element (if it's a scalar), 'a' has to be a vector, and not a matrix or a tensor. 
%              It's because single 'dimA' value cannot define where two dimensions of a matrix should end up in the 
%              final tensor.
%            - Similarly, if 'dimA' contains two elements, 'a' has to be a matrix, and not a tensor, etc.
%
%            If 'dimA' isn't a sorted vector, it will be sorted, and the corresponding permutation of 'a' will be 
%            performed.
%
%            If 'dimA' isn't provided, or is empty, it's assumed that 'a' should end up along the first dimensions of 
%            the final tensor, so it'll get the following values by default:
%            - If 'a' is scalar, an error will be thrown;
%            - If 'a' is a vector, 'dimA' defaults to 1, meaning that vector 'a' should end up as the first dimension of 
%              the final tensor;
%            - if 'a' is a matrix, 'dimA' defaults to [1, 2], meaning that matrix 'a' should end up along the first two 
%              dimensions of the final tensor;
%            - if 'a' is a three-dimensional tensor, 'dimA' defaults to [1, 2, 3], etc.
%
%    The function accepts variable number of arguments so that we can provide multiple 'a'/'dimA' pairs. Every 
%    'a'/'dimA' pair is processed separately, resulting in a tensor. Results of each pair are then element-wise 
%    multiplied.
%
%   Output arguments:
%
%    t       - The resulting tensor.
%    tSize   - The size of the resulting tensor.
%

    if nargin < 2 || isempty(tSize) || isempty(a)
        error('The first two arguments are mandatory and cannot be empty.');
    end

    if ~isvector(tSize) || ~all(isWholeNumber(tSize)) || any(tSize < 0)
        error('The first argument must be a scalar or a vector that contains only a non-negative whole numbers.');
    end

    if isscalar(tSize)
        tSize = zeros(1, tSize);
    elseif ~isrow(tSize)
        tSize = tSize.';
    end

    if nargin < 3
        dimA = [];
    end

    [t, tSize] = tensorMany_private(tSize, a, dimA, varargin{:});

end

function [ t, tSize ] = tensorMany_private( tSize, varargin )
%TENSORMANY_PRIVATE Combines multiple 'a' and 'dimA' pairs into a single tensor.
%
%   Every 'a' and 'dimA' pair is processed by using 'checkDimsForTensor_private' and 'tensor_private' functions. Results 
%   are then combined by element-wise multiplication of tensors gotten by each pair.
%
%   Input arguments:
%
%    tSize    - The same meaning as in 'tensor_private' function.
%    varargin - 'a' and 'dimA' pairs, where 'a' and 'dimA' have the same meaning as in 'tensor_private' function.
%
%   Output arguments:
%
%    t        - The resulting tensor.
%    tSize    - The size of the resulting tensor.

    ctr = idivide(int32(nargin), 2);

    aS = cell(1, ctr);
    dimAS = cell(1, ctr);

    for n = 1:ctr

        if nargin > n * 2
            [tSize, aS{n}, dimAS{n}] = checkDimsForTensor_private(tSize, varargin{n * 2 - 1}, varargin{n * 2});
        else
            [tSize, aS{n}, dimAS{n}] = checkDimsForTensor_private(tSize, varargin{n * 2 - 1});
        end

    end

    if any(tSize < 1)
        error('Not all dimensions of the tensor (tSize) are supplied, nor can be inferred.');
    end

    t = 1;

    for n = 1:ctr
        t = t .* tensor_private(tSize, aS{n}, dimAS{n});
    end

end

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
        error('The first argument must be a row vector which contains only non-negative whole numbers.');
    end

    if nargin < 3 || isempty(dimA)

        if isscalar(a)
            dimA = [];
        else
            dimA = 1:tensorOrder(a);
        end

    else

        if ~isvector(dimA)
            error('The dimensions argument (''dimA'') must be a scalar or a vector.');
        end

        if ~all(isWholeNumber(dimA)) || any(dimA < 1) || length(dimA) ~= length(unique(dimA))
            error('The dimensions argument (''dimA'') must contain unique positive whole numbers.');
        end

        if length(dimA) < tensorOrder(a)
            
            aDims = tensorOrder(a);
            
            error('The dimensions argument (''dimA'') must have at least %d arguments becase the value argument (''a'') is of order %d.', ...
                aDims, aDims);
            
        end

        % Ensure row vector
        if ~isrow(dimA)
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


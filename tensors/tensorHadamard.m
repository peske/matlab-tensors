function [ t, tSize ] = tensorHadamard( tSize, a, dimA, varargin )
%TENSORHADAMARD Creates a tensor of specified size from the input values.
%
%   Input arguments:
%
%    tSize - Desired size of the tensor. It is a vector whose elements are 
%            representing desired lengths per dimension. Every non-zero 
%            element of this vector represents the length of the 
%            corresponding dimesion of the resulting tensor. For zero 
%            elements the length of the corresponding dimension of the 
%            resulting tensor will be inferred from other arguments, if 
%            possible. If it cannot be inferred, an error will be thrown.
%            If this argument is a scalar, then it represents the desired 
%            order (total number of dimensions) of the resulting tensor, 
%            and the specified lengths per dimension are assumed to be 0. 
%            For example, setting this argument to `4` has the same meaning 
%            as setting it to four-element zero row vector `[0, 0, 0, 0]`.
%
%    a -     The value which will be used for creating the tensor. It can 
%            be a scalar, vector, matrix, or a tensor. If it's a vector, it 
%            isn't important if it is a row or column vector - the result 
%            will be the same.
%
%    dimA -  Vector that defines mapping of dimensions of `a` to the 
%            dimensions of the resulting tensor. For example, if `a` is a 
%            matrix, and `dimA` is `[2, 3]`, it means that rows of matrix 
%           `a` will end up along 2nd dimension, and columns of matrix `a` 
%            along 3rd dimension of the resulting tensor. Number of 
%            elements of `dimA` must be equal to number of dimensions of 
%            value `a`. If `dimA` isn't provided, or is empty, it's assumed 
%            that `a` should end up along the first dimensions of the 
%            resulting tensor, so it'll get the following values by default:
%            - If `a` is scalar, an error will be thrown;
%            - If `a` is a vector, `dimA` defaults to `1`, meaning that 
%              vector `a` should end up as the first dimension of the 
%              resulting tensor;
%            - if `a` is a matrix, `dimA` defaults to `[1, 2]`, meaning 
%              that matrix `a` should end up along the first two dimensions 
%              of the resulting tensor;
%            - if `a` is a three-dimensional tensor, `dimA` defaults to 
%              `[1, 2, 3]`, etc.
%
%    The function accepts variable number of arguments so that we can 
%    provide multiple `a` / `dimA` pairs, every representing an input 
%    tensor. These tensors are then multiplied element-wise to calculate 
%    the result.
%
%   Output arguments:
%
%    t     - The resulting tensor.
%    tSize - The size of the resulting tensor.
%

    if nargin < 2 || isempty(tSize) || isempty(a)
        error('The first two arguments are mandatory and cannot be empty.');
    end

    if ~isvector(tSize) || ~all(wholeNumbers(tSize)) || any(tSize < 0)
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

function tsr = tensor_private( tSize, a, dimA )

    if nargin < 3 || isempty(dimA) || length(dimA) == length(tSize)
        tsr = a + zeros(tSize);
        return;
    end

    aDims = length(dimA);
    tDims = length(tSize);

    % Vector which defines which dimensions are comming from `a`:
    fromA = ismember(1:tDims, dimA);

    % Initialize permutation vector:
    pm = zeros(size(fromA));

    % Fill the dimensions which are comming from `a` with values in range 1 to length(dimA):
    pm(fromA) = 1:aDims;

    % Fill the dimensions which aren't comming from `a` with values in range length(dimA) + 1 to length(tSize):
    pm(~fromA) = aDims+1:tDims;

    tsr = permute(a, pm);

    tSize(dimA) = 1;

    tsr = repmat(tsr, tSize);

end

function [ tSize, a, dimA ] = checkDimsForTensor_private( tSize, a, dimA )

    if isvector(a) && ~iscolumn(a)
        a = a.';
    end
    
    if nargin < 3 || isempty(dimA)

        if isscalar(a)
            dimA = [];
            return;
        else
            dimA = 1:tensorOrder(a);
        end

    else

        if ~isvector(dimA)
            error('The dimensions argument (`dimA`) must be a scalar or a vector.');
        end

        if ~all(wholeNumbers(dimA)) || any(dimA < 1) || length(dimA) ~= length(unique(dimA))
            error('The dimensions argument (`dimA`) must contain unique positive whole numbers.');
        end
        
        order = tensorOrder(a);
        
        if length(dimA) < order
            error('The dimensions argument (`dimA`) must have at least %d elements becase the value argument (`a`) is of order %d.', ...
                order, order);            
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
    
    maxDimA = max(dimA);
    order = length(tSize);
    
    if order < maxDimA
        tSize = [tSize, zeros([1, maxDimA - order])];
    end
    
    aSize = size(a);

    for i = 1:length(dimA)

        if tSize(dimA(i)) == 0
            tSize(dimA(i)) = aSize(i);
        elseif tSize(dimA(i)) ~= aSize(i)
            error('Inconsistent dimensions.');
        end

    end

end


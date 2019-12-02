function [ t, tSize ] = tensor( tSize, a, dimA, varargin )
%TENSOR Creates a tensor of specified size from the input values.
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
%   See also: TENSOR3, TENSOR4

    if nargin < 2 || isempty(tSize) || isempty(a)
        error('The first two arguments have to be non-empty.');
    end

    if ~isvector(tSize) || ~all(isWholeNumber(tSize)) || any(tSize < 0)
        error('The first argument (''tSize'') has to be a scalar or a vector which contains only a non-negative whole numbers.');
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

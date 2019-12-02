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

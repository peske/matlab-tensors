function [ t, tSize ] = tensorMany_private( tSize, a, dimA, varargin )
%TENSORMANY_PRIVATE Combines multiple 'a' and 'dimA' pairs into a single tensor.
%
%   Every 'a' and 'dimA' pair is processed by using 'checkDimsForTensor_private' and 'tensor_private' functions. Results 
%   are then combined by element-wise multiplication of tensors gotten by each pair.
%
%   Input arguments have the same meaning as in 'tensor_private'. The only difference is that here we can provide 
%   multiple 'a' and 'dimA' pairs.
%
%   Output arguments:
%
%    t     - The resulting tensor.
%    tSize - The size of the resulting tensor.

    ctr = idivide(int32(nargin), 2);

    aS = cell(1, ctr);
    dimAS = cell(1, ctr);

    if nargin > 2
        [tSize, aS{1}, dimAS{1}] = checkDimsForTensor_private(tSize, a, dimA);
    else
        [tSize, aS{1}, dimAS{1}] = checkDimsForTensor_private(tSize, a);
    end

    for n = 2:ctr

        if nargin > n * 2
            [tSize, aS{n}, dimAS{n}] = checkDimsForTensor_private(tSize, varargin{n * 2 - 3}, varargin{n * 2 - 2});
        else
            [tSize, aS{n}, dimAS{n}] = checkDimsForTensor_private(tSize, varargin{n * 2 - 3});
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

function [ t4, tSize ] = tensor4( tSize, a, dimA, varargin )
%TENSOR4 More specific version of 'tensor' which creates four-dimensional tensors.
%
%   The meaning of the input arguments is the same as in 'tensor' function, with only one difference: If we provide 
%   'tSize' as a scalar here, it is equivalent to providing a row vector of length 4, with all elements equal to the 
%   scalar value. For example, if we provide 3, it would be equivalent to providing vector [3, 3, 3, 3].
%
%   Output arguments:
%
%    t3      - The resulting tensor.
%    tSize   - The size of the resulting tensor.
%
%   See also: TENSOR, TENSOR3

    if nargin < 3
        dimA = [];
    elseif ~all(isWholeNumber(dimA), 'all') || any(dimA > 4 | dimA < 1, 'all')
        error('The third argument (''dimA'') can contain only positive whole numbers in range 1 to 4.');
    end

    if nargin < 2
        a = [];
    end

    if nargin < 1 || isempty(tSize)
        tSize = [0, 0, 0, 0];
    elseif isscalar(tSize)
        tSize = [tSize, tSize, tSize, tSize];
    elseif length(size(tSize)) > 4
        error('The first argument (''tSize'') cannot have more than four dimensions.');
    end

    for i = 5:2:nargin
        dimAParam = varargin{i - 3};
        if ~all(isWholeNumber(dimAParam), 'all') || any(dimAParam > 4 | dimAParam < 1, 'all')
            error('Argument at position %d, which represents ''dimA'',  can contain only positive whole numbers in range 1 to 4.',...
                i);
        end
    end

    [t4, tSize] = tensor(tSize, a, dimA, varargin{:});

end

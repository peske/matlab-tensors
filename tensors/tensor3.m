function [ t3, tSize ] = tensor3( tSize, a, dimA, varargin )
%TENSOR3 More specific version of 'tensor' which creates three-dimensional tensors.
%
%   The meaning of the input arguments is the same as in 'tensor' function, with only one difference: If we provide 
%   'tSize' as a scalar here, it is equivalent to providing a row vector of length 3, with all elements equal to the 
%   scalar value. For example, if we provide 4, it would be equivalent to providing vector [4, 4, 4].
%
%   Output arguments:
%
%    t3      - The resulting tensor.
%    tSize   - The size of the resulting tensor.
%
%   See also: TENSOR, TENSOR4

    if nargin < 3
        dimA = [];
    elseif ~all(isWholeNumber(dimA), 'all') || any(dimA > 3 | dimA < 1, 'all')
        error('The third argument (''dimA'') can contain only positive integers in range 1 to 3.');
    end

    if nargin < 2
        a = [];
    end

    if nargin < 1 || isempty(tSize)
        tSize = [0, 0, 0];
    elseif isscalar(tSize)
        tSize = [tSize, tSize, tSize];
    elseif length(size(tSize)) > 3
        error('The first argument (''tSize'') cannot have more than three dimensions.');
    end

    for i = 5:2:nargin
        dimAParam = varargin{i - 3};
        if ~all(isWholeNumber(dimAParam), 'all') || any(dimAParam > 3 | dimAParam < 1, 'all')
            error('Argument at position %d, which represents ''dimA'',  can contain only positive integers in range 1 to 3.',...
                i);
        end
    end

    [t3, tSize] = tensor(tSize, a, dimA, varargin{:});

end

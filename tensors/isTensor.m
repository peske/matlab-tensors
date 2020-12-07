function [ isTsr, tSize ] = isTensor( tsr, order )
%ISTENSOR Checks if the input argument is a tensor of the specified order.
%
%   The function actualy returns `true` if the input value `tsr` has less 
%   dimensions than specified by `order`. It means that, for example, if we 
%   specify `order` 3, the function will return `true` if `tsr` is a scalar, 
%   vector, matrix or a three-dimensional tensor.
%
% Input arguments:
%
%  tsr    - Value to check.
%  order  - The order of the tensor. It has to be a scalar, positive whole 
%           number that represents number of dimensions. For example, a 
%           scalar is a zero-order tensor, a vector is a first-order tensor, 
%           a matrix is a second-order tensor, a three-dimensional array is 
%           a third-order tensor, etc. If this argument isn't specified, or 
%           if it's empty, it will default to 3.
%
%   Output arguments:
%
%    isTsr - Logical value that indicates if `tsr` is a tensor of the 
%            specified order.
%    tSize - Optional. The size of the tensor. This will be a row vector of 
%            length at least equal to 'order'. It means that, for example, 
%            if `tsr` is a vector of size `[4, 1]`, and `order` is `4`, the 
%            resulting `tSize` will be `[4, 1, 1, 1]`. But there are also 
%            two cases when it may happen that `tSize` has length greater 
%            than `order`:
%             - if `tsr` has more dimensions than specified by `order`, in 
%               which case `isTsr` will be false;
%             - If `order` is less than `2`. Minimal length of `tSize` is 2, 
%               as in 
%               <a href="matlab:web('https://www.mathworks.com/help/matlab/ref/size.html')">size</a>
%               function.
%

    if nargin < 1
        error('The first argument is mandatory.');
    end

    if nargin < 2 || isempty(order)
        order = 3;
    elseif ~isscalar(order) || ~wholeNumbers(order) || order < 1
        error('The second argument must be a scalar, positive whole number.');
    end

    if isempty(tsr)
        isTsr = false;
    else
        isTsr = order >= tensorOrder(tsr);
    end

    if nargout > 1

        tSize = size(tsr);

        diff = order - length(tSize);

        if diff > 0
            tSize = [tSize, ones(1, diff)];
        end

    end

end


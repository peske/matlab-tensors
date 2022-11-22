function r = sumAndCollapse( t, dim )
% Sum input tensor along the specified dimensions and collapses it.
%
% Thiis function is very similar to `sum
% <https://www.mathworks.com/help/matlab/ref/sum.html>`_ in terms that both
% are summing over the specified dimensions, and tensors retruned by both
% of them will contain the same elements. The only difference is in the
% shapre of the retruned tensor. The difference is explained in the example
% below.
%
% Example:
%
%   .. code-block:: matlab
%
%      >> t = rand(3, 4, 5, 6);
%      >> r1 = sum(t, [1, 3]);
%      >> size(r1)
%      ans =
%           1     4     1     6
%      >> r2 = sumAndCollapse(t, [1, 3]);
%      >> size(r2)
%           4     6
%
% Args:
%   t: Tensor to collapse.
%   dim: Dimensions over which to sum and collapse.
%
% Returns:
%   r: The result.
%

    if nargin < 2 || isempty(t) || isempty(dim)
        error('Both input arguments are required, and cannot be empty.');
    end    
    
    if ~issorted(dim, 'ascend')
        dim = sort(dim, 'ascend');
    end

    order = tensorOrder(t);
    
    r = sum(t, dim);
    
    r = permute(r, [setdiff(1:order, dim), dim]);
    
end


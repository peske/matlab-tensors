function r = tensorHadamardCollapsed( tsr, a, dimA )
%TENSORHADAMARDCOLLAPSED Performs element-wise multiplication (Hadamard product) of tensors, but then collapses the result by summing over 'dimA' dimensions.
%
%   The function actually executes 'tensorProduct' function internally, but collapses the result by summing it along 
%   'dimA' dimensions. Its purpose is explained in 'tensorHadamardCollapsed_alt' function.
%
%   Input arguments:
%
%    tensor  - The tensor to multiply.
%
%    a, dimA - Have the same meaning as in 'tensorHadamard', except that here we are accepting only one 'a'/'dimA' pair.
%
%   Output arguments:
%
%    r       - The result.
%
%   See also: TENSORHADAMARD
%

    if nargin < 2 || isempty(tsr) || isempty(a)
        error('The first two arguments are required and cannot be empty.');
    end

    if nargin < 3 || isempty(dimA)
        if isscalar(a)
            dimA = [];
        else
            dimA = 1:tensorOrder(a);
        end   
    end

    tsr = tsr .* tensorHadamard(size(tsr), a, dimA);

    if isempty(dimA)
        r = tsr;
        return;
    end

    order = tensorOrder(tsr);

    if order == length(dimA)
        r = sum(tsr, 'all');
        return;
    end

    if ~issorted(dimA, 'ascend')
        dimA = sort(dimA, 'ascend');
    end

    tsr = sum(tsr, dimA);

    r = permute(tsr, [setdiff(1:order, dimA), dimA]);

end


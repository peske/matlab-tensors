function T = example1Final(a, b, c)
%EXAMPLE1FINAL Calculates the tensor without using loops.
%   Input arguments a, b and c are column vectors.

    % Get dimensions:
    n = length(a);
    m = length(b);
    p = length(c);
    
    % Reshape the input vectors:
    b = permute(b, [2, 1]);
    c = permute(c, [2, 3, 1]);
    
    % Calculate:
    T = repmat(a, [1, m, p]);
    T = T .* repmat(b, [n, 1, p]);
    T = T .* repmat(c, [n, m, 1]);
    
end


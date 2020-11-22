function T = example1Loopless(a, b, c)
%EXAMPLE1LOOPLESS Calculates the tensor without using loops.
%   Input arguments a, b and c are column vectors.

    % Get dimensions:
    n = length(a);
    m = length(b);
    p = length(c);
    
    % Transform a to A:
    A = repmat(a, [1, m, p]);
    
    % Transform b to B
    % Reshape b:
    b = permute(b, [2, 1]);
    % Now we can do repmat:
    B = repmat(b, [n, 1, p]);
    
    % Transform c to C
    % Reshape c:
    c = permute(c, [2, 3, 1]);
    % And now repmat:
    C = repmat(c, [n, m, 1]);

    % And simply calculate the result:
    T = A .* B .* C;

end


function T = example1Loops(a, b, c)
%EXAMPLE1LOOPS Calculates the tensor by using loops.
%   Input arguments a, b and c are column vectors.

    % Get dimensions:
    n = length(a);
    m = length(b);
    p = length(c);

    % Initialize the result:
    T = zeros(n, m, p);
    
    for i = 1:n
        for j = 1:m
            for k = 1:p
                T(i, j, k) = a(i) * b(j) * c(k);
            end
        end
    end

end


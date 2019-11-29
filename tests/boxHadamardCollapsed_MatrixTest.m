function [ ] = boxHadamardCollapsed_MatrixTest( m, n )
%BOXHADAMARDCOLLAPSED_MATRIXTEST For testing 'boxHadamardCollapsed' function, by multiplying 4th order box with a matrix.

b = rand([m, n, m, n]);

a = rand([m, n]);

r1 = boxHadamardCollapsed(b, a, [3,4]);

r2 = zeros([m, n]);

for i = 1:m
    for j = 1:n
        for p = 1:m
            for q = 1:n
                r2(i,j) = r2(i,j) + b(i,j,p,q) * a(p,q);
            end
        end
        
        if abs(r1(i,j) - r2(i,j)) > 1e-8
            fprintf('%d / %d \n', r1(i,j), r2(i,j));
            error('Not equal!');
        end
        
    end
end

disp('boxHadamardCollapsed OK!');

end


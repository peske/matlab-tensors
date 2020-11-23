function tests = tensorHadamardCollapsed_test()
%TENSORHADAMARDCOLLAPSED_TEST 'tensorHadamardCollapsed' unit testing.
    tests = functiontests(localfunctions);
end

function values_test(~)
    checkTensorHadamardCollapsed([3, 4, 5, 6], [1, 2]);
end

function matrix_test(~)
    checkTensorHadamardCollapsed_Matrix(3, 4);
end

function vector_test(~)
    checkTensorHadamardCollapsed_Vector(3, 4);
end

function checkTensorHadamardCollapsed(tSize, dimA)

    tsr = rand(tSize);

    mx = rand(tSize(dimA));

    solution1 = tensorHadamardCollapsed(tsr, mx, dimA);

    solution2 = tensorHadamardCollapsed_alt(tsr, mx, dimA);
    
    assert(all(abs(solution1 - solution2) < 1e-8, 'all'));

end

function checkTensorHadamardCollapsed_Matrix( m, n )

    t = rand([m, n, m, n]);

    a = rand([m, n]);

    r1 = tensorHadamardCollapsed(t, a, [3,4]);

    r2 = zeros([m, n]);

    for i = 1:m
        for j = 1:n
            
            for p = 1:m
                for q = 1:n
                    r2(i,j) = r2(i,j) + t(i,j,p,q) * a(p,q);
                end
            end
            
            assert(abs(r1(i,j) - r2(i,j)) < 1e-8);

        end
    end

end

function [] = checkTensorHadamardCollapsed_Vector( i, j )

    t = tensorHadamard(3, rand([1, i]), [1, 2], rand([1, j]), [1, 3]);

    A(:,:) = t(1,:,:);

    a = rand([j 1]);

    r = tensorHadamardCollapsed(t, a, 3);

    r = r.';

    c2 = A * a;

    assert(all(r == c2, 'all'));

end

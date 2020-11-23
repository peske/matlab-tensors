function tests = tensorHadamard_test()
%TENSORHADAMARD_TEST Unit test of 'tensorHadamard' function.
    tests = functiontests(localfunctions);
end

function equation1_test(~)
    equation1(4, 5, 6);
end

function equation1(n, m, p)

    a = rand([n, 1]);
    b = rand([m, 1]);
    c = rand([p, 1]);

    T = tensorHadamard(3, a, [], b, 2, c, 3);

    assert(all(size(T) == [n, m, p], 'all'), 'Unexpected dimensions.');

    for i = 1:n
        for j = 1:m
            for k = 1:p
                assert(abs(T(i, j, k) - a(i) * b(j) * c(k)) < 1e-6, 'Result mismatch.');
            end
        end
    end

end


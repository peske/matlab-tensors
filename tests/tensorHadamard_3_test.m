function tests = tensorHadamard_3_test()
%TENSORHADAMARD_1_TEST Unit test of 'tensorHadamard' against equation 3.
%   The test is based on equation 3 from tensorHadamard_tests.md file.
    tests = functiontests(localfunctions);
end

function values_test(~)
    checkValues(4, 5, 6);
end

function checkValues(n, m, p)

    A = rand([n, m]);
    c = rand([p, 1]);

    T = tensorHadamard(3, A, [], c, 3);

    assert(all(size(T) == [n, m, p], 'all'), 'Unexpected dimensions.');

    for i = 1:n
        for j = 1:m
            for k = 1:p
                assert(abs(T(i, j, k) - A(i, j) * c(k)) < 1e-6, 'Result mismatch.');
            end
        end
    end

end


function tests = tensorHadamard_5_test()
%TENSORHADAMARD_1_TEST Unit test of 'tensorHadamard' against equation 5.
%   The test is based on equation 5 from tensorHadamard_tests.md file.
    tests = functiontests(localfunctions);
end

function values_test(~)
    checkValues(5);
end

function checkValues(n)

    R = rand();
    D = rand(n, n);
    r = rand(n, 1);
    m = rand(n, 1);
    v = rand(n, 1);
    x = rand(n, 1);

    % Pre-calculate v ./ r because it appears twice:
    vr = v ./ r;
    % Start from everything within the parenthesis:
    T = - tensorHadamard([n,n,n], vr, 2) + 2 / R^2 * tensorHadamard([n,n,n], x ./ m, 1) - tensorHadamard([n,n,n], vr, 3);
    % Finalize:
    T = T .* tensorHadamard(3, r ./ m .^ 2, 1, D, [1,2], D, [1,3]);

    assert(all(size(T) == [n, n, n], 'all'), 'Unexpected dimensions.');

    for i = 1:n
        for j = 1:n
            for k = 1:n
                act = r(i)/m(i)^2 * D(i, j) * D(i, k) * (- v(j)/r(j) + 2/R^2 * x(i)/m(i) - v(k)/r(k));
                err = abs(T(i, j, k) - act);
                if err >= 1e-6
                    disp('Actual: %d; from function: %d', act, T(i, j, k));
                end
                assert(err < 1e-6, 'Result mismatch.');
            end
        end
    end

end

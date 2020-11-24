function tests = tensorHadamard_test()
%TENSORHADAMARD_TEST Unit test of 'tensorHadamard' function.
    tests = functiontests(localfunctions);
end

function equation1_test(~)
    equation1(4, 5, 6);
end

function equation2_test(~)
    equation2(4, 5, 6);
end

function equation3_test(~)
    equation3(4, 5, 6);
end

function equation4_test(~)
    equation4(4, 5, 6);
end

function equation5_test(~)
    equation5(5);
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

function equation2(n, m, p)

    a = rand([n, 1]);
    b = rand([m, 1]);
    c = rand([p, 1]);

    T = tensorHadamard(3, a, [], b, 2, c .^ -1, 3);

    assert(all(size(T) == [n, m, p], 'all'), 'Unexpected dimensions.');

    for i = 1:n
        for j = 1:m
            for k = 1:p
                assert(abs(T(i, j, k) - a(i) * b(j) / c(k)) < 1e-6, 'Result mismatch.');
            end
        end
    end

end

function equation3(n, m, p)

    A = rand([n, m]);
    b = rand([p, 1]);

    T = tensorHadamard(3, A, [], b, 3);

    assert(all(size(T) == [n, m, p], 'all'), 'Unexpected dimensions.');

    for i = 1:n
        for j = 1:m
            for k = 1:p
                assert(abs(T(i, j, k) - A(i, j) * b(k)) < 1e-6, 'Result mismatch.');
            end
        end
    end

end

function equation4(n, m, p)

    A = rand([n, m]);
    B = rand([p, n]);

    T = tensorHadamard(3, A, [], B, [3, 1]);

    assert(all(size(T) == [n, m, p], 'all'), 'Unexpected dimensions.');

    for i = 1:n
        for j = 1:m
            for k = 1:p
                assert(abs(T(i, j, k) - A(i, j) * B(k, i)) < 1e-6, 'Result mismatch.');
            end
        end
    end

end

function equation5(n)

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
                assert(abs(T(i, j, k) - act) < 1e-6, 'Result mismatch.');
            end
        end
    end

end


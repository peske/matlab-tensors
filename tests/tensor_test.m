function tests = tensor_test()
%TENSOR_TEST 'tensor' unit testing.
    tests = functiontests(localfunctions);
end

function values_test(~)
    checkValues(4, 5, 6);
end

function checkValues(i, j, k)

    Aij = rand([i j]);
    Bik = rand([i k]);

    b = tensor(3, Aij, [], Bik, [1, 3]);

    for m = 1:i
        for n = 1:j
            for p = 1:k
                assert(b(m, n, p) == Aij(m, n) * Bik(m, p));
            end
        end
    end

end

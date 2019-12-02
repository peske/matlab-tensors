function tests = tensor4Flatten_test()
%TENSOR4FLATTEN_TEST 'tensor4Flatten' unit tests.
    tests = functiontests(localfunctions);
end

function values_test(~)
    checkTensor4Flatten(3, 4, 5, 6);
end

function [] = checkTensor4Flatten( m, n, p, q )

    t = rand([m, n, p, q]);

    tf = tensor4Flatten(t);

    for i = 1:m
        for j = 1:n
            for k = 1:p
                for l = 1:q
                    assert(t(i, j, k, l) == tf((j - 1) * m + i, (l - 1) * p + k));
                end
            end
        end
    end

end

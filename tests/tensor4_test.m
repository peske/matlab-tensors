function tests = tensor4_test()
%TENSOR4_TEST 'tensor4' unit testing.
    tests = functiontests(localfunctions);
end

function values_test(~)
    checkTensor4(3, 4, 5, 6);
end

function checkTensor4(dim1, dim2, dim3, dim4)

    A12 = rand([dim1 dim2]);
    B13 = rand([dim1 dim3]);
    C24 = rand([dim2 dim4]);

    [t4, tSize] = tensor4([], A12, [], B13, [1, 3], C24, [2, 4]);
    
    assert(all(tSize == [dim1, dim2, dim3, dim4]));

    for m = 1:dim1
        for n = 1:dim2
            for p = 1:dim3
                for q = 1:dim4
                    assert(t4(m, n, p, q) == A12(m, n) * B13(m, p) * C24(n, q));
                end
            end
        end
    end

end

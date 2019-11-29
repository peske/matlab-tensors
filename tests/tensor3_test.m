function tests = tensor3_test()
%TENSOR3_TEST 'tensor3' unit testing.
    tests = functiontests(localfunctions);
end

function values_test(~)
    checkTensor3(4, 5, 6);
end

function checkTensor3(dim1, dim2, dim3)

    A12 = rand([dim1 dim2]);
    B13 = rand([dim1 dim3]);

    [t3, tSize] = tensor3([], A12, [], B13, [1, 3]);
    
    assert(all(tSize == [dim1, dim2, dim3]));

    for m = 1:dim1
        for n = 1:dim2
            for p = 1:dim3
                assert(t3(m, n, p) == A12(m, n) * B13(m, p));
            end
        end
    end

end

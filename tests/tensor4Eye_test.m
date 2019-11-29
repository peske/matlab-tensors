function tests = tensor4Eye_test()
%TENSOR4EYE_TEST 'tensor4Eye' unit testing.
    tests = functiontests(localfunctions);
end

function alt_test(~)
    m = 4;
    n = 5;
    tsr = tensor4Eye(m, n);
    tsr_control = tensor4Eye_alt(m, n);
    assert(all(tsr == tsr_control, 'all'));
end

function values_test(~)
    checkTensor4EyeValues(4, 5);
end

function eye_test(~)
    m = 4;
    n = 5;
    tsr = tensor4Eye(m, n);
    tsr = tensor4Flatten(tsr);
    tsr_control = eye(m * n);
    assert(all(tsr == tsr_control, 'all'));
end

function checkTensor4EyeValues( m, n )

    if nargin < 2
        n = m;
    end
    
    te = tensor4Eye(m, n);

    for i = 1:m
        for j = 1:n
            for p = 1:m
                for q = 1:n

                    if i == p && j == q
                        assert(te(i,j,p,q) == 1);
                    else
                        assert(te(i,j,p,q) == 0);
                    end

                end
            end
        end
    end

end

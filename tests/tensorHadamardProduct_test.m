function tests = tensorHadamardProduct_test()
%TENSORHADAMARDPRODUCT_TEST 'tensorHadamardProduct' unit testing.
    tests = functiontests(localfunctions);
end

function values_test(~)
    checkTensorHadamardProduct([3, 4, 5, 6], [1, 2]);
end

function [] = checkTensorHadamardProduct(tSize, dimA)

    t = rand(tSize);

    mx = rand(tSize(dimA));

    solution1 = tensorHadamardProduct(t, mx, dimA);

    solution2 = tensorHadamardProduct_alt(t, mx, dimA);
    
    assert(all(abs(solution1 - solution2) < 1e-8, 'all'));

end

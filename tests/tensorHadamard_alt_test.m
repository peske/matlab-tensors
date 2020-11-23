function tests = tensorHadamard_alt_test()
%TENSORHADAMARD_ALT_TEST 'tensorHadamard' unit testing.
    tests = functiontests(localfunctions);
end

function values_test(~)
    checkTensorHadamardProduct([3, 4, 5, 6], [1, 2]);
end

function [] = checkTensorHadamardProduct(tSize, dimA)

    t = rand(tSize);

    mx = rand(tSize(dimA));

    solution1 = t .* tensorHadamard(size(t), mx, dimA);

    solution2 = tensorHadamardProduct_alt(t, mx, dimA);
    
    assert(all(abs(solution1 - solution2) < 1e-6, 'all'));

end

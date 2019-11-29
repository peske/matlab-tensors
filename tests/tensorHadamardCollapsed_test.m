function tests = tensorHadamardCollapsed_test()
%TENSORHADAMARDCOLLAPSED_TEST 'tensorHadamardCollapsed' unit testing.
    tests = functiontests(localfunctions);
end

function values_test(~)
    checkTensorHadamardCollapsed([3, 4, 5, 6], [1, 2]);
end

function checkTensorHadamardCollapsed(tSize, dimA)

    tsr = rand(tSize);

    mx = rand(tSize(dimA));

    solution1 = tensorHadamardCollapsed(tsr, mx, dimA);

    solution2 = tensorHadamardCollapsed_alt(tsr, mx, dimA);
    
    assert(all(abs(solution1 - solution2) < 1e-8, 'all'));

end

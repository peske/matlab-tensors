results = runtests({...
    'tensorHadamard_test.m', ...
    'tensor4Eye_test.m', ...
    'tensor4Flatten_test.m', ...
    'tensorHadamard_alt_test.m', ...
    'tensorHadamardCollapsed_test.m', ...
    });

table(results)
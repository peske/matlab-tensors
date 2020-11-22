function example1CompareResults(alngth, blngth, clngth)
%EXAMPLE1COMPARERESULTS Tests example1Final function.
%   Ensures that example1Final function returns the same result as
%   example1Loops function.
    
    a = rand([alngth, 1]);
    b = rand([blngth, 1]);
    c = rand([clngth, 1]);
    
    disp('Execute loopless implementation:');
    
    tic
    T1 = example1Final(a, b, c);
    toc
    
    disp('Execute implementation with loops:');
    
    tic
    T2 = example1Loops(a, b, c);
    toc
    
    if all(abs(T1 - T2) < 1e-6, 'all')
        disp('The results are the same!');
    else
        disp('ERROR: results are different!');
    end
    
end


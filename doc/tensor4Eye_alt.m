function [ te ] = tensor4Eye_alt( m, n )
%BOX4EYE_ALT Alternative to 'tensor4Eye1 function.

    te = zeros([m,n,m,n]);

    for i = 1:m
        for j = 1:n

            te(i, j, i, j) = 1;

        end
    end

end

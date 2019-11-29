function [] = boxHadamardCollapsed_VectorTest( i, j )
%BOXHADAMARDCOLLAPSED_VECTORTEST For testing 'boxHadamardCollapsed' function, by multiplying 3rd order box with a vector.

b = tensor(3, rand([1, i]), [1, 2], rand([1, j]), [1, 3]);

A(:,:) = b(1,:,:);

a = rand([j 1]);

r = boxHadamardCollapsed(b, a, 3);

r = r.';

c2 = A * a;

if ~all(r == c2)
    error('Not equal!');
end

disp('boxHadamardCollapsed OK!');

end


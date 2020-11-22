# Disclaimer

Although I do know few things about math, please be aware that I am not nearly an expert in it. It means that it may 
happen that I use a wrong terminology here and there, but even if this happens everything implemented is explained in 
examples, so you'll be able to understand the purpose anyway.

It's also important to mention that it isn't my intention to create a comprehensive and full-featured tensor library. 
Instead, I will create only few things that I've needed for my projects.

# Motivation / The Problem

Here I'll give an example problem solved by this library. Let's say that we have three arrays (vectors) with _n_, _m_ 
and _p_ elements, respectivelly: ![a_{\[n\]}](https://latex.codecogs.com/svg.latex?a_{[n]}),
![b_{\[m\]}](https://latex.codecogs.com/svg.latex?b_{[m]}) and 
![c_{\[p\]}](https://latex.codecogs.com/svg.latex?c_{[p]}). Let's also say that, for some reason, we need to 
calculate a three-dimensional array (tensor) ![T_{\[n*m*k\]}](https://latex.codecogs.com/svg.latex?T_{[n*m*k]}), 
defined as:

![T_{\[m*n*k\]} \to t_{i,j,k}=a_i*b_j*c_k\ where\ i=\overline{1,n}, j=\overline{1,m}, k=\overline{1,p}](https://latex.codecogs.com/svg.latex?\Large{T_{\[m*n*k\]}%20\to%20t_{i,j,k}=a_i*b_j*c_k%5c%20where%5c%20i=\overline{1,n},j=\overline{1,m},k=\overline{1,p}})

So, the problem is how to calculate that. At the first glance it's very easy - every junior developer knows how to 
implement that - just use loops! Here's an example implementation:

```matlab
function T = example1Loops(a, b, c)
%EXAMPLE1LOOPS Calculates the tensor by using loops.
%   Input arguments a, b and c are column vectors.

    % Get dimensions:
    n = length(a);
    m = length(b);
    p = length(c);

    % Initialize the result:
    T = zeros(n, m, p);
    
    for i = 1:n
        for j = 1:m
            for k = 1:p
                T(i, j, k) = a(i) * b(j) * c(k);
            end
        end
    end

end
```
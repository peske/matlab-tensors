Overview
========

The Problem / Motivation
------------------------

Let us start with a real-life problem that was the original motive for this
package. The task was to create a 3D tensor from three vectors so that:

.. math::
   \frac{{\partial }^2v_G}{{\left(\partial m\right)}^2}\ [n*n*n]\to 
   \frac{{\partial }^2v_{Gi}}{\partial m_j\partial m_k}=
   \frac{{\overline{r}}_i}{{\mu }^2_{Fi}}\frac{\partial {\mu }_{Fi}}{\partial m_j}
   \frac{\partial {\mu }_{Fi}}{\partial m_k}
   \left(- \frac{v_j}{{\overline{r}}_j} + \frac{2}{R^2_G}\frac{x_i}{{\mu }_{Fi}}
   - \frac{v_k}{{\overline{r}}_k}\right)

The equation looks scarier than necessary because of the notation used (partial
derivatives, Greek letters, etc.). Here is a much simpler version that
illustrates the problem solved by this package:

.. math::
   \Large T_{[m*n*p]} \to t_{i,j,k}=a_i*b_j*c_k

On the right side, we only have three vectors: :math:`a_{[m]}` with :math:`m`
elements, :math:`b_{[n]}` with :math:`n` elements, and :math:`c_{[p]}` with
:math:`p` elements. The result on the left side should be a 3D tensor of size
:math:`[m, n, p]`.

Naive Solution
--------------

The first intuition would be to solve this problem by using loops, as in the
following example:

.. code-block:: matlab

   function T = loopSolution(a, b, c)
   %LOOPSOLUTION Calculates the tensor by using loops.
   %   Input arguments a, b and c are column vectors.
 
       % Get dimensions:
       m = length(a);
       n = length(b);
       p = length(c);
 
       % Initialize the result:
       T = zeros(m, n, p);
    
       % Calculate:
       for i = 1:m
           for j = 1:n
               for k = 1:p
                   T(i, j, k) = a(i) * b(j) * c(k);
               end
           end
       end
 
   end

Although accurate, this implementation suffers one problem: performance. We have
a loop within a loop, within a loop. If vectors :math:`a`, :math:`b`, and
:math:`c` are huge, it will lead to too many passes. For example, if :math:`a`,
:math:`b` and :math:`c` have 100 elements each, it would cause **million loop
passes**. If they are 1000 elements each, it will cause **billion passes** and
take some time. It is a well-known fact that loops are not efficient in MATLAB. 

The Solution
------------

The same problem can be solved by using :func:`tensorHadamard` function. The
function does not contain any loops internally, thus being much faster than the
approach with loops. Performance benefits are more and more significant as the
size of the input vectors increases. For example, when the input vectors are one
thousand elements each, the approach with loops takes about 50 seconds, while
the approach with :func:`tensorHadamard` function takes about 4 seconds.

The following line shows how we should call the function to get the same result
as with ``loopSolution`` function from above:

.. code-block:: matlab

   T = tensorHadamard(3, a, 1, b, 2, c, 3);

Arguments:

* The first argument is ``tSize``, and it specifies the size of the resulting
  tensor. This argument can be:

  * An empty array (``[]``), in which case the function will try to
    infer the size of the resulting tensor based on other arguments. It will
    throw an error if the size cannot be inferred.
  * A scalar, as we have set it in this example, in which case it represents the
    number of dimensions of the resulting tensor. We have provided the value
    ``3``, meaning that the resulting tensor should have three dimensions (3D
    tensor). Actual size along these dimensions is not provided, and the
    function will try to infer it. Again, the function will raise an error if
    the actual size cannot be inferred.
  * A vector, in which case the vector elements represent the size along the
    corresponding dimension. We can set some of the vector elements to ``0``, in
    which case the function will try to infer the size along this dimension
    based on the remaining arguments. For example, providing the value 
    ``[2, 3, 0]`` means that the lengths along the first two dimensions are
    ``2`` and ``3``, respectively, and that the length along the third dimension
    should be inferred. Once more, if the function fails to infer the value, the
    function will raise an error.

* The second argument is ``a``, a tensor of the order lesser than or equal to
  the order of the resulting tensor. In our example, it is a vector.
* The third argument is ``dimA``, a vector that describes how the previous
  argument (``a``) should be converted into a tensor. It maps the dimensions of
  the input argument ``a`` with the dimensions of the resulting tensor. In our
  example, it is ``1``, meaning that vector ``a`` should be aligned along the
  first dimension of the resulting tensor and then repeated along the second and
  third dimensions. It means that the size of ``dimA`` must be equal to the
  number of dimensions of ``a``. This argument is optional, and if not provided
  or empty, it will default to ``1`` if ``a`` is a vector, ``[1, 2]`` if ``a``
  is a matrix, ``[1, 2, 3]`` if ``a`` is a 3D tensor, etc.
* The remaining arguments are just repetitions of the previously described two
  (``a`` and ``dimA``). We can add as many such argument pairs as needed, where
  every pair defines a new tensor (``a``) and its orientation in the resulting
  tensor (``dimA``).

Solving the Original Problem
----------------------------

Let us now solve the original problem we have started with:

.. math::
   \frac{{\partial }^2v_G}{{\left(\partial m\right)}^2}\ [n*n*n]\to 
   \frac{{\partial }^2v_{Gi}}{\partial m_j\partial m_k}=
   \frac{{\overline{r}}_i}{{\mu }^2_{Fi}}\frac{\partial {\mu }_{Fi}}{\partial m_j}
   \frac{\partial {\mu }_{Fi}}{\partial m_k}
   \left(- \frac{v_j}{{\overline{r}}_j} + \frac{2}{R^2_G}\frac{x_i}{{\mu }_{Fi}}
   - \frac{v_k}{{\overline{r}}_k}\right)

Note that partial derivatives from the equation above are simply matrices:

.. math::
   \frac{\partial {\mu }_{Fi}}{\partial m_j} = D_{i,j}

After replacing that and simplifying the notation by removing some unnecessary
subscripts, we get the following:

.. math::
   \Large T_{[n*n*n]}\to t_{i,j,k}=\frac{r_i}{m^2_i} * D_{i,j} * D_{i,k} *
   \left(-\frac{v_j}{r_j} + \frac{2}{R^2}\frac{x_i}{m_i} - \frac{v_k}{r_k}\right)

Where :math:`T_{[n,n,n]}` is the output tensor, :math:`R` is an input scalar,
:math:`D_{[n,n]}` is an input matrix, and several input vectors: :math:`r[n]`,
:math:`m[n]`, :math:`v[n]`, and :math:`x[n]`.

One possible solution:

.. code-block:: matlab

   % Start from everything in front of the parenthesis: 
   T = tensorHadamard(3, r ./ m .^ 2, 1, D, [1,2], D, [1,3]);
   % Pre-calculate v ./ r because it appears twice:
   vr = v ./ r;
   % Finalize:
   T = - T .* tensorHadamard([n,n,n], vr, 2) + \
       2 / R^2 * T .* tensorHadamard([n,n,n], x ./ m, 1) - \
	   T .* tensorHadamard([n,n,n], vr, 3);

Another possible solution:

.. code-block:: matlab

   % Pre-calculate v ./ r because it appears twice:
   vr = v ./ r;
   % Start from everything within the parenthesis:
   T = - tensorHadamard([n,n,n], vr, 2) + \
       2 / R^2 * tensorHadamard([n,n,n], x ./ m, 1) - \
	   tensorHadamard([n,n,n], vr, 3);
   % Finalize:
   T = T .* tensorHadamard(3, r ./ m .^ 2, 1, D, [1,2], D, [1,3]);

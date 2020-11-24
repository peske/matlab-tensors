# Disclaimer

It's important to mention that it isn't my intention to create a comprehensive and full-featured tensor library. 
Instead, I will create only few things that I've needed for my projects.

# Motivation / The Problem

During my work on numerical solutions for different problems, I was often encountering situation in which I need to 
calculate some tensor based on input values from several vectors/matrices/tensors. Here are few examples of such 
encounters:

![\Large T_{[m*n*p]} \to t_{i,j,k}=a_i*b_j*c_k](https://latex.codecogs.com/svg.latex?\Large%20T_{[m*n*p]}\to%20t_{i,j,k}=a_i*b_j*c_k)

![\Large T_{[m*n*p]} \to t_{i,j,k}=\frac{a_i*b_j}{c_k}](https://latex.codecogs.com/svg.latex?\Large%20T_{[m*n*p]}\to%20t_{i,j,k}=\frac{a_i*b_j}{c_k})

![\Large T_{[m*n*p]} \to t_{i,j,k}=A_{i,j}*b_k](https://latex.codecogs.com/svg.latex?\Large%20T_{[m*n*p]}\to%20t_{i,j,k}=A_{i,j}*b_k)

![\Large T_{[m*n*p]} \to t_{i,j,k}=A_{i,j}*B_{k,i}](https://latex.codecogs.com/svg.latex?\Large%20T_{[m*n*p]}\to%20t_{i,j,k}=A_{i,j}*B_{k,i})

![\Large T_{[n*n*n]}\to t_{i,j,k}=\frac{r_i}{m^2_i}*D_{i,j}*D_{i,k}*\left(-\frac{v_j}{r_j}+\frac{2}{R^2}\frac{x_i}{m_i}-\frac{v_k}{r_k}\right)](https://latex.codecogs.com/svg.latex?\Large%20T_{[n*n*n]}\to%20t_{i,j,k}=\frac{r_i}{m^2_i}*D_{i,j}*D_{i,k}*\left(-\frac{v_j}{r_j}+\frac{2}{R^2}\frac{x_i}{m_i}-\frac{v_k}{r_k}\right))

All these problems share one thing in common: they all can be solved quite easy by using loops. But we all know that we 
should avoid using loops in MATLAB. Especially loops within loops, within loops, which can result in a billion passes 
through the innermost loop body. So what's the alternative? All these problems can be solved by using 
[`tensorHadamard`](doc/tensorHadamard.md) function.

You can find more details in 
[MATLAB Tensors in Numerical Computations](https://fatdragon.me/blog/2020/11/matlab-tensors-numerical-computations) 
article.

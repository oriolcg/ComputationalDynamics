@def title = "1.1 Taylor Series"
@def hascode = true
@def mintoclevel=1
@def maxtoclevel=1

Before going into more details on how to find a numerical approximation, let's start by refreshing some theory about **[Taylor series](https://en.wikipedia.org/wiki/Taylor_series)**. As one can find in the Wikipedia page:

> the **Taylor series** of a function is an infinite sum of terms that are expressed in terms of the function's derivatives at a single point.

That is $$ f(x)=\sum_{i=0}^\infty\frac{f^{(i)}(a)}{i!}(x-a)^i. $$

The series is exact for an arbitrary function as long as we include infinite terms in the sum. However, here we are interested on an approximation that includes only the first $r$ terms of the expansion: $$ f_r(x)=\sum_{i=0}^r\frac{f^{(i)}(a)}{i!}(x-a)^i\approx f(x). $$

Let's see how this work in a practical example. We consider here the function $f(x)=\sin(x)$ and we want to approximate this function knowing the function value and its derivatives at the point $a=0$. Using five terms in the expansion, $r=5$, we have that 
$$\begin{align*}f_5(x) &= \sin(0) + x\cos(0) - \frac{x^2}{2}\sin(0) - \frac{x^3}{6}\cos(0) + \frac{x^4}{24}\sin(0) + \frac{x^5}{120}\cos(0)\\
                      &= x - \frac{x^3}{6} + \frac{x^5}{120}.
\end{align*} $$

We now can do a first coding exercise with this example and see how this approximation looks like for different values of $r$. To do so, we explicitly define the approximated functions.
```julia:./code/Taylor_series
const a = 0
f(x) = sin(x)
f₀(x) = sin(a)
f₁(x) = f₀(x) + (x-a)*cos(a)
f₂(x) = f₁(x) - (x-a)^2/2 * sin(a)
f₃(x) = f₂(x) - (x-a)^3/6 * cos(a)
f₄(x) = f₃(x) + (x-a)^4/24 * sin(a)
f₅(x) = f₄(x) + (x-a)^5/120 * cos(a)
```
And we plot them. Here we use the package [`Plots.jl`](http://docs.juliaplots.org/latest/) that contains visualization tools and [`LaTeXStrings.jl`](https://github.com/stevengj/LaTeXStrings.jl) which is a convinient tool to use $\LaTeX$ syntax in the plots.
```julia:./code/Taylor_series_plot
using Plots
using LaTeXStrings
x = -2π:0.01:2π
plt = plot(x,f.(x),
           linecolor=:black,
           linewidth=3,
           label=L"\sin(x)",
           xlabel=L"x",
           ylabel=L"f(x)",
           xlim=[-2π,2π],
           ylim=[-1.5,1.5])
plot!(plt,x,f₀.(x),line=:dash,label=L"f_0(x)")
plot!(plt,x,f₁.(x),linewidth=2,line=:solid,label=L"f_1(x)")
plot!(plt,x,f₂.(x),line=:dash,label=L"f_2(x)")
plot!(plt,x,f₃.(x),linewidth=2,line=:solid,label=L"f_3(x)")
plot!(plt,x,f₄.(x),line=:dash,label=L"f_4(x)")
plot!(plt,x,f₅.(x),linewidth=2,line=:solid,label=L"f_5(x)")
savefig("./__site/assets/lecture_notes/Module1/TaylorSeries/figures/1_2.png") # hide
```
\fig{./figures/1_2.png}

We see that as we increase the number of terms, the approximation gets closer to the analytical expression. Note also that for this particular example, there is no gain for $r=2$ and $r=4$ with respect to $r=1$ and $r=3$. This is caused by the fact that $\sin(a)=0$ at the approximation point $a=0$.

We can go further and evaluate and plot the error of the approximation for different values of $m$.
$$ e_m(x)=|f(x)-f_m(x)|,\qquad r=1,...,5$$
```julia:./code/Taylor_series_error
e₀(x)=abs(f(x)-f₀(x))
e₁(x)=abs(f(x)-f₁(x))
e₂(x)=abs(f(x)-f₂(x))
e₃(x)=abs(f(x)-f₃(x))
e₄(x)=abs(f(x)-f₄(x))
e₅(x)=abs(f(x)-f₅(x))

plt = plot(x,log.(e₀.(x)),line=:dash,label=L"e_0(x)",xlabel=L"x",ylabel=L"\log(e(x))",)
plot!(plt,x,log.(e₁.(x)),linewidth=2,line=:solid,label=L"e_1(x)")
plot!(plt,x,log.(e₂.(x)),line=:dash,label=L"e_2(x)")
plot!(plt,x,log.(e₃.(x)),linewidth=2,line=:solid,label=L"e_3(x)")
plot!(plt,x,log.(e₄.(x)),line=:dash,label=L"e_4(x)")
plot!(plt,x,log.(e₅.(x)),linewidth=2,line=:solid,label=L"e_5(x)")
savefig("./__site/assets/lecture_notes/Module1/TaylorSeries/figures/1_3.png") # hide
```
\fig{./figures/1_3.png}

As it is seen in the previous figure, close to the evaluation point $a$, the approximation error decreases as we increase the number of terms in the expansion.

@@important 
@@important-title
*Now we know...*
@@
* How to approximate a function using a **Taylor series**
* That the approximation error is introduced when truncating the series to $r$ finite terms
* How to compute and plot the Taylor series approximation and error of a simple function
@@


# Additional material
In practise, one can use tools that facilitate the derivation of Taylor series of functions. That is the case of the package [`TaylorSeries.jl`](https://juliadiff.org/TaylorSeries.jl/stable/), a Julia package for Taylor expansions in one or more independent variables.
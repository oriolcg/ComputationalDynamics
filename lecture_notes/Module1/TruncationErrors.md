@def title = "1.3 Truncation Error"
@def hascode = true
@def mintoclevel=1
@def maxtoclevel=1

# Local truncation error

Since we have used a finite number or terms $m$ in the Taylor expansion, the approximated solution will not be exact. But, can we get a better understanding of this error? 

Let's look more carefully at the approximations that we did in the previous section. Assuming that we can obtain an exact solution and its derivatives at $t_{i-1}$, the approximated exact value at $t_i$ can be expressed as
$$u_i = \underbrace{\sum_{j=0}^r\frac{u_{i-1}^{(j)}}{j!}\Delta t^j}_{\tilde{u}_i} + \underbrace{\sum_{j=m+1}^\infty\frac{u_{i-1}^{(j)}}{j!}\Delta t^j}_{\epsilon_i}.$$

We see that the approximation error is
$$\epsilon_i=|u_i-\tilde{u}_i|=\left|\sum_{j=m+1}^\infty\frac{u_{i-1}^{(j)}}{j!}\Delta t^j\right|,$$
which depends on the function derivatives' with order $j$ multiplied by the time step to the power $j$, with $m < j < \infty$. As we decrease $\Delta t$, the decrease of the error will be governed by the lowest exponent in the sum, that is $\Delta t^{m+1}$. Therefore, we say that the approximation will have a **local truncation error** that convergenes with a rate of $m+1$. The error between step $i$ and $i-1$ will be of the order of $\Delta t^{m+1}$:
$$ \epsilon_i\sim\mathcal{O}(\Delta t^{m+1}). $$

Then, the approximations introduced in (1.2.11) and (1.2.12) will have a local truncation error of order
$$ \begin{align*}\epsilon_{u_i}&\sim\mathcal{O}(\Delta t^3),\\
                \epsilon_{\dot{u}_i}&\sim\mathcal{O}(\Delta t^2).
\end{align*} $$

Hence, at time $t_{i+1}$, the numerical error introduced in equation \eqref{approx_ddotu} will be governed by the error of $u_i$, i.e. $\epsilon_{u_i}\sim\mathcal{O}(\Delta t^3)$, and the error of $\dot{u}_i$, i.e. $\epsilon_{\dot{u}_i}\sim\mathcal{O}(\Delta t^2)$. 

Let's take a closer look at what does this mean. The error at the first time step ($i=1$), for a given time step size $\Delta t^*$, will be governed by the first neglected term in the truncated series, *i.e.* $\epsilon_{u_1}({\Delta t^*})\sim\frac{u_{0}^{(3)}}{6}{\Delta t^*}^3$ and $\epsilon_{\dot{u}_1}({\Delta t^*})\sim\frac{\dot{u}_{0}^{(2)}}{2}{\Delta t^*}^2$. What would happen if we reduce the time step size by $10$?
$$\frac{\epsilon_{u_1}({\Delta t^*})}{\epsilon_{u_1}({\Delta t^{**}})}\sim\frac{\frac{u_{0}^{(3)}}{6}{\Delta t^*}^3}{\frac{u_{0}^{(3)}}{6}{\Delta t^{**}}^3}=\frac{1}{10^3},\qquad \frac{\epsilon_{\dot{u}_1}({\Delta t^*})}{\epsilon_{\dot{u}_1}({\Delta t^{**}})}\sim\frac{\frac{\dot{u}_{0}^{(2)}}{2}{\Delta t^*}^3}{\frac{\dot{u}_{0}^{(2)}}{2}{\Delta t^{**}}^2}=\frac{1}{10^2}.$$

Therefore, $\epsilon_{\ddot{u}_i}\sim\mathcal{O}(\Delta t^2)$, since the second order convergence of $\dot{u}_i$ will dominate over the third order error of $u_i$. In that case, we don't need a third order accurate scheme ($r=2$) for $u_i$, a TS with $r=1$ (sedond order) will result in the same accuracy for $\ddot{u}_i$ and we avoid the evaluation of the term $\frac{\Delta t^2}{2}\ddot{u}_{i-1}$.

The final scheme, equivalent to the [**Forward Euler**](https://en.wikipedia.org/wiki/Euler_method) method for second order ODEs, is defined by the following steps: 

&nbsp;
@@colbox-blue
@@colbox-blue-title **Forward Euler Method** @@
1. Get the value of the second time derivative from the equation of motion: $$\ddot{u}_{i-1}=\frac{1}{m}(F(t_{i-1})-ku_{i-1}-c\dot{u}_{i-1}).\label{approx_ddotu_FE}$$
2. Update the solution at $t_i$: $$u_i=u_{i-1} + \Delta t\dot{u}_{i-1}.\label{approx_u_FE}$$
3. Update the first time derivative at $t_i$: $$\dot{u}_i=\dot{u}_{i-1}+\Delta t\ddot{u}_{i-1}.\label{approx_dotu_FE}$$
@@

# Global truncation error

We have seen that the local truncation error of the Forward Euler method is second order, meaning that at every step $i$ for $i=1,...,N$ we will introduce an error of $\mathcal{O}(\Delta t^2)$. Therefore, after $N$ time steps, the global truncation error will be
$$\epsilon_{u_N}\sim N\mathcal{O}(\Delta t^2)=\frac{T}{\Delta t}\mathcal{O}(\Delta t^2)\sim\mathcal{O}(\Delta t).$$

This leads to a first order convergence rate for the global truncation error of the Forward Euler method. 

&nbsp;
&nbsp;
&nbsp;

@@important 
@@important-title
*Now we know...*
@@
* How to quantify the convergence rate of the local truncation error in a truncated **Taylor series**
* How to quantify the convergence rate of the global truncation error of a scheme.
* That the this truncation error will afect the order (or convergence rate) of an ODE solver
* How to define the **Forward Euler** method
@@
@def title = "1.5 Time stepping and error control"
@def hascode = true
@def mintoclevel=1
@def maxtoclevel=1
@def fd_eval=true

We have seen that the error of the numerical solution will decrease as we decrease the time step. In particular, we have shown that the global error of the Forward Euler method will decrease linearly with the time step size: $\epsilon_{\mathbf{q}_N}\sim \mathcal{O}(\Delta t).$

Can we control this error such that its value is always below a certain tolerance, $\tau$?

Let's look into more detail on how the error could be controled. We know that the truncation error of the state vector at time $i$ is
$$\epsilon_{\mathbf{q}_i} = \frac{\Delta t^2}{2}\ddot{\mathbf{q}}_i + \mathcal{O}(\Delta t^3)$$ and we want that $\epsilon_{\mathbf{q}_i}\leq\tau$ Assuming that the third-order term will vanish faster, we seek for a variable time step size such that
$$\left|\frac{\Delta t_i^2}{2}\ddot{\mathbf{q}}_i\right|\leq\tau,$$
which leads to 
$$ \Delta t_i\leq\sqrt{2\frac{\tau}{\left|\ddot{\mathbf{q}}_i\right|}}.\label{eq:dt_var}$$

Some times is useful to also define a tolerance based on the value of the solution. In that case, we can define the tolerance as
$$\tau=\max(\tau_{\tiny \text{rel}}|\mathbf{q}_i|,\tau_{\tiny\text{abs}}),\label{eq:tol}$$
where $\tau_{\tiny \text{rel}}$ and $\tau_{\tiny \text{abs}}$ are relative and absolute tolerances. 

Instead of the vector magnitudes, $\left|\ddot{\mathbf{q}}_i\right|$ and $\left|\mathbf{q}_i\right|$, one could consider a condition less restrictive based on the component-wise values, $\ddot{q}_j$ and $q_j$, *i.e*
$$ \Delta t_i\leq\min_j\sqrt{2\frac{\tau}{\left|\ddot{q}_{j,i}\right|}}.\label{eq:dt_var_component}$$

The remaining issue with conditions \eqref{eq:dt_var} or \eqref{eq:st_var_component} is that we do not have a definition for $\ddot{\mathbf{q}}_i$. An example of approximation could be:
$$\ddot{\mathbf{q}}_i\approx\frac{\dot{\mathbf{q}}_i-\dot{\mathbf{q}}_{i-1}}{\Delta t_{i}}.\label{eq:ddotq}$$

However, this introduces a nonlinearity with respect to $\Delta t_i$ that would have to be addressed with an iterative algorithm. Assuming that the solution is smooth and varies slowly, one could use the previous time step size, $\Delta t_{i-1}$ in \eqref{eq:ddotq}.
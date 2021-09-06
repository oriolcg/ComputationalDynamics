@def title = "1.6 Types of ODE solvers"
@def hascode = true
@def mintoclevel=1
@def maxtoclevel=1
@def fd_eval=true

In previous sections we have defined the [**Forward Euler**](lecture_notes/Module1/TruncationErrors) method. We have seen that it can be defined as
$$ \mathbf{q}_i = \mathbf{q}_{i-1} + \Delta t\ \dot{\mathbf{q}}_{i-1} + \mathcal{O}(\Delta t^2).\label{eq:FE}$$

We re-write equation \eqref{eq:FE} in such a way that the value at $t_i$ is given as a result of evaluating a function, $f_{\text{\tiny FE}}$, that takes as arguments $\Delta t$, $\mathbf{q}_{i-1}$ and $\dot{\mathbf{q}}_{i-1}$:
$$ \mathbf{q}_i = f_{\text{\tiny FE}}(\Delta t,\mathbf{q}_{i-1},\dot{\mathbf{q}}_{i-1}) + \mathcal{O}(\Delta t^2).\label{eq:f_FE}$$

In the case we have an equation of motion that relates $\ddot{u}_{i}$ with $u_i$ and $\dot{u}_{i}$, we can simplify even more the function $f_{\text{\tiny FE}}$, so it only takes as arguments $\Delta t$ and $\mathbf{q}_{i-1}$.
$$ \mathbf{q}_i = f_{\text{\tiny FE}}(\Delta t,\mathbf{q}_{i-1}) + \mathcal{O}(\Delta t^2).\label{eq:f_FE_simplified}$$

Depending on the definition of the function $f$, one can classify the ODE solver in different categories:
- Implicit vs Explicit
- Single-step vs Multi-step
- Single-stage vs Multi-stage

## Implicit and Explicit solvers

We say that an ODE solver is **explicit** when the function that gives the state vector at time $t_i$ only depends on the state vector and its derivatives at previous times. That is
$$ \mathbf{q}_i = f_{\text{\tiny explicit}}(\Delta t,\mathbf{q}_{j},\dot{\mathbf{q}}_{j},...,\mathbf{q}_{j-1},\dot{\mathbf{q}}_{j-1},...)\qquad \text{for }j < i.$$

Note that the Forward Euler method is an explicit method, since $f_{\text{\tiny FE}}(\Delta t,\mathbf{q}_{i-1})$ only depends on the state vector at $t_{i-1}$.

We say that an ODE solver is **implicit** when the function that gives the state vector at time $t_i$ depends on the same state vector at time $t_i$. That is
$$ \mathbf{q}_i = f_{\text{\tiny implicit}}(\Delta t,\mathbf{q}_{j},\dot{\mathbf{q}}_{j},...,\mathbf{q}_{j-1},\dot{\mathbf{q}}_{j-1},...)\qquad \text{for }j <= i.$$

An example of implicit solver is the [**Backward Euler**](https://en.wikipedia.org/wiki/Backward_Euler_method) scheme, that computes the state vector at $t_i$ as
$$ \mathbf{q}_i = f_{\text{\tiny BE}}(\Delta t,\dot{\mathbf{q}_i},\mathbf{q}_{i-1}) + \mathcal{O}(\Delta t^2) = \mathbf{q}_{i-1} + \Delta t\ \dot{\mathbf{q}}_{i} + \mathcal{O}(\Delta t^2).$$

## Single-step and multi-step solvers

We say that an ODE solver is a **single-step** solver when the function that gives the state vector at time $t_i$ only depends on the state vector and its derivatives at $t_i$ or $t_{i-1}$. That is
$$ \mathbf{q}_i = f_{\text{\tiny 1-step}}(\Delta t,\mathbf{q}_{i},\mathbf{q}_{i-1},\dot{\mathbf{q}}_{i},\dot{\mathbf{q}}_{i-1},...).$$
@@row
@@img
@@center ![](/assets/lecture_notes/Module1/SolverTypes/figures/SingleStep.png) @@
@@
~~~
<div style="clear: both"></div>
~~~
@@

Note that the Forward Euler and Backward Euler methods are single-step methods.

We say that an ODE solver is a **multi-step** solver when the function that gives the state vector at time $t_i$ depends on the state vector and its derivatives at multiple previous times. That is
$$ \mathbf{q}_i = f_{\text{\tiny n-step}}(\Delta t,\mathbf{q}_{i},\mathbf{q}_{i-1},\dot{\mathbf{q}}_{i},\dot{\mathbf{q}}_{i-1},...,\mathbf{q}_{j},\dot{\mathbf{q}}_{j},...,\mathbf{q}_{j-1},\dot{\mathbf{q}}_{j-1},...)\qquad \text{for }j < i-1.$$
@@row
@@img
@@center ![](/assets/lecture_notes/Module1/SolverTypes/figures/MultiStep.png) @@
@@
~~~
<div style="clear: both"></div>
~~~
@@

An example of multi-step scheme are the [**Backward Differentiation Formulas**](https://en.wikipedia.org/wiki/Backward_differentiation_formula). For instance, the second-order Backward Differentiation Formula (BDF2) reads:
$$ \mathbf{q}_i =f_{\text{\tiny BDF2}}(\Delta t,\dot{\mathbf{q}}_{i},\mathbf{q}_{i-1},\mathbf{q}_{i-2}) = \frac{4}{3}\mathbf{q}_{i-1}-\frac{1}{3}\mathbf{q}_{i-2} + \frac{2}{3}\Delta t\dot{\mathbf{q}}_{i}.$$

## Single-stage and multi-stage

We say that an ODE solver is a **single-stage** solver when the function that gives the state vector at time $t_i$ depends on the state vector and its derivatives at previous steps, but it does not use any additional intermediate stages. 

The Forward Euler, Backward Euler and BDF schemes are single-stage solvers.
@@row
@@img
@@center ![](/assets/lecture_notes/Module1/SolverTypes/figures/FE.png) @@
@@
~~~
<div style="clear: both"></div>
~~~
@@

We say that an ODE solver is a **multi-stage** solver when the function that gives the state vector at time $t_i$ only depends on the state vector and its derivatives at $t_i$ or $t_{i-1}$, but it uses additional intermediate stages. 

An example of multi-stage solvers are the [**Runge-Kutta**](https://en.wikipedia.org/wiki/Runge%E2%80%93Kutta_methods) methods. For example, the fourth-order Runge-Kutta scheme (RK4) can be defined as:
$$ \begin{align*} \mathbf{q}_i =& \mathbf{q}_{i-1} + \frac{1}{6}\Delta t(k_1+2k_2+2k_3+k_4),\\
k_1=&\dot{\mathbf{q}}_{i-1},\\
k_2=&f\left(\frac{\Delta t}{2},\mathbf{q}_{i-1}+\Delta t\frac{k_1}{2}\right),\\
k_3=&f\left(\frac{\Delta t}{2},\mathbf{q}_{i-1}+\Delta t\frac{k_2}{2}\right),\\
k_4=&f\left(\Delta t,\mathbf{q}_{i-1}+\Delta tk_3\right).
\end{align*} $$
@@row
@@img
@@center ![](/assets/lecture_notes/Module1/SolverTypes/figures/RK.png) @@
@@
~~~
<div style="clear: both"></div>
~~~
@@

&nbsp;
&nbsp;

@@important 
@@important-title
*Now we know...*
@@
* How classify an ODE solver into: Implicit or Explicit, Single-step or Multi-step and Single-stage or Multi-stage.
@@

# Additional material

To solve ODEs in Julia, you can use the [`DiferentialEquations.jl`](https://diffeq.sciml.ai/stable/tutorials/ode_example/) package, which has a wide variety of solvers that can be used depending on the properties of the ODE. See this [documentation page](https://diffeq.sciml.ai/stable/solvers/ode_solve/#ode_solve) for full list of solvers.
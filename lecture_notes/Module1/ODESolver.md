@def title = "1.4 An ODE solver: the Forward Euler method"
@def hascode = true
@def mintoclevel=1
@def maxtoclevel=1
@def fd_eval=true

The last version of our ODE solver as seen in [*Truncation Errors*](../TruncationErrors) results in the **Forward Euler** (FE) method for second order ODEs:
$$ \begin{align*}
u_i&=u_{i-1} + \Delta t\dot{u}_{i-1},\\
\dot{u}_i&=\dot{u}_{i-1}+\Delta t\ddot{u}_{i-1},
\end{align*},\qquad\qquad \forall i=1,...,N.\label{eq:FE}$$

Remember that the value of $\ddot{u}_{i-1}$ is typically given by the Equation of Motion of the system. 

Equation \eqref{eq:FE} can be re-written in a vector form by defining the so called *state variable* $$\mathbf{q}_i=\left[\begin{align*}&u_i\\&\dot{u}_i\end{align*}\right],$$ leading to a (FE) scheme with truncation error of order $\mathcal{O}(\Delta t^2)$
$$ \mathbf{q}_i = \mathbf{q}_{i-1} + \Delta t\ \dot{\mathbf{q}}_{i-1},\qquad\qquad \forall i=1,...,N. $$

To find the solution at all times $t_i$ for $i=1,...,N$, we need the following **inputs**:
- the initial conditions at $t_0$, $\mathbf{q}_0$
- a function that computes $\dot{\mathbf{q}}_i$ given $\mathbf{q}_i$, $\dot{\mathbf{q}}_i=f(\mathbf{q}_i)$
- the time step size, $\Delta t$, and the final time, $T$

# Implementation
Let's see how we can implement the FE solver in a very simple example. Assume that we want to solve the mass-damper-spring system introduced at the introduction of this module
$$ m\ddot{u}(t)+c\dot{u}(t)+ku(t)=f(t), $$


with the following input parameters:
```julia:./code/input_params
const k = 1   # [N/m]
const c = 0.1 # [Ns/m]
const m = 1   # [kg]
const ξ = 0.1 # [N]
const ω = 1   # [rad]
f(t::Real) = ξ*sin(ω*t)
```

and the following input conditions:
```julia:./code/input_conds
const u₀ = 1.0
const v₀ = 0.0
```

We define a time step size and a final time: 
```julia:./code/time_step
const Δt = 0.05
const T = 10.0
```

As an input, we aslo need the function that computes $\dot{\mathbf{q}}_i$ given $\mathbf{q}_i$:
```julia:./code/ode_func
function dq(q,t)
    (u,v) = q              # unpack variables
    du = v                 # displacement time derivative is equal to velocity
    dv = (f(t)-k*u-c*v)/m  # acceleration from equation of motion
    dq = (du,dv)           # pack variables
end
```

The Forward Euler solver can be defined as a function that given the initial conditions, time step size and final time, it returns a vector with the solution:
```julia:./code/fe_solver
function fe_solver(q₀,Δt,T)
    N = Int(T/Δt) + 1                           # number of time steps
    q = Array{Tuple{Float64,Float64}}(undef,N)  # Define the solution array (vector of tuples containing displacement and velocity)
    q[1] = q₀                                   # Initialize initial value
    for (i,tᵢ) in enumerate(Δt:Δt:T)            # Loop over time steps (from t=Δt to t=T with a time step size of Δt)
        q[i+1] = q[i] .+ Δt .* dq(q[i],tᵢ)      # update the vector with the FE scheme
    end
    return q                                    # return the solution vector
end
```

Now, we just need to evaluate the function sending the correct input arguments
```julia:./code/solution
q₀ = (u₀,v₀)
q = fe_solver(q₀,Δt,T)
@show q
```
\show{./code/solution}

And we can now plot the solution
```julia:./code/plot
using Plots
u = [qᵢ[1] for qᵢ in q]
v = [qᵢ[2] for qᵢ in q]
t = 0:Δt:T
plt = plot(t,u,label="displacement")
plot!(plt,t,v,label="velocity")
savefig("./__site/assets/lecture_notes/Module1/ODESolver/figures/displacement_velocity.png") # hide
```
\fig{./figures/displacement_velocity.png}

&nbsp;
&nbsp;
&nbsp;

@@important 
@@important-title
*Now we know...*
@@
* How to define and implement the Forward Euler scheme to solve second order ODEs
@@


# Additional material

The implementation shown above is intended to be understandable for educational purposes, but it is not the most computationally efficient approach. To solve ODEs in Julia, without having to develop your own solver, you can use the [`DiferentialEquations.jl`](https://diffeq.sciml.ai/stable/tutorials/ode_example/) package.


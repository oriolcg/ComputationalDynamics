@def title = "2.2. Lagrangian Mechanics"
@def hascode = true
@def mintoclevel=1
@def maxtoclevel=1

In a wide variety of applications, we are interested on defining the Equations of Motion (EoM) of a system that might be composed by several elements. The compatibility of motions between these elements introduce certain constraints. Then, determining the EoM of the full system can result in a convoluted task.

Luckily, there is an approach that allows us to derive the EoM of complex systems in a procedural manner: the **Euler-Lagrange** approach.

# What is a Lagrangian

First, let us start by defining the concept of **Lagrangian**, $\mathcal{L}$, which is given by the following expression $$\mathcal{L}=T-V.$$
Here, $T$ is the kinetic energy of the system and $V$ the potential energy. 

Knowing its definition, one can compute it by following these steps:
1. Define the kinematic relations:
    That means to describe the location of each relevant point using the generalized coordinates of the system (GCS)
    - The relevant points are on the points that have mass, centre of gravity of a rigid body, connection points, etc.
    - If multiple points are connected to each other, it is easier to express the coordinates relative to each other.
2. Define the energy equations:
    That means to write down the kinetic and potential energy of all the elements
3. Replace the kinematic equations into the energy equations
4. Done!

# Equations of motion from a Lagrangian

Once we have the definition of the Lagrangian, $\mathcal{L}$, we can compute the system EoM by using the Lagrange's equation: 
$$ \frac{d}{dt}\frac{\partial\mathcal{L}}{\partial\dot{g}_i}=\frac{\partial\mathcal{L}}{∂ g_i}\quad\text{for }i=1,...,nDOF,\label{eq:Lagrange}$$ 
where $g_i$ is the vector of generalized coordinates of the system and $\dot{g}_i$ the corresponding generalized velocities. Note that equation \eqref{eq:Lagrange} is a system of equations, one equation for each coordinate (or degree of freedom (DOF)).

In practice, $g_i$ contains the DOFs of the system for $i=1,...,nDOF$. Therefore, the state vector $\mathbf{q}$ that we used in the previous module, can be written as $$\mathbf{q}=\left[\begin{align*}&g_i\\&\dot{g}_i\end{align*}\right].$$

Thus, to obtain the EoM we will have to follow these steps:
1. Compute the Lagrangian
2. Compute derivatives with respect to $g_i$ and $\dot{g}_i$
3. Obtain the equation of motion by replacing in the Lagrange's equation \eqref{eq:Lagrange}

For large systems, it is difficult to derive manually the derivatives of the Lagrangian with respect to the degrees of freedom. In such cases, it is useful to make use of tools that can derive them for us. Here we can use *Maple* and symbolic tools from *Matlab* or *Python*. In these lecture notes we use the *Julia* package [*Symbolics.jl*](https://symbolics.juliasymbolics.org/stable/)

# An example

Let's consider the example of a vertical pendulum attached to a spring where we neglect the effect of gravity
@@row
@@img-small
@@center ![](/assets/lecture_notes/Module2/LagrangianMechanics/figures/pendulum.png) @@
@@
~~~
<div style="clear: both"></div>
~~~
@@

To derive the EoM of this system we start by computing the Lagrangian, following the steps descrived earlier:
1. Define the kinematic relations:
Assuming that $p_1$ and $p_3$ are known fixed points (i.e. no velocities at these points), and $r_1$, $m$ and $k$ are known constans, the position of the point mass will be defined by the angle $\varphi$, which is the only variable of the system. 
```julia:./code/kinematic_relations
using Symbolics
@variables t, ϕ(t), p₁, p₃, k, r₁, m
Dt = Differential(t)
p₂ = p₁ .+ r₁ .* [cos(ϕ) sin(ϕ)]'
p₂ₜ = Dt.(p₂)
@show p₂
@show p₂ₜ
```
\show{./code/kinematic_relations}

2. Define the energy equations:
```julia:./code/energy
using LinearAlgebra
T = 1/2*m*norm(p₂ₜ)^2
r₂₀ = norm(p₁.-p₃)-r₁
r₂ = norm(p₂.-p₃)
V = 1/2*k*(r₂-r₂₀)
@show T
@show V
```
\show{./code/energy}

3. Define the Lagrangian:
```julia:./code/lagrangian
L = T-V
@show L
```
\show{./code/lagrangian}

Once we have the Lagrangian definition, we appy the Lagrange equation to derive the equation of motion. To do that, we will use the `Differential` operator of the `Symbolics.jl` package:
```julia:./code/EoM
Dϕ = Differential(ϕ)
Dϕₜ = Differential(ϕₜ)
∂L_∂ϕ = Dϕ(L)
∂L_∂ϕₜ = Dϕₜ(L)
EoM = Dt(∂L_∂ϕₜ) - ∂L_∂ϕ ~ 0
@show simplify(expand_derivatives(EoM))
```
\show{./code/EoM}

Now let's evaluate the model for a specific set of parameters:
```julia:./code/EoM_eval
EoM_expanded = expand_derivatives(EoM)
EoM_eval = substitute(simplify(EoM_expanded), (Dict( p₁=>[0.0 3.0]', p₃=>[0.0 0.0]', k=>1.0, r₁=>1.5, m=>1.0 )))
@show EoM_expanded
```
\show{./code/EoM_eval}




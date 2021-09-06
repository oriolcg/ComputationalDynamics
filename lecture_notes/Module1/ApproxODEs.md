@def title = "1.2 Approximating ODEs with Taylor Series"
@def hascode = true
@def mintoclevel=1
@def maxtoclevel=1

We have seen that to approximate a function using Taylor series (TS), we just need the value of the function and its derivatives at a point. We now can use this tool to approximate the solution of ODEs. 

Let's consider the linear mass-damping-stiffness system defined before:
$$ m\ddot{u}(t)+c\dot{u}(t)+ku(t)=F(t), $$
with appropriate initial conditions at $t=t_0$
$$ u(t_0)=u_0,\quad\dot{u}(t_0)=\dot{u}_0. $$

Here, we want to find the expression of a TS approximation of $u(t)$ around a point in time $t^*$. That is

$$ u(t)\approx\tilde{u}(t)=\sum_{i=0}^r\frac{u^{(i)}(t^*)}{i!}(x-t^*)^i. $$

Using $r=2$, this expression simplifies to

$$ \tilde{u}(t)=u(t^*) + \dot{u}(t^*)(t-t^*) + \frac{1}{2}\ddot{u}(t^*)(t-t^*)^2. $$

The issue here is that in order to get the expression of $ \tilde{u}(t) $, we first need the values $u(t^*)$, $\dot{u}(t^*)$ and $\ddot{u}(t^*)$ for a given $t^*$. If we select $t^*=t_0$, we can use the initial conditions, i.e. $u(t^*)=u(t_0)=u_0$ and $\dot{u}(t^*)=\dot{u}(t_0)=\dot{u}_0$. Moreover, from the equation of motion, we can obtain the value for $\ddot{u}(t^*)=\ddot{u}(t_0)=\frac{1}{m}(F(t_0)-ku_0-c\dot{u}_0)$. Therefore, the appoximated solution $\tilde{u}_1=\tilde{u}(t_1)$ at time $t_1=t_0+Δ t$ will read
$$ \tilde{u}_1=u_0 + \Delta t\dot{u}_0 + \frac{\Delta t^2}{2}\ddot{u}_0. $$

As seen previously, the quality of the approximation depends on how far $t_1$ is from $t_0$, that is how large $\Delta t$ is. This means that reducing $\Delta t$ we will get a better approximation of $u$. Assuming that $\tilde{u}_1$ is a good enough approximation of $u(t_1)$ and simplifying notation, hereinafter we will use $u_1$ instead of $\tilde{u}_1$. 

Now, we are not just interested in finding $u(t_1)$ for a $t_1$ close enough to $t_0$, but we want to find $u(t)$ for any $t\in[t_0,T]$. Let's see what happens if we apply the same process at $t_2=t_1 + \Delta t$:
$$ \tilde{u}_2=u_1 + \Delta t\dot{u}_1 + \frac{\Delta t^2}{2}\ddot{u}_1. \label{u2}$$

In this expression we need $u_1$, which is known, $\dot{u}_1$, which is unknown, and $\ddot{u}_1$, that is also unknown. From the equation of motion, we can get the value of $\ddot{u}_1$ in terms of $u_1$ and $\dot{u}_1$
$$\ddot{u}_1=f(u_1,\dot{u}_1)=\frac{1}{m}(F(t_1)-ku_1-c\dot{u}_1).\label{ddotu1}$$

However, we still have $\dot{u}_1$ as an unknown in \eqref{u2}. Let's try to approximate it using a TS again with $r=2$ terms:
$$\dot{u}_1=\dot{u}_0+\Delta t\ddot{u}_0+\frac{\Delta t^2}{2}\frac{d^3u_0}{dt^3}. \label{dotu1}$$

The problem now with equation \eqref{dotu1} is that we don't have the initial value of the third derivative in time $\frac{d^3u_0}{dt^3}$. Alternatively, we can use an approximation using a TS with $r=1$, leading to 
$$\dot{u}_1=\dot{u}_0+\Delta t\ddot{u}_0.\label{dotu1_}$$

Thus, we can obtain an approximation of $u_2$ in terms of $u_1$, $\dot{u}_1$ and $\ddot{u}_1$ that are known. This process can be generalized to an arbitrary number of steps. Let's assume that we discretize the time in $N$ equally distributed time points, $[t_0,t_1,t_2,...,t_N]$, where $t_i=i\Delta t$. Knowing the solution and its first time derivative at time $t_{i-1}$, we can find the solution at $t_i$ by

@@colbox-blue
1. Get the value of the second time derivative from the equation of motion: $$\ddot{u}_{i-1}=\frac{1}{m}(F(t_{i-1})-ku_{i-1}-c\dot{u}_{i-1}).\label{approx_ddotu}$$
2. Update the solution at $t_i$: $$u_i=u_{i-1} + \Delta t\dot{u}_{i-1} + \frac{\Delta t^2}{2}\ddot{u}_{i-1}.\label{approx_u}$$
3. Update the first time derivative at $t_i$: $$\dot{u}_i=\dot{u}_{i-1}+\Delta t\ddot{u}_{i-1}.\label{approx_dotu}$$
@@
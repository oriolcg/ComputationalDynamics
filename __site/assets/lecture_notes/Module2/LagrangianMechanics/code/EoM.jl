# This file was generated, do not modify it. # hide
Dϕ = Differential(ϕ)
Dϕₜ = Differential(ϕₜ)
∂L_∂ϕ = Dϕ(L)
∂L_∂ϕₜ = Dϕₜ(L)
EoM = Dt(∂L_∂ϕₜ) - ∂L_∂ϕ ~ 0
@show simplify(expand_derivatives(EoM))
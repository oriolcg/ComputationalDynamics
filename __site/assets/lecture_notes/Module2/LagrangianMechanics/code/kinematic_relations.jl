# This file was generated, do not modify it. # hide
using Symbolics
@variables t, ϕ(t), p₁, p₃, k, r₁, m
Dt = Differential(t)
p₂ = p₁ .+ r₁ .* [cos(ϕ) sin(ϕ)]'
p₂ₜ = Dt.(p₂)
@show p₂
@show p₂ₜ
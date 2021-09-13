# This file was generated, do not modify it. # hide
using LinearAlgebra
T = 1/2*m*norm(p₂ₜ)^2
r₂₀ = norm(p₁.-p₃)-r₁
r₂ = norm(p₂.-p₃)
V = 1/2*k*(r₂-r₂₀)
@show T
@show V
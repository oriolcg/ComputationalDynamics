# This file was generated, do not modify it. # hide
const k = 1   # [N/m]
const c = 0.1 # [Ns/m]
const m = 1   # [kg]
const ξ = 0.1 # [N]
const ω = 1   # [rad]
f(t::Real) = ξ*sin(ω*t)
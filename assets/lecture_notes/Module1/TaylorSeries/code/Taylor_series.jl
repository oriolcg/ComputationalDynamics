# This file was generated, do not modify it. # hide
const a = 0
f(x) = sin(x)
f₀(x) = sin(a)
f₁(x) = f₀(x) + (x-a)*cos(a)
f₂(x) = f₁(x) - (x-a)^2/2 * sin(a)
f₃(x) = f₂(x) - (x-a)^3/6 * cos(a)
f₄(x) = f₃(x) + (x-a)^4/24 * sin(a)
f₅(x) = f₄(x) + (x-a)^5/120 * cos(a)
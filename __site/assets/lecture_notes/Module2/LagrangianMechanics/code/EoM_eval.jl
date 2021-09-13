# This file was generated, do not modify it. # hide
EoM_expanded = expand_derivatives(EoM)
EoM_eval = substitute(simplify(EoM_expanded), (Dict( p₁=>[0.0 3.0]', p₃=>[0.0 0.0]', k=>1.0, r₁=>1.5, m=>1.0 )))
@show EoM_expanded
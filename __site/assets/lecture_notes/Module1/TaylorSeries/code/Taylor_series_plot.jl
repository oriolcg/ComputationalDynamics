# This file was generated, do not modify it. # hide
using Plots
using LaTeXStrings
x = -2π:0.01:2π
plt = plot(x,f.(x),
           linecolor=:black,
           linewidth=3,
           label=L"\sin(x)",
           xlabel=L"x",
           ylabel=L"f(x)",
           xlim=[-2π,2π],
           ylim=[-1.5,1.5])
plot!(plt,x,f₀.(x),line=:dash,label=L"f_0(x)")
plot!(plt,x,f₁.(x),linewidth=2,line=:solid,label=L"f_1(x)")
plot!(plt,x,f₂.(x),line=:dash,label=L"f_2(x)")
plot!(plt,x,f₃.(x),linewidth=2,line=:solid,label=L"f_3(x)")
plot!(plt,x,f₄.(x),line=:dash,label=L"f_4(x)")
plot!(plt,x,f₅.(x),linewidth=2,line=:solid,label=L"f_5(x)")
savefig("./__site/assets/lecture_notes/Module1/TaylorSeries/figures/1_2.png") # hide
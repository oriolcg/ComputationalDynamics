# This file was generated, do not modify it. # hide
e₀(x)=abs(f(x)-f₀(x))
e₁(x)=abs(f(x)-f₁(x))
e₂(x)=abs(f(x)-f₂(x))
e₃(x)=abs(f(x)-f₃(x))
e₄(x)=abs(f(x)-f₄(x))
e₅(x)=abs(f(x)-f₅(x))

plt = plot(x,log.(e₀.(x)),line=:dash,label=L"e_0(x)",xlabel=L"x",ylabel=L"\log(e(x))",)
plot!(plt,x,log.(e₁.(x)),linewidth=2,line=:solid,label=L"e_1(x)")
plot!(plt,x,log.(e₂.(x)),line=:dash,label=L"e_2(x)")
plot!(plt,x,log.(e₃.(x)),linewidth=2,line=:solid,label=L"e_3(x)")
plot!(plt,x,log.(e₄.(x)),line=:dash,label=L"e_4(x)")
plot!(plt,x,log.(e₅.(x)),linewidth=2,line=:solid,label=L"e_5(x)")
savefig("./__site/assets/lecture_notes/Module1/TaylorSeries/figures/1_3.png") # hide
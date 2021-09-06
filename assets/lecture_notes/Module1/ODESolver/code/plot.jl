# This file was generated, do not modify it. # hide
using Plots
u = [qᵢ[1] for qᵢ in q]
v = [qᵢ[2] for qᵢ in q]
t = 0:Δt:T
plt = plot(t,u,label="displacement")
plot!(plt,t,v,label="velocity")
savefig("./__site/assets/lecture_notes/Module1/ODESolver/figures/displacement_velocity.png") # hide
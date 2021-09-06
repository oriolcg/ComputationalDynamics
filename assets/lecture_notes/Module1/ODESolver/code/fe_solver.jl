# This file was generated, do not modify it. # hide
function fe_solver(q₀,Δt,T)
    N = Int(T/Δt) + 1                           # number of time steps
    q = Array{Tuple{Float64,Float64}}(undef,N)  # Define the solution array (vector of tuples containing displacement and velocity)
    q[1] = q₀                                   # Initialize initial value
    for (i,tᵢ) in enumerate(Δt:Δt:T)            # Loop over time steps (from t=Δt to t=T with a time step size of Δt)
        q[i+1] = q[i] .+ Δt .* dq(q[i],tᵢ)      # update the vector with the FE scheme
    end
    return q                                    # return the solution vector
end
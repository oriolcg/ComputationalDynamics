# This file was generated, do not modify it. # hide
function dq(q,t)
    (u,v) = q              # unpack variables
    du = v                 # displacement time derivative is equal to velocity
    dv = (f(t)-k*u-c*v)/m  # acceleration from equation of motion
    dq = (du,dv)           # pack variables
end
function reflection_coefficients_to_reflected_voltage_signal(r::Vector{Float64}; t::Int=length(r), bounces::Float64=Inf, Vin::Vector{Float64}=[1.0],debug::Bool=false)
  if t < length(r)
    warn("time steps less than number of reflection coefficients")
  end
  t = t>length(r)?t:length(r) # number of time steps redefined in case t < length(r)
  # initialize output
  v = Vector{Float64}(t)
  # Incident on the right side (towards the source)
  R = t<length(r) ? MesaArray(t,t) : MesaArray(t,length(r))
  # Incident of the left side (away from the source)
  L = t<length(r) ? MesaArray(t,t) : MesaArray(t,length(r))
  # Interpret a constant TDR voltage as an array of voltages of identical
  # values
  if (length(Vin) == 1)
    L[1,:] = Vin[1]
  elseif (length(Vin) == t)
    # The TDR is incident on the entire i=1 line.
    L[1,:] = Vin[1:t]
  end
  # Set up the initial condition
  v[1] = r[1]*Vin[1]
  # step through time
  for i = 2:t
    # For every time step I need to calculate
    # 1) L[k,m] with k+m = i+1 and m going from 1 to i-1
    # 2) R[k,m] with k+m = i+1 and k going from 1 to i-1
    # But, the logic for the apex (i,1) is a bit different than for
    # all of the other values of (k,m) for k+m=i+1, since there is only one
    # reflection/contribution, there. So, I need to handle this logic separately.
    # It's best to calculate this first, since R[i-1,2] is needed to callculate
    # everything closer to the source

    # Don't go deeper than we have reflection coefficients
    if i<=length(r)
      L[i,1] = L[i-1,1]*(1-r[i-1])
      R[i-1,2] = L[i,1]*r[i]
      # start right below the apex, working back to the source
      for j = 2:1:i-1
        L[(i+1)-j,j] = (1-r[i-j])*L[i-j,j] + R[i-j,j]*(-r[i-j])
        R[i-j,j+1] = r[(i+1)-j]*L[i-j+1,j] + (1+r[(i+1)-j])*R[i-j+1,j]
      end
    else
      #no apex exists
      L[length(r),i-length(r)+1] = R[length(r)-1,i-length(r)+1]*(-r[end-1]) +
                                   L[length(r)-1,i-length(r)+1]*(1-r[end-1])
      R[length(r)-1,i-length(r)+2] = L[length(r),i-length(r)+1]*r[end]
      #go from length(r)-1 to 2
      for j = 2:length(r)-1
        Li = length(r) - (j-1)
        Lj = (i-length(r)) + j
        Ri = Li-1; Rj = Lj+1
        L[Li,Lj] = (1-r[length(r)-j])*L[Li-1,Lj] + R[Li-1,Lj]*(-r[length(r)-j])
        R[Ri,Rj] = r[length(r)-j+1]*L[Ri+1,Rj-1] + (1+r[length(r)-j+1])*R[Ri+1,Rj-1]
      end
    end
    v[i] = L[1,i]*r[1] + R[1,i]*(1+r[1])
  end
  if debug
    return Dict("L" => L, "R" => R, "r" => r, "v" => v)
  else
    return v
  end
end

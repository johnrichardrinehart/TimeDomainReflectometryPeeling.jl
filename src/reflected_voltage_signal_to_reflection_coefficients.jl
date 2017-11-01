function reflected_voltage_signal_to_reflection_coefficients(v;Vin=1,debug::Bool=false)
   # Incident on the right side (towards the source)
   R = TriangularArray{Float64}(length(v))
   ## Incident of the left side (away from the source)
   L = TriangularArray{Float64}(length(v))
   # The TDR is incident on the entire i=1 line.
   if length(Vin) == 1
      L[1,:] = Vin[1]
   else
      L[1,:] = vcat(Vin, zeros(length(v)-length(Vin)))
   end

   # reflection coefficient
   r = Vector{Float64}(length(v))
   r[1] = v[1]/Vin[1];
   L[2,1] = (1-r[1])*Vin[1]
   for i = 2:length(v)
      # initialize r[i]
      r[i] = v[i] - L[1,i]*r[1]
      # remove the propagated transmissions of the left voltages along the
      # (i,j)=i+1 depth line (except the apex)
      for j = 1:i-2
         r[i] -= L[j+1,i-j]*r[j+1]*prod(map(x->1+x, r[1:j]))
      end
      # divide by magnitude of transmission coefficient from apex to source
      # times left apex wave
      r[i] /= L[i,1]*prod(map(x->1+x, r[1:i-1]))
      # calculate new right paths
      R[i-1,2] = r[i]*L[i,1]
      for j = i-2:-1:1
          if debug
              println("Making R[",j,",",i-j+1,"] using R[",j+1,",",i-j,"] with ",
                      " r[",j+1,"] and L[",j+1,",",i-j,"] with r[",j+1,"].")
          end
          R[j,i-j+1] = R[j+1,i-j]*(1+r[j+1]) + L[j+1,i-j]*r[j+1]
      end
      if i < length(v)
         #extend the tip along the j=1 line
         L[i+1,1] = (1-r[i])*L[i,1]
         #calculate new left paths
         for j = 2:i
             if debug
                 println("Making L[",i-j+2,",",j,"]")
             end
            L[i-j+2,j] = L[i-j+1,j] *(1-r[i-j+1]) + R[i-j+1,j]*(-r[i-j+1])
         end
      end
   end
   if debug
      return Dict("L" => L, "R" => R, "r" => r, "v" => v)
   else
      return r
   end
end

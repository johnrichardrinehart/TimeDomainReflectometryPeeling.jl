function reflected_voltage_signal_to_reflection_coefficients(v;Vin=1,debug::Bool=false)
   # Incident on the right side (towards the source)
   R = TriangularArray{Float64}(length(v))
   #[R.data[i] = 0 for i = 1:length(R.data)]
   ## Incident of the left side (away from the source)
   L = TriangularArray{Float64}(length(v))
   #[L.data[i] = 0 for i = 1:length(L.data)]
   # The TDR is incident on the entire i=1 line.
   println(size(L))
   if length(Vin) == 1
     L[1,:] = Vin[1]
   else
     L[1,:] = Vin
   end

   # reflection coefficient
   r = Vector{Float64}(length(v))
   r[1] = v[1]/Vin[1];
   L[2,1] = (1-r[1])*Vin[1]
   for i = 2:length(v)
#     println("On time step: ",i)
      # calculate the next reflection coefficient based on the latest info
      # remove the reflection at the i=1 line
      delta = v[i]-L[1,i]*r[1]
      # wind back delta until it's at the apex
      delta /= prod(map(x->(1+x),r[1:i-1]))
      # remove the propagated transmissions of the left voltages along the
      # (i+j-1)=depth line (except the apex)
      for j = 1:i-2

#        println("Subtracting L[",j+1,",",i-j,"]");
#        println("Dividing by product of following ref. coeff pairs: ",collect(j+1:i-1))

         # i-j-1 products of reflection coefficient terms
         temp = prod(map(x->1+x, r[j+1:i-1]))
         delta -= L[j+1,i-j]*r[j+1]/temp
      end
      # remove the effect of the apex bounce
      # check if nothing was tranmsitted (i.e. ρ=1)
      if abs(L[i,1]) > 1e-7
        r[i] = delta/L[i,1]
      else
#        println("Heyy")
        r[i] = r[i-1]
      end
      ## expand the node space based on the latest information
      # calculate the bounce from the apex
      R[i-1,2] = r[i]*L[i,1]

      #extend the tip along the i=1 line
      if i < length(v)
         L[i+1,1] = (1-r[i])*L[i,1]
      end
      # calculate new right paths
      for j = i-2:-1:1
         R[j,i-j+1] = R[j+1,i-j]*(1+r[j+1]) + L[j+1,i-j]*r[j+1]
      end
      if i < length(v)
         #calculate new left paths
         for j = 2:i
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

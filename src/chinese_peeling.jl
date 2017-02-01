function chinese_peeling(v;V_tdr=1)
   # Incident on the right side (towards the source)
   R = TriangularArray{Float64}(length(v)+1)
   [R.data[i] = NaN for i = 1:length(R.data)]
   # Incident of the left side (away from the source)
   L = TriangularArray{Float64}(length(v)+1)
   [L.data[i] = NaN for i = 1:length(L.data)]
   # The TDR is incident on the entire i=1 line.
   L[1,:] = V_tdr
   # reflection coefficient
   r = Vector{Float64}(length(v))
   r[1] = v[1]
   L[2,1] = 1-r[1]
   for i = 2:length(v)
      # calculate the next reflection coefficient based on the latest info
      # remove the reflection at the i=1 line
      r[i] = v[i]-L[1,i]*r[1]
      # remove the propagated transmissions of the left voltages along the
      # (i+j-1)=depth line (except the apex)
      for j = 1:i-2
         # generate the product of transmissio/reflection coefficients for a
         # particular j
         temp = 1;
         # k products of reflection coefficient terms
         for k=1:j
            temp *= (1+r[k])
         end
         r[i] -= L[j+1,i-j]*r[j+1]*temp
      end
      r[i] = r[i]/prod(map(x->(1+x),r[1:i-1]))/L[i,1]
      #expand the node space based on the latest information
      #extend the tip along the i=1 line
      L[i+1,1] = (1-r[i])*L[i,1]
      # calculate the bounce from the apex
      R[i-1,2] = r[i]*L[i,1]
      # calculate new right paths
      for j = i-2:-1:1
         R[j,i-j+1] = R[j+1,i-j]*(1+r[j+1]) + L[j+1,i-j]*r[j+1]
      end
      #calculate new left paths
      for j = 2:i
         L[i-j+2,j] = L[i-j+1,j]*(1-r[i-j+1]) - R[i-j+1,j]*r[i-j+1]
      end
   end
   return r
end

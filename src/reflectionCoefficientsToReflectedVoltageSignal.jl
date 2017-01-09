function reflectionCoefficientsToReflectedVoltageSignal(r,time_steps;bouncing_tolerance=Inf)
   v = Vector{Float64}(time_steps)
   v[1] = r[1]
   v[2] = r[1] + (1-r[1])*(1+r[1])*r[2]
   for i = 3:time_steps
      paths = generateAllPathsOfLengthN(i)
      #remove paths that require too many reflection coefficients
      filter!(x -> maximum(cumsum(x)) <= length(r), paths)
      #remove paths with too many bounces
      filter!(x -> count_sub_vecs([1,-1],x) < bouncing_tolerance, paths)
      if length(paths) == 0
         weights = 0
      else
         weights = map( x -> pathWeightCalculator(x,r[1:min(i,length(r))]), paths)
      end
      v[i] = v[i-1] + sum(weights)
   end
   return v
end

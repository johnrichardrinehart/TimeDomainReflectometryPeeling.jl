function reflectionCoefficientsToReflectedVoltageSignal(r, time_steps)
   v = Vector{Float64}(time_steps)
   v[1] = r[1]
   v[2] = r[1] + (1-r[1])*(1+r[1])*r[2]
   for i = 3:time_steps
      paths = generateAllPathsOfLengthN(i)
#      transitions = map(x -> transitionFromPath(x), paths)
      filter!(x -> maximum(cumsum(x)) <= length(r), paths)
      weights = map( x -> pathWeightCalculator(x,r[1:min(i,length(r))]), paths)
      v[i] = v[i-1] + sum(weights)
   end
   return v
end

function reflectedVoltageSignalToReflectionCoefficients(v)
   r = Vector{Float64}(length(v))
   r[1] = v[1]
   r[2] = (v[2]-v[1])/((1-r[1])*(1+r[1]))
   for time_step = 3:length(v)
      paths = generateAllPathsOfLengthN(time_step)
      transitions = map(x -> transitionFromPath(x), paths)
      # take out deepest transition
      filter!(x -> maximum(x) != time_step-1, transitions)
      # weights of all the paths but the deepest one
      weights = map(x -> pathWeightCalculator(x,r[1:time_step-1]), transitions)
      # partial weight of the deepest path
      partial_weight_deepest_path = prod(1-r[1:time_step-1])*prod(1+r[1:time_step-1])
      r[time_step] = (v[time_step] - v[time_step-1] - sum(weights))/partial_weight_deepest_path
   end
   return r
end

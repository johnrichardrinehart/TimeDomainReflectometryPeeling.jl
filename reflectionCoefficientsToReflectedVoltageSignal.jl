using Combinatorics
include("transitionsFromPaths.jl")
function reflectionCoefficientsToReflectedVoltageSignal(ref_coeffs, time_steps)
paths_amplitude = zeros(length(time_steps),1)
#for i = 1:time_steps
for i = 3
  # the below generates all valid paths of length.
  # note that these paths lack the initial 1 (entering) and the last -1 (exiting)
  paths = filter(path -> !any(cumsum(path).<0),multiset_permutations(vcat(ones(Int,i),-ones(Int,i)),2*i))
  cur_transitions = transitionsFromPaths(collect(paths))
  return cur_transitions
#  depths = max(ref_coeffs,2);
  # time_steps may be greater than number of reflection planes
  #filter!(x -> not(max(x) > size(ref_coeffs,1)),cur_transitions); # update cur_transitions
end
end

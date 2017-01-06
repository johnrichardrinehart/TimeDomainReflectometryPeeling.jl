function transitionsFromPaths(paths)
# paths is a vactor of paths
# [+1, +1, -1, -1] is the following path: T_10 > R_21 > T_01
# -> [0,1,1,0]

transitions = Array{Array{Int8}}(length(paths))
for (path_idx,path) = enumerate(view(paths,1:length(paths)))
   transition = Array{Int8}(length(path))
   transition[1] = 0
   for (stage_idx, stage) = enumerate(view(path,1:length(path)-1))
      transition[stage_idx+1] = transition[stage_idx] + .5*(stage + path[stage_idx+1])
   end
   transitions[path_idx] = transition
end

return transitions
end

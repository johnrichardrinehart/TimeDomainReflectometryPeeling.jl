function transitionFromPath(path)
# path is a path vector in the form
# [+1, +1, -1, -1]. This is the following path: T_10 > R_21 > T_01
# -> transition [0,1,1,0]

transition = Array{Int8}(length(path))
transition[1] = 0
for (stage_idx, stage) = enumerate(view(path,1:length(path)-1))
   transition[stage_idx+1] = transition[stage_idx] + .5*(stage + path[stage_idx+1])
end
return transition
end

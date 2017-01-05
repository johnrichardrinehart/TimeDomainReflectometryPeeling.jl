function transitionsFromPaths(paths)
# paths is a vactor of paths
# [+1, +1, -1, -1] is the following path: T_10 > R_21 > T_01
# -> [[0,1,1],[1,2,1],[1,0,0]]

  num_steps = size(paths,1)
  transitions = zeros(size(paths,1),(num_steps-1)*3)
  cur_medium = zeros(size(paths,1),1);
  is_going_deeper = ones(size(paths,1),1);
  for i = 1:size(paths[1],1)-1
    is_transmission = map(x -> x[i]*x[i+1], paths) # +1 (trans) / -1 (ref)
    println(map(x-> x[i]*x[i+1],paths))
    # is_transmission = .5*(is_transmission + 1) # 1 == trans, 0 == ref
    # transitions[:,3*i-2:3*i] = [cur_medium,
    # cur_medium + 2*is_going_deeper-1 ,
    # cur_medium + is_transmission .* (2*is_going_deeper-1)] # describe transition
    # cur_medium = transitions[:,3*i] # update cur_medium
    # is_going_deeper = not(xor(is_going_deeper,is_transmission)) # update direction
    return is_transmission #temporary/debug
  end
  # return transitions
end

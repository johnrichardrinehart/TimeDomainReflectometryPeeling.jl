function path_weight_calculator(path,r;cur_medium=0,is_moving_deeper=true)
   path_amplitude = 1
   for (step, motion) in enumerate(view(path,2:length(path)))
      step += 1 # account for the shift because of the above `view`
      if (motion == 1) && (path[step-1] == motion)
         cur_medium += 1
         path_amplitude *= 1-r[cur_medium]
         is_going_deeper = true
      elseif (motion == -1) && (path[step-1] == motion)
         cur_medium -= 1
         path_amplitude *= 1+r[cur_medium+1]
         is_going_deeper = false
      elseif motion != path[step-1] && is_moving_deeper
         path_amplitude *= r[cur_medium+1]
         is_moving_deeper = !is_moving_deeper
      elseif motion != path[step-1] && !is_moving_deeper
         path_amplitude *= -r[cur_medium]
         is_moving_deeper = !is_moving_deeper
      end
   end
   return path_amplitude
end

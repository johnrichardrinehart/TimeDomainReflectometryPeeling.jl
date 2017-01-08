function pathWeightCalculator(path,r;cur_medium=0,is_moving_deeper=true)
   path_amplitude = 1
   for (idx,stage) in enumerate(view(path,2:length(path)))
      idx += 1 # account for the shift because of the above `view`
      if stage == path[idx-1] && is_moving_deeper
         path_amplitude *= 1-r[cur_medium+1]
         cur_medium += 1
         #prev_medium = path[idx-1]
         #@printf "From %d to %d.\t Amplitude:%f\n" prev_medium cur_medium path_amplitude
      elseif stage == path[idx-1] && !is_moving_deeper
         path_amplitude *= 1+r[cur_medium]
         cur_medium -= 1
         #prev_medium = path[idx-1]
         #@printf "From %d to %d.\t Amplitude:%f\n" prev_medium cur_medium path_amplitude
      elseif stage != path[idx-1] && is_moving_deeper
         path_amplitude *= r[cur_medium+1]
         is_moving_deeper = !is_moving_deeper
         #cur_medium = stage
         #prev_medium = stage + 1 # next medium
         #@printf "From %d to %d.\t Amplitude:%f\n" prev_medium cur_medium path_amplitude
      elseif stage == path[idx-1] && !is_moving_deeper
         path_amplitude *= -r[cur_medium]
         is_moving_deeper = !is_moving_deeper
         #cur_medium = stage
         #prev_medium = stage - 1 # previous medium
         #@printf "From %d to %d.\t Amplitude:%f\n" prev_medium cur_medium path_amplitude
      end
   end
   return path_amplitude
end

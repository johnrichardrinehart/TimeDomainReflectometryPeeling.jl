"""
k_means_tdr(v, n; change, times, maxiter, display)

Bins time-domain voltage vector with n bins.

#Optional arguments

change::Tuple(::Float64,::Int) - a tuple determining the
threshold slope for voltage change (::Float64) and the minimum number of points
that must exist in order to meet that requirement (::Int).

strip_times: Vector{Vector{Float64,2}} - a vector of vectors. Each inner vector
contains the indices of the start/stop points to remove from the binning procedure.
"""
function k_means_tdr(
                     v,
                     n;
                     change=(.0,0),
                     strip_times=[],
                     strip_times_assignments=[],
                     maxiter=200,
                     display=:none
                    )
   # loop through the n+1 segments finding where the edges are.
   edges = []
   # for n strip_items there are n+1 segments to loop through
   for i = eachindex(strip_times)
      if i == 1
         slice = 1:strip_times[1][1]-1
      else
         slice = strip_times[i-1][end]+1:strip_times[i][1]
      end
      if length(slice) > 0
         append!(edges, edge_detect(v[slice],change,start_idx=slice[1]))
      end
      if i == length(strip_times) # handle the case when i == length(strip_times)
         slice = strip_times[i][end]+1:length(v)
         if length(slice) > 0
            append!(edges, edge_detect(v[slice],change,start_idx=slice[1]))
         end
      end
   end

   # indices_to_bin is everything that's not in edges and in strip_times
   indices_to_bin = setdiff(1:length(v),unique(vcat(strip_times..., edges...)))

   ks = kmeans(
               reshape(v[indices_to_bin], 1, length(indices_to_bin)),
               n,
               maxiter=maxiter,
               display=display,
              )

   # allocate value for the result
   res = zeros(Int,length(v))
   res[indices_to_bin] = ks.assignments

   # bin the values that were manually stripped out (per the strip_times
   # argument
   closest_val_to_options(val; options=ks.centers) = findmin(abs(options-val))[2]
   for i in strip_times
      res[i] = closest_val_to_options(mean(v[i]))*ones(Int,length(i))
   end
   for edge in edges
      prior_idx = res[edge[1]-1] # stores the ks.centers index
      posterior_idx = res[edge[end]+1] # stores the ks.centers index
      binned_edges_idxs = closest_val_to_options.(
                                             v[edge];
                                             options=[ks.centers[prior_idx],ks.centers[posterior_idx]]
                                            )
      res[edge] = map(x -> [prior_idx,posterior_idx][x], binned_edges_idxs)
   end

   return (res, ks.centers, edges)
end

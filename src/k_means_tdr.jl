using Clustering
using TimeDomainReflectometryPeeling
"""
k_means_tdr(v, n; change, times)

Bins time-domain voltage vector with n bins.

#Optional arguments

change::Tuple(::Float64,::Int) - a tuple determining the
threshold slope for voltage change (::Float64) and the minimum number of points
that must exist in order to meet that requirement (::Int).

strip_times: Vector{Vector{Float64,2}} - a vector of vectors. Each inner vector
contains the indices of the start/stop points to remove from the binning procedure.
"""
function k_means_tdr(v,n; change=(.0,0), strip_times=[])
   if (change[2] > 0)
      # track the number of rises/falls
      count = 0
      # track the most recent direction (0 is down and 1 is up)
      d = -1
      # iterate through v counting how many times the voltage grows "too much"
      for i = 1:length(v)-1
         # count up how many consecutive instances of "change" there is
         # check if it went up (and has been up before)
         if (v[i+1] - v[i]) > change[1]
            if d == 1
               count += 1
            else
               if count >= change[2]
                  # check if there have been enough consecutive changes
                  # store the times that are to be stripped
                  append!(strip_times,[[i-count-1,i-1]])
               end
               count = 0
            end
            d = 1
            # check if it went down (and has been down before)
         elseif (v[i+1] - v[i]) < -change[1]
            if d == 0
               count += 1
            else
               if count >= change[2]
                  # check if there have been enough consecutive changes
                  # store the times that are to be stripped
                  append!(strip_times,[[i-count-1,i-1]])
               end
               count = 0
            end
            d = 0
         end
      end
   end
   println(size(v))
   # if there were any growing sequences then remove them
   if length(strip_times) > 0
      stripped_v = copy(v) # copy v to stripped_v
      strip_pairs!(stripped_v, strip_times)
      # stripped_v is the stripped voltage vector
   end
   if length(size(stripped_v)) == 1
      stripped_v = reshape(stripped_v,1,length(stripped_v))
   end
   # bin the data
   ks = kmeans(stripped_v,n)
   # turn back into a vector
   data = reshape(stripped_v,length(stripped_v))
   # map the data to the determined bins
   means = map(x -> ks.centers[x], ks.assignments)
   # bin the stripped data - note that the indices of ks.assignments do not
   # match the strip_times indices, because the strip_times indices reference
   # elements from v whose length is greater, now, than ks.assignments. We can
   # accommodate for this, however, by tracking how many values we've spliced
   # back into binned.
   insert_count = 0
   for i = 1:length(strip_times)
      # determine the bin values of the previous and subsequent levels
      init_idx = strip_times[i][1]
      end_idx = strip_times[i][2]

      println("start idx: ", init_idx, "\t", insert_count)
      println("end idx: ", end_idx, "\t", insert_count)
      p = ks.centers[ks.assignments[(init_idx-insert_count)-1]]
      println("p: ", p)
      s = ks.centers[ks.assignments[init_idx-insert_count+1]]
      println("s: ", s)

      binned = map(x -> abs(x-p)<abs(x-s)?p:s, v[init_idx:end_idx])
      splice!(means,init_idx:init_idx-1,binned)
      insert_count += length(binned)
   end
   return means
   #return Dict("centers" => ks.centers,
   #"binned" => means,)
end

function strip_pairs!(a, p)
   #removed_index_sum = 0
   for i = length(p):-1:1
      println("Stripping indices ", p[i][1], ":", p[i][2],".")
      splice!(a, p[i][1]:p[i][2])
   end
   return a
end

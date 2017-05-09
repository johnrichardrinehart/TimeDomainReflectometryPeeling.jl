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
               count +=1
            end
            d = 1
            # check if it went down (and has been down before)
         elseif (v[i+1] - v[i]) < -change[1]
            if d == 0
               count += 1
            end
            d = 0
            # check if it just stopped going up/down
         else
            # check if there have been enough consecutive changes
            if count >= change[2]
               # store the times that are to be stripped
               append!(strip_times,[[i-count+1,i]])
               count = 0
            end
         end
      end
   end
   # if there were any growing sequences then remove them
   if length(strip_times) > 0
      res = strip_pairs(v, strip_times)
      # stripped_v is the stripped voltage vector
      stripped_v = res
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
   # bin the stripped data
   for i = 1:length(strip_times)
      # determine the bin values of the previous and subsequent levels
      init_idx = strip_times[i][1]
      end_idx = strip_times[i][2]
      p = ks.centers[ks.assignments[init_idx-1]]
      s = ks.centers[ks.assignments[end_idx+1]]
      binned = map(x -> abs(x-p)<abs(x-s)?p:s, v[init_idx:end_idx])
      splice!(means,init_idx:init_idx-1,binned)
   end
   return means
   #return Dict("centers" => ks.centers,
               #"binned" => means,)
end

function strip_pairs(a, p)
   for i = 1:length(p)
      splice!(a, p[i][1]:p[i][2])
   end
   return a
end

"""
k_means_tdr(v, n; change, times, maxiter, display)

Bins time-domain voltage vector with n bins.

#Optional arguments

change::Tuple(::Float64,::Int) - a tuple determining the
threshold slope for voltage change (::Float64) and the minimum number of points
that must exist in order to meet that requirement (::Int).

edges: Vector{Vector{Float64,2}} - a vector of vectors. Each inner vector
contains the indices of the start/stop points to remove from the binning procedure.
"""
function k_means_tdr(
                     v,
                     k;
                     change=(.0,0),
                     edges=[],
                     maxiter=200,
                     display=:none,
                     remove_edges=false,
                     debug=false,
                    )
    segments=[]
    temp=[]
    # find the edges and store them
    # loop through the n+1 segments finding where the edges are.
    if remove_edges
        # for n strip_items there are n+1 segments to loop through
        for i = 1:length(edges)
            # if we're on the first slice and it's longer than 0
            if i == 1
                append!(segments, [1:edges[1][1]-1])
            elseif i > 1 # middle cases
                append!(segments, [edges[i-1][end]+1:edges[i][1]-1])
            end
            if i == length(edges)
                append!(segments, [edges[i][end]+1:length(v)])
            end
        end
    end
    if debug
        println("Segment Locations: ", segments)
        println("Edges Locations: ", edges)
    end

    # indices_to_bin is everything that's not in edges
    indices_to_bin = setdiff(1:length(v),vcat(edges...))

    ks = kmeans(
                reshape(v[indices_to_bin], 1, length(indices_to_bin)),
                k,
                maxiter=maxiter,
                display=display,
               )

    # allocate res, the result, which will be modified
    res = map(x ->ks.centers[x], ks.assignments)
    cum = 1
    count = 0
    for segment in segments
        if debug
            println("\nres is length: ", length(res))
        end
        count += 1 # segment we're on
        working_domain = cum:cum+length(segment)-1
        if debug
            println("\nIndices to segmentize: ", working_domain)
            println("Correcting ", length(working_domain), " many values.")
            println("Segmentized values: ",
                    segmentize(res[working_domain], ks.centers))
        end
        # correct the segment we're working on
        res[working_domain] = segmentize(res[working_domain], ks.centers)
        # group the values of the edge
        # Clean up edges; this must occur after segment 2 has been clustered
        if count > 1
            working_domain = edges[count-1][1]:edges[count-1][end]
            if debug
                println("\nCleaning up edge.")
                println("working_domain is: ", working_domain)
                println("Adding on ", length(working_domain), " values.")
            end
            splice!(
                   res,
                   working_domain[1]:working_domain[1]-1,
                   deedge(v[working_domain],res[cum-1],res[cum+1])
                  )
        end
        # increment the pointer to the next segment
        if count > 1
            cum += length(segment) + length(edges[count-1])
            if debug
                println("\ncum is now: ", cum)
            end
        elseif count == 1
            cum += length(segment)
            if debug
                println("\ncum is now: ", cum)
            end
        end
    end

    if length(res) != length(v)
        error("Number of clustered voltage samples does not match number of provided
              samples. Check your `edges` array. length(res):", length(res),";
              length(v): ",length(v),".")
    end
    return Dict("clustered_data" => res, "means" => ks.centers)
end

function segmentize(s,cs)
    return map(x->cs[findmin(abs.(cs.-mean(s)))[2]],s)
end

function deedge(edge,v1,v2)
    vs = [v1,v2]
    return map(x -> vs[findmin(abs.(x-vs))[2]],edge)
end

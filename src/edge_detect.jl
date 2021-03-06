# edge_detect takes in a sequence of numbers and some edge test criteria. It returns
# an array of indices in which the sequence of voltage is increasing/decreasing
# consistent with an edge
function edge_detect(v, c; start_idx = 1,debug=false,)
    start_idx -= 1 # shift it down 1 to fix an off-by-one error
    # initialize result container - will be populated with tuples of indices to remove
    res = []
    if c[2] <= 0 && length(v) > c[2]
        return [1,length(v)]
    end

    count = 0 # track the number of rises and falls

    for i = 2:length(v)
        # count up how many consecutive instances of "change" there is
        # check if it went up/down (and has been up before)
        if (v[i] - v[i-1] > c[1] && v[i+1] - v[i] > c[1]) ||
            (v[i] - v[i-1] < -c[1] && v[i+1] - v[i] < -c[1])
            if debug
                println("Growing up/down at index pair ", start_idx+i-1,":",start_idx+i,".")
            end
            count += 1
            # it hasn't been growing
        else
            if count >= c[2]
                if length(res) > 0 && res[end][2] == i-count-1
                    push!(res,i+start_idx-count:start_idx + i)
                    if debug
                        println("It's changed enough from ", "(", start_idx+i-count, ",", i,").")
                    end
                else
                    push!(res,i+start_idx-count-1:start_idx + i)
                    if debug
                        println("It's changed enough from ", "(", start_idx+i-count-1, ",", i,").")
                    end
                end
            end
            count = 0
        end
    end
    # check if changed enough at the end
    if count >= c[2]
        if length(res) > 0 && res[end][2] == length(v)-count-1
            if debug
                println("It's changed enough from ", "(", length(v)-count, ",",
                        length(v),").")
            end
            push!(res,start_idx + length(v)-count:start_idx+length(v))
        else
            push!(res,start_idx + length(v)-count-1: start_idx+length(v))
            if debug
                println("It's changed enough from ", "(", length(v)-count-1, ",",
                        length(v),").")
            end
        end
    end

    # if no result was found then return a range that, when used by
    # split_by_indices() returns the entire voltage vector
    if length(res) > 0
        return res
    else
        println("no edges foound")
    end
end

function generateAllPathsOfLengthN(n::Int)
   depth = n - 1
   if depth == 0
      return [[Int8(1), Int8(-1)]]
   end
   paths = collect(filter(path -> !any(cumsum(path).<0),
                          multiset_permutations(vcat(ones(Int8,depth),-ones(Int8,depth)),2*depth)))
   unshift!.(paths,Int8(1))
   push!.(paths,Int8(-1))
   return paths
end

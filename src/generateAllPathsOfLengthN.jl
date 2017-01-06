function generateAllPathsOfLengthN(n::Int)
 return filter(path -> !any(cumsum(path).<0), multiset_permutations(vcat(ones(Int8,n),-ones(Int8,n)),2*n))
end

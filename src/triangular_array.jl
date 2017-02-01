tri(n) = n*(n+1) >> 1

type TriangularArray{T} <: AbstractArray{T,2}
   data::Vector{T}
   depth::Int
   TriangularArray(n) = new(Vector{T}(tri(n)),n)
end

Base.size(T::TriangularArray) =(T.depth,T.depth)
Base.linearindexing(::TriangularArray) = Base.LinearSlow()
Base.setindex!(T::TriangularArray,x::Number,i::Int) = (T.data[i]=x)
function Base.setindex!(T::TriangularArray,x::Number,i::Int,j::Int)
   if i+j-1>T.depth
      return NaN
   else
      v = 0
      for k = 0:i-2
         v += T.depth - k
      end
      v+=j
      T.data[v] = x
    end
end


Base.getindex{T}(A::TriangularArray{T}, i::Int) = get(A.data,i,NaN)

function Base.getindex{T}(A::TriangularArray{T}, i::Int, j::Int)::T
   if i+j-1>A.depth
      NaN
   else
      v = 0
      for k = 0:i-2
         v += A.depth - k
      end
      v+=j
      A.data[v]
    end
end

function Base.replace_in_print_matrix(T::TriangularArray,i::Integer,j::Integer,s::AbstractString)
   i+j-1>T.depth?"":s
end

# Below courtesy of TotalVerb
#triangular(n) = (n * (n+1)) >> 1

 #code
#immutable StorageLowerTriangular{T <: AbstractFloat} <: AbstractArray{T, 2}
    #width::Int
    #data::Vector{T}
    #StorageLowerTriangular(n) = new(n, Vector{T}(triangular(n)))
#end

#Base.size(A::StorageLowerTriangular) = (A.width, A.width)
#Base.linearindexing(::StorageLowerTriangular) = Base.LinearSlow()

#function Base.getindex{T}(A::StorageLowerTriangular{T}, x::Int, y::Int)::T
    #if y > x
        #NaN
    #else
        #A.data[triangular(y-1) + x]
    #end
#end

#function Base.replace_in_print_matrix(A::StorageLowerTriangular,i::Integer,j::Integer,s::AbstractString)
    #i>=j ? s : Base.replace_with_centered_mark(s)
#end

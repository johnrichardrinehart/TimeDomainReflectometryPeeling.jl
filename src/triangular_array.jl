tri(n) = n*(n+1) >> 1

type TriangularArray{T<:Number} <: AbstractArray{T,2}
   data::Vector{T}
   depth::Int
   TriangularArray(n) = new(zeros(T,tri(n)),n)
end
TriangularArray(n) = TriangularArray{Float64}(n)

Base.size(T::TriangularArray) = (T.depth,T.depth)
Base.linearindexing(::TriangularArray) = Base.LinearSlow()
Base.setindex!(T::TriangularArray,x::Number,i::Int) = (T.data[i]=x)

function Base.setindex!(T::TriangularArray,x::Number,i::Int,j::Int)
   if i+j-1>T.depth
     println("Trying to access array at: ", (i,j))
      throw(BoundsError)
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
   if i+j-1 <= A.depth
      v = 0
      for k = 0:i-2
         v += A.depth - k
      end
      v+=j
      A.data[v]
   else
      return NaN
   end
end

function Base.replace_in_print_matrix(T::TriangularArray,i::Integer,j::Integer,s::AbstractString)
   i+j-1>T.depth?"":s
end

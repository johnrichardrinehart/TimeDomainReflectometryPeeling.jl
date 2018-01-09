# MesaArray - used for any case where the number of time steps is greater than
# the number of reflection planes
type MesaArray{T} <: AbstractArray{T,2}
   data::Vector{T}
   width::Int
   height::Int
   MesaArray{T}(w,h) where T = begin
     if h > w
       throw("height can not be greater than the width")
     end
    return new(zeros(T,Int(.5*w*(w+1)-.5*(w-h)*(w-h+1))),w,h)
   end
end
MesaArray(w::Int,h::Int) = MesaArray{Float64}(w,h)


Base.getindex{T}(M::MesaArray{T}, i::Int) = get(M.data,i,NaN)

function Base.getindex{T}(M::MesaArray{T}, i::Int, j::Int)::T
   if i <= M.height || j < M.width-(i-1)
     # value in linear index
      v = 0
      for k = 0:i-2
        # add up all of the lengths of the rows up to the last row
         v += M.width - k
      end
      v+=j
      return M.data[v]
    end
end

function Base.replace_in_print_matrix(M::MesaArray,i::Integer,j::Integer,s::AbstractString)
   (i>M.height||j>M.width-(i-1))?"":s
end

Base.size(M::MesaArray) = (M.height,M.width)
Base.IndexStyle(::MesaArray) = Base.IndexCartesian()
Base.setindex!(M::MesaArray,x::Number,i::Int) = (M.data[i]=x)

function Base.setindex!(M::MesaArray,x::Number,i::Int,j::Int)
   if i > M.height || j > M.width-(i-1)
     println("Trying to access array at: ", (i,j))
      throw(BoundsError)
   else
      v = 0
      # Add all of the whole rows along the i axis
      for k = 0:i-2
         v += M.width - k
      end
      # jth column
      v+=j
      M.data[v] = x
    end
end

# TriangularArray - used for any case where the number of time steps is equal to
# the number of reflection planes
tri(n) = n*(n+1) >> 1

type TriangularArray{T<:Number} <: AbstractArray{T,2}
   data::Vector{T}
   depth::Int
   TriangularArray{T}(n) where T = new(zeros(T,tri(n)),n)
end
TriangularArray(n) = TriangularArray{Float64}(n)

Base.size(T::TriangularArray) = (T.depth,T.depth)
Base.IndexStyle(::TriangularArray) = Base.IndexCartesian()
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

type MesaArray{T} <: AbstractArray{T,2}
   data::Vector{T}
   width::Int
   height::Int
   MesaArray(w,h) = begin
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
Base.linearindexing(::MesaArray) = Base.LinearSlow()
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

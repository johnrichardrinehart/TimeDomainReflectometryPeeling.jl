function count_sub_vecs(v,V)
   count = 0
   for i = 1:(length(V)-length(v)+1)
      if v == view(V,i:(i+length(v)-1))
         count += 1
      end
   end
   return count
end

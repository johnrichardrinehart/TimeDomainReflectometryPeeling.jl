function relative_reflection_coefficients_to_absolute_impedances(rs; Z0=50)
   Zs = zeros(length(rs))
   Zs[1] = Z0 * (1+rs[1])/(1-rs[1])
   for i = 2:length(rs)
      Zs[i] = Zs[i-1] * (1+rs[i])/(1-rs[i])
   end
   return Zs
end

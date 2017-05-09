function absolute_impedances_to_relative_reflection_coefficients(Z)
   return map((x,y) -> (y-x)/(y+x), [Z[1:end-1]...], Z[2:end])
end

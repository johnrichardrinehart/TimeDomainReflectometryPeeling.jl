# transformations.jl - a set of utilities that allow for converting between:
#
#    +--->  +-->
#   Z     R     A
#    <---+
#
# Z: Impedances of each section
# R: Relative reflection coefficients (Z[i+1]+Z[i])/(Z[i+1] - Z{i])
# A: Absolute reflection coefficients: (Z[i]+Z0)/(Z[i]-Z0)

function relative_reflection_coefficients_to_impedances(rs; Z0=50)
   Zs = zeros(length(rs))
   Zs[1] = Z0 * (1+rs[1])/(1-rs[1])
   for i = 2:length(rs)
      Zs[i] = Zs[i-1] * (1+rs[i])/(1-rs[i])
   end
   return Zs
end

function relative_reflection_coefficients_to_absolute_reflection_coefficients(rhos)
    pluses = zeros(length(rhos))
    minuses = zeros(length(rhos))
    for i = 1:length(rhos)
        pluses[i] = prod(map(x->1+x,rhos[1:i]))
        minuses[i] = prod(map(x->1-x,rhos[1:i]))
    end
    res = (pluses - minuses)./(pluses + minuses)
    return res
end

function impedances_to_relative_reflection_coefficients(Z)
   return map((x,y) -> (y-x)/(y+x), [Z[1:end-1]...], Z[2:end])
end

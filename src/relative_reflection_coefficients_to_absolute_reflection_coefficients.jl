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

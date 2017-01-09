function relative_reflection_coefficients_to_absolute_impedances(ref_coeffs, ref_impedance)
   impedances = zeros(length(ref_coeffs),1)
   impedances[1] = ref_impedance * (1+ref_coeffs[1])/(1-ref_coeffs[1])
   for i = 2:length(ref_coeffs)
      impedances[i] = impedances[i-1] * (1+ref_coeffs[i])/(1-ref_coeffs[i])
   end
   return impedances
end

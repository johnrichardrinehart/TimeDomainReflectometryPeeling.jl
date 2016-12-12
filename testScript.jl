function reflectionCoefficientFromImpedances(Z1,Z2)
   (Z1-Z2)/(Z1+Z2)
end
orig_ref_coeffs = reshape([0:5;1:6;0:5;zeros(6,1)],6,4)
impedances = [30  80  50  80  30  50;
              50  30  80  50  80  30]
orig_reflection_coefficients =
reflectionCoefficientFromImpedances.(impedances[1,:],impedances[2,:])
orig_ref_coeffs_matrix = hcat(orig_ref_coeffs, orig_reflection_coefficients)

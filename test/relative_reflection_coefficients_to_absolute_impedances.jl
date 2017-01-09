@test relative_reflection_coefficients_to_absolute_impedances(.25,50) ≈ [500/6]
@test isinf(relative_reflection_coefficients_to_absolute_impedances(1,50))[1]
@test relative_reflection_coefficients_to_absolute_impedances([0,.25,-.5,-1],50) ≈ [50,83.333333333,27.777777,0]
@test relative_reflection_coefficients_to_absolute_impedances([.25],30) ≈ [50]

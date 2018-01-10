@test relative_reflection_coefficients_to_impedances(.25,Z0=50) ≈ [500/6]
@test isinf.(relative_reflection_coefficients_to_impedances(1,Z0=50))[1]
@test relative_reflection_coefficients_to_impedances([0,.25,-.5,-1],Z0=50) ≈ [50,83.333333333,27.777777,0]
@test relative_reflection_coefficients_to_impedances([.25],Z0=30) ≈ [50]

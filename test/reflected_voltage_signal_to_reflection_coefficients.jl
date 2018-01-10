@test reflected_voltage_signal_to_reflection_coefficients([-.25,.176,.053,.164,-.064,-.133,.018,0.0,-.031,0.02]) ≈ [-.25,50/110,-30/130,30/130,-50/110,.25,0,0,0,0] atol=1e-2
@test isapprox(reflected_voltage_signal_to_reflection_coefficients(reflection_coefficients_to_reflected_voltage_signal([.2,.3,-.1,.1],t=4)),[.2,.3,-.1,.1])
@test reflected_voltage_signal_to_reflection_coefficients(reflection_coefficients_to_reflected_voltage_signal([.2,.3,-.1,.1],t=4)) ≈ [.2,.3,-.1,.1] atol=1e-2

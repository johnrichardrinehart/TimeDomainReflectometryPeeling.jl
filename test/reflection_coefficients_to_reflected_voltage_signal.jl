@test reflection_coefficients_to_reflected_voltage_signal([0,0,1],3) == [0,0,1]
@test isapprox(reflection_coefficients_to_reflected_voltage_signal(reflected_voltage_signal_to_reflection_coefficients([.2,.3,-.1,.1]),4),[.2,.3,-.1,.1])
@test_approx_eq_eps(reflection_coefficients_to_reflected_voltage_signal([-.25,50/110,-30/130,30/130,-50/110,.25],10),[-.25,.176,.053,.164,-.064,-.133,.018,0.0,-.031,0.02],1e-3)
@test_approx_eq_eps(reflection_coefficients_to_reflected_voltage_signal([-.25,50/110,-30/130,30/130,-50/110,.25],4,bouncing_tolerance=1), [-.25,.176136,.176136,.176136],1e-3)

# num time steps < number reflection coefficients
t = rand(500:600)
rs = rand(.2:1e-4:.8,rand(700:800))
v = reflection_coefficients_to_reflected_voltage_signal(rs,t)
@test isapprox(reflected_voltage_signal_to_reflection_coefficients(v),rs[1:length(v)],atol=1e-4)
# num time steps > number reflection coefficients
t = rand(700:800)
rs = rand(0:1e-4:1,rand(500:600))
v = reflection_coefficients_to_reflected_voltage_signal(rs,t)
@test isapprox(reflected_voltage_signal_to_reflection_coefficients(v)[1:length(rs)],rs,atol=1e-4)
# They're the same length
t = 100
rs = rand(0:1e-4:1,t)
v = reflection_coefficients_to_reflected_voltage_signal(rs,t)
@test isapprox(reflected_voltage_signal_to_reflection_coefficients(v),rs,atol=1e-4)

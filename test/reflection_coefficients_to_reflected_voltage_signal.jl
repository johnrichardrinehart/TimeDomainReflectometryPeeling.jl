# num time steps < number reflection coefficients
Zs = rand(10:1e-2:100,25)
rs = absolute_impedances_to_relative_reflection_coefficients(Zs)
v = reflection_coefficients_to_reflected_voltage_signal(rs)
@test isapprox(reflected_voltage_signal_to_reflection_coefficients(v),
               rs,
               atol=1e-4)

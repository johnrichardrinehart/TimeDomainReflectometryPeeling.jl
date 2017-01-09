using Base.Test
using TimeDomainReflectometryPeeling
@testset "TimeDomainReflectometryPeeling Tests" begin
   @time @testset "relative_reflection_coefficients_to_absolute_impedances" begin
      include("./relative_reflection_coefficients_to_absolute_impedances.jl")
   end
   @time @testset "reflection_coefficients_to_reflected_voltage_signal" begin
      include("./reflection_coefficients_to_reflected_voltage_signal.jl")
   end
   @time @testset "reflected_voltage_signal_to_reflection_coefficients" begin
      include("./reflected_voltage_signal_to_reflection_coefficients.jl")
   end
end

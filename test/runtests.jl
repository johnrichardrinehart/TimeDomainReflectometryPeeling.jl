using Base.Test
using TimeDomainReflectometryPeeling
@testset "TimeDomainReflectometryPeeling Tests" begin
   @time @testset "relativeReflectionCoefficientsToAbsoluteImpedances" begin
      include("./relativeReflectionCoefficientsToAbsoluteImpedances.jl")
   end
   @time @testset "reflectionCoefficientsToReflectedVoltageSignal" begin
      include("./reflectionCoefficientsToReflectedVoltageSignal.jl")
   end
   @time @testset "reflectedVoltageSignalToReflectionCoefficients" begin
      include("./reflectedVoltageSignalToReflectionCoefficients.jl")
   end
end

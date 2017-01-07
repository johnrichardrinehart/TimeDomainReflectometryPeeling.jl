using Base.Test
using TimeDomainReflectometryPeeling
@testset "TDRPeeling Tests" begin
   @test relativeReflectionCoefficientsToAbsoluteImpedances(1,50) == Inf
end

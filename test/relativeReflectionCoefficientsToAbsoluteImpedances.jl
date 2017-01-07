@test relativeReflectionCoefficientsToAbsoluteImpedances(.25,50) ≈ [500/6]
@test isinf(relativeReflectionCoefficientsToAbsoluteImpedances(1,50))[1]
@test relativeReflectionCoefficientsToAbsoluteImpedances([0,.25,-.5,-1],50) ≈ [50,83.333333333,27.777777,0]
@test relativeReflectionCoefficientsToAbsoluteImpedances([.25],30) ≈ [50]

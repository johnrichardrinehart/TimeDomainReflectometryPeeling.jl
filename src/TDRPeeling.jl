module TDRPeeling

using Combinatorics

include("./reflectionCoefficientsToReflectedVoltageSignal.jl")
include("./transitionFromPath.jl")
include("./relativeReflectionCoefficientsToAbsoluteImpedances.jl")
include("./generateAllPathsOfLengthN.jl")
include("./pathWeightCalculator.jl")
include("./reflectedVoltageSignalToReflectionCoefficients.jl")

export reflectionCoefficientsToReflectedVoltageSignal
export relativeReflectionCoefficientsToAbsoluteImpedances
export reflectedVoltageSignalToReflectionCoefficients

end

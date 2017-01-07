module TDRPeeling

using Combinatorics

include("./reflectionCoefficientsToReflectedVoltageSignal.jl")
include("./transitionFromPath.jl")
include("./relativeReflectionCoefficientsToAbsoluteImpedances.jl")
include("./generateAllPathsOfLengthN.jl")
include("./pathWeightCalculator.jl")
include("./reflectedVoltageSignalToReflectionCoefficients.jl")

export reflectionCoefficientsToReflectedVoltageSignal
export transitionFromPath
export relativeReflectionCoefficientsToAbsoluteImpedances
export generateAllPathsOfLengthN
export pathWeightCalculator
export reflectedVoltageSignalToReflectionCoefficients

end

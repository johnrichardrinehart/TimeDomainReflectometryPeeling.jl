module TimeDomainReflectometryPeeling

import Combinatorics

include("./reflectionCoefficientsToReflectedVoltageSignal.jl")
include("./relativeReflectionCoefficientsToAbsoluteImpedances.jl")
include("./generateAllPathsOfLengthN.jl")
include("./pathWeightCalculator.jl")
include("./reflectedVoltageSignalToReflectionCoefficients.jl")
include("./count_sub_vecs.jl")

export reflectionCoefficientsToReflectedVoltageSignal
export relativeReflectionCoefficientsToAbsoluteImpedances
export reflectedVoltageSignalToReflectionCoefficients

end

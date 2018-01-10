__precompile__()
module TimeDomainReflectometryPeeling

using Clustering

# Algorithms
include("./reflection_coefficients_to_reflected_voltage_signal.jl")
include("./reflected_voltage_signal_to_reflection_coefficients.jl")
# Utils
include("./transformations.jl")
include("./k_means_tdr.jl")
include("./edge_detect.jl")
# Types
include("./types.jl")

# Algorithms
export reflection_coefficients_to_reflected_voltage_signal
export reflected_voltage_signal_to_reflection_coefficients
export reflected_voltage_signal_to_absolute_reflection_coefficients
# Utils
export relative_reflection_coefficients_to_impedances
export impedances_to_relative_reflection_coefficients
export k_means_tdr
# Types
export TriangularArray
export MesaArray

end

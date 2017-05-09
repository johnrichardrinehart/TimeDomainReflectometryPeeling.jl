module TimeDomainReflectometryPeeling

#import Combinatorics

# Algorithms
include("./reflection_coefficients_to_reflected_voltage_signal.jl")
include("./reflected_voltage_signal_to_reflection_coefficients.jl")
# Utils
include("./relative_reflection_coefficients_to_absolute_impedances.jl")
include("./absolute_impedances_to_relative_reflection_coefficients.jl")
include("./k_means_tdr.jl")
# Types
include("./triangular_array.jl")
include("./mesa_array.jl")

# Algorithms
export reflection_coefficients_to_reflected_voltage_signal
export reflected_voltage_signal_to_reflection_coefficients
# Utils
export relative_reflection_coefficients_to_absolute_impedances
export absolute_impedances_to_relative_reflection_coefficients
export k_means_tdr
# Types
export TriangularArray
export MesaArray

end

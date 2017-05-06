module TimeDomainReflectometryPeeling

#import Combinatorics

include("./reflection_coefficients_to_reflected_voltage_signal.jl")
include("./relative_reflection_coefficients_to_absolute_impedances.jl")
include("./generate_all_paths_of_length_n.jl")
include("./path_weight_calculator.jl")
include("./reflected_voltage_signal_to_reflection_coefficients.jl")
include("./count_sub_vecs.jl")
include("./triangular_array.jl")
include("./mesa_array.jl")

export reflection_coefficients_to_reflected_voltage_signal
export relative_reflection_coefficients_to_absolute_impedances
export reflected_voltage_signal_to_reflection_coefficients
export TriangularArray
export MesaArray

end

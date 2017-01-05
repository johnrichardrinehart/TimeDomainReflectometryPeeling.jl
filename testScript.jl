workspace()
include("reflectionCoefficientsToReflectedVoltageSignal.jl")
design_impedances = [30  80  50  80  30  50;
                     50  30  80  50  80  30]
design_reflection_coefficients = map((x,y)->(x-y)/(x+y),design_impedances[1,:],design_impedances[2,:])
reflection_coefficient_matrix = hcat(reshape([0:5;1:6;0:5;zeros(6,1)],6,4), design_reflection_coefficients)

reflected_voltage_signal = reflectionCoefficientsToReflectedVoltageSignal(reflection_coefficient_matrix,11)

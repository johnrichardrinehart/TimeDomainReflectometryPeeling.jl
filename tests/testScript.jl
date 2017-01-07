using TDRPeeling
z = [50,30,80,50,80,30,50]
r = [((z[i+1]-z[i])/(z[i+1]+z[i])) for i=1:length(z)-1]
v = reflectionCoefficientsToReflectedVoltageSignal(r,12)
c = reflectedVoltageSignalToReflectionCoefficients(v)
z_f = relativeReflectionCoefficientsToAbsoluteImpedances(c,50)

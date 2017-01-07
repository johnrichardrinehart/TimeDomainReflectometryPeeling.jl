@test reflectionCoefficientsToReflectedVoltageSignal([0,0,1],3) == [0,0,1]
@test isapprox(reflectionCoefficientsToReflectedVoltageSignal(reflectedVoltageSignalToReflectionCoefficients([.2,.3,-.1,.1]),4),[.2,.3,-.1,.1])
@test_approx_eq_eps(reflectionCoefficientsToReflectedVoltageSignal([-.25,50/110,-30/130,30/130,-50/110,.25],10),[-.25,.176,.053,.164,-.064,-.133,.018,0.0,-.031,0.02],1e-3)

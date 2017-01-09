@test_approx_eq_eps(reflectedVoltageSignalToReflectionCoefficients([-.25,.176,.053,.164,-.064,-.133,.018,0.0,-.031,0.02]),[-.25,50/110,-30/130,30/130,-50/110,.25,0,0,0,0],1e-2)
@test isapprox(reflectedVoltageSignalToReflectionCoefficients(reflectionCoefficientsToReflectedVoltageSignal([.2,.3,-.1,.1],4)),[.2,.3,-.1,.1])
@test_approx_eq_eps(reflectedVoltageSignalToReflectionCoefficients(reflectionCoefficientsToReflectedVoltageSignal([.2,.3,-.1,.1],4),bouncing_tolerance=1), [.2,.3,-.11978,.110776], 1e-3)

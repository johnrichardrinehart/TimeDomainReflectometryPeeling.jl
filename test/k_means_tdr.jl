first_section = .1*rand(30)+1
edge_1 = [.5,0,-.5]
second_section= - -.1*rand(30)-1
edge_2 = [-.5]
third_section = .1*rand(30)
vs = vcat(first_section, edge_1,second_section,edge_2,third_section)
ks = 6 # number of clusters
(res, ks_centers) = TimeDomainReflectometryPeeling.k_means_tdr(vs,ks,change=(1e-1,1),remove_edges=true)

first_section = .1*rand(30)+1
edge_1 = [.5,0,-.5]
second_section= - -.1*rand(30)-1
edge_2 = [-.5]
third_section = .1*rand(30)
vs = vcat(first_section, edge_1,second_section,edge_2,third_section)
ks = 6 # number of clusters
(res, ks_centers, edges) = TimeDomainReflectometryPeeling.k_means_tdr(vs,ks,change=(1e-1,0),remove_edges=true)

if edge_1 != edges[1] || edge_2 != edges[2]
    error("Bad calculation of the edges.")
end

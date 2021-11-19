occor = corr.test(OTUtest,use="pairwise",method="spearman",
                  adjust="fdr",alpha=.05)
occor.r = occor$r 

occor.p = occor$p 

occor.r[occor.p>0.05|abs(occor.r)<0.6] = 0 

igraph = graph_from_adjacency_matrix(occor.r,mode="undirected",
                                     weighted=TRUE,diag=FALSE)

igraph.weight = E(igraph)$weight

E(igraph)$weight = NA

set.seed(123)
 
plot(igraph,main="Co-occurrence network",vertex.frame.color=NA,vertex.label=NA,edge.width=1,
     vertex.size=5,edge.lty=1,edge.curved=TRUE,margin=c(0,0,0,0))

##otu转置

occor1 = corr.test(OTUtest1,use="pairwise",method="spearman",
                  adjust="fdr",alpha=.05)
occor.r1 = occor1$r 

occor.p1 = occor1$p 

occor.r1[occor.p1>0.05|abs(occor.r1)<0.6] = 0 

igraph = graph_from_adjacency_matrix(occor.r1,mode="undirected",
                                     weighted=TRUE,diag=FALSE)

igraph.weight = E(igraph)$weight

E(igraph)$weight = NA
sum(igraph.weight>0)# number of postive correlation
sum(igraph.weight<0)# number of negative correlation
# 如果构建网络时，weighted=NULL,此步骤不能统计

E.color = igraph.weight
E.color = ifelse(E.color>0, "red",ifelse(E.color<0, "blue","grey"))
E(igraph)$color = as.character(E.color)
# set edge color，postive correlation 设定为red, negative correlation设定为blue

E(igraph)$width = abs(igraph.weight)*4
# 可以设定edge的宽度set edge width，例如将相关系数与edge width关联


fc = cluster_fast_greedy(igraph,weights =NULL)
## 模块性 
modularity = modularity(igraph,membership(fc))
#modularitycluster_walktrap cluster_edge_betweenness, cluster_fast_greedy, cluster_spinglass
comps = membership(fc)
colbar = rainbow(max(comps))
V(igraph)$color = colbar[comps]
# 按照模块为节点配色

set.seed(123)

plot(igraph,main="Co-occurrence network",vertex.frame.color=NA,vertex.label=NA,edge.width=1,
     vertex.size=5,edge.lty=1,edge.curved=TRUE,margin=c(0,0,0,0))

heatmap(as.matrix(OTUtest))
corPlot(occor.r)

set.seed(999)
matt <- matrix(sample(18,18),3,6)
rownames(matt) <- paste0("S",1:3)
colnames(matt) <- paste0("E",1:6)
 # 构建邻接矩阵
head(matt)
df <- data.frame(from = rep(rownames(matt),times = ncol(matt)),
                 to = rep(colnames(matt), each = nrow(matt)),
                 value = as.vector(matt),
                 stringsAsFactors = FALSE)
 # 构建邻接列表
head(df)
chordDiagram(matt)
 # 通过矩阵画图
circos.clear()
 # 返回默认设置，否则会叠加图层后面操作影响原图
chordDiagram(df)
 # 通过列表画图
circos.clear()
chordDiagram(matt, 
             order = c("S2", "S1", "E4", "E1", "S3", 
                       "E5", "E2", "E6", "E3"))
 # 调整外围sectors的排列顺序
grid_col = c(S1 = "red", S2 = "green", S3 = "blue",
             E1 = "yellow", E2 = "pink", E3 = "orange", 
             E4 = "purple", E5 = "black", E6 = "grey")
 # 调整外围sectors的填充颜色
chordDiagram(matt, 
             grid.col = grid_col,
             transparency = 0.7)
 # 调整透明度
col_matt = rand_color(length(matt), transparency = 0.5)
head(col_matt)
chordDiagram(matt, 
             col = col_matt)
 # 使用col参数调整links的填充颜色

chordDiagram(matt, 
             link.border = "red",
             link.lty = 2,
             link.lwd = 2)
 # 使用link.border，link.lty和link.lwd参数设置links的边框颜色，线型和线宽
circos.clear()
circos.par(clock.wise = FALSE, 
           start.degree = 60 
)
 #逆时针旋转起始位置设置为逆时针60度方向

circos.par(gap.after = c("S1" = 5, "S2" = 8, "S3" = 15, 
                         "E1" = 5, "E2" = 10,"E3" = 5, 
                         "E4" = 3, "E5" = 5, "E6" = 15))
 #设置不同sector之间gap的间隔大小
circos.clear()


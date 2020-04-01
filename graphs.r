library(ggplot2)
library(gridExtra)
library(reshape2)
library(RColorBrewer)


f1 <- read.table("www/cases.txt", sep="\t", stringsAsFactors=F, header=T)
f2 <- read.table("www/pro_mun.txt", sep="\t", stringsAsFactors=F, header=T)

f <- merge(f2, f1, by="Municipality", all.x=TRUE)

ff <- aggregate(f$Cases, by=list(f$Province), FUN=sum, na.rm=TRUE)
colnames(ff) <- c("Provinces", "Cases")

melted <- melt(ff)

p <- ggplot(data=melted, aes(x=Provinces, y=value, fill=variable)) +
			geom_bar(stat="identity", position=position_dodge()) +
			theme(axis.text.x = element_text(angle = 45, hjust=1), legend.position = "none") +
			labs(title = "Number of COVID19 patients\nhospitalized in Netherlands", x = "Provinces", y = "No of patients hospitalized") +
			scale_fill_brewer(palette="Paired") +
			geom_text(aes(label=value), position=position_dodge(width=0.9), vjust=-0.5)

g <- grid.arrange(p, layout_matrix = rbind(c(1)))

ggsave(file="www/total_cases.jpeg", plot = g, device = NULL, path = NULL, scale = 1, width = 4, height = 6, units = "in", dpi = 300, limitsize = TRUE)

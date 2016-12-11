
args <- commandArgs(trailingOnly = TRUE)

id <- as.character(args[1])
overlap.file <- as.character(args[2])
ndg.file <- as.character(args[3])
th <- as.numeric(args[4])



overlap <- read.table(file = overlap.file, header = TRUE, quote = FALSE, comment.char = "" )
overlap.genes <- as.vector(overlap[["OverlapGene"]])

ndg <- read.table(file = ndg.file, header = TRUE, quote = FALSE, comment.char = "" )
targets <- vector(mode = "character",length = nrow(ndg))
for (i in 1:nrow(ndg))
{
  overlap <- ndg[i,4]
  if (overlap == 0)
  {
    gene.fw <- ndg[i,5]
    distance.fw <- ndg[i,7]
    gene.rev <- ndg[i,8]
    distance.rev <- ndg[i,10]
    if (distance.fw < distance.rev && distance.fw < th )
    {
      targets[i] <- gene.fw
    }
    else if (distance.rev < distance.fw && distance.rev < th)
    {
      targets[i] <- gene.rev
    }
  }
}

targets <- targets[targets != ""]

final.targets <- c(overlap.genes,targets)

write.table(x = final.targets,file = "intersected_genes.txt")

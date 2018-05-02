require("ChIPpeakAnno", quietly = TRUE)
require("EnsDb.Hsapiens.v75", quietly = TRUE)
require("rtracklayer", quietly = TRUE)

options(warn = -1)
options("download.file.method"="wget")

args <- commandArgs(trailingOnly = TRUE)

input1 = args[1]
input2 = args[2]
input3  = as.numeric(args[3])
input4 = as.numeric(args[4])
output1  = args[5]

DMRInfo <-  read.table(input1)
peaks <- GRanges(seqnames = DMRInfo[, 1],
                    ranges = IRanges
                    (start = DMRInfo[, 2], end = DMRInfo[, 3]))

annoData <- toGRanges(EnsDb.Hsapiens.v75)
seqlevelsStyle(peaks) <- seqlevelsStyle(annoData)

 anno <- annoPeaks(peaks, annoData=annoData, bindingType =c(input2), bindingRegion=c(input3, input4))
 
 write.table(anno, file= output1, row.names = FALSE)

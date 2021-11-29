args=commandArgs(trailingOnly = TRUE)

a <- scan(paste0(args[1], "/TCGA-AG-3599-01A1.txt"), character(), quote = "", quiet=TRUE)
a <- as.numeric(a)
b <- a/args[2]
write.table(b, paste0(args[1], "/TMB_value.txt"), sep="\t", quote=FALSE, row.names = FALSE, col.names = FALSE)

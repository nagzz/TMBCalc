args=commandArgs(trailingOnly = TRUE)

a <- scan(paste0(args[2], "/", args[1], ".txt"), character(), quote = "", quiet=TRUE)
a <- as.numeric(a)
b <- as.numeric(args[3])
b <- a/b
write.table(b, paste0(args[2], "/TMB_value.txt"), sep="\t", quote=FALSE, row.names = FALSE, col.names = FALSE)

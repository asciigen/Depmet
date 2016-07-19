# Author: DeepakSharma
# For: Nuro Lab, Nueroinfo group
# License: The MIT License

# Input variable for sample data id named sd
# Read csv file and copy all data (all electrodes/channels) into it
setwd("~/Documents/Depmet")
sd = read.csv("sample.csv",head=TRUE,sep=",")
attach(sd)
names(sd)
data.frame(names(sd))

# Output data is contained in od variable (8 channels)
od = data.frame(sd$X17,sd$X22, sd$X23, sd$X25, sd$X27, sd$X28, sd$X29, sd$X30)
names(od)=c("FT8", "F4", "F8", "FT7","F3","FP2","F7","FP1")
# One sample electrode data
od2 = data.frame(sd$X17)
names(od2)=c("FT8")

# No. of rows(time in miliseconds)
r = nrow(od)
# No. of channels in output file
c = ncol(od)

# Plot a selected channel
plot(sd$X21,type = 'l');

# Write output file
write.csv(od,"out.csv")

# Variable initialization
# Iteration variable initialization 
i <- 1; j <- 2; k <-0

# Counter variable initialization
neg <- 0; pos <- 0; zero_cross_counter <- 0

# Get summary for one electrode channel
summ = summary(od$FT8)
var_od = var(od$FT8)

od2$FT8 <- as.numeric(as.character(od2$FT8))
C = length(od2$FT8)
for(i in 1:C)
{
  if(od2$FT8[i] > 0)
    print(paste("Value of i is", od2$FT8[i]))
}


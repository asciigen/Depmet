A = data.frame("A"=c(1,5,-3,3,4),
               "B"=c(1,2,3,4,4),
               "C"=c(1,2,4,5,3),
               "D"=c(4,5,2,7,3))

A$B[1]

B = length(A$B)

for (i in 1:B)
{
  if(A$B[3] > 0)
    print(paste("Value of i is", A$B[i]))
}


install.packages("formattable")

library(formattable)
library(dplyr)

##question 3
myForm <- function(x) {
  formatter('span',
            style = x ~ style(display = "block", 
                              padding = "0 4px", 
                              `border-radius` = "4px", 
                              `background-color` = ifelse(x > 1, "red",
                                                          ifelse(x == 0, "green",
                                                                 ifelse(x == 1, "yellow", "grey"))))
  )
}
formattable(biallelic_X_1mb_analysis, lapply(biallelic_X_1mb_analysis, myForm))

##question 4
q4_table <- biallelic_X_1mb_analysis[,which(colSums(biallelic_X_1mb_analysis) == 4)]
out <- Filter(function(x) any(x == -1), q4_table)
q4_table <- q4_table[,-which(colnames(q4_table)==colnames(out))]

formattable(q4_table, lapply(q4_table, myForm))

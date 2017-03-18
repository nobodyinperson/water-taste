#!/usr/bin/env Rscript
options(stringsAsFactors = FALSE)

ARGS = commandArgs(trailingOnly = TRUE)
if(commandArgs()[1] == "RStudio") ARGS = c("data/water.csv", "plots/tmp.png")
cat("command-line arguments: \n", ARGS,"\n")
stopifnot(length(ARGS) == 2)

DATAFILE = ARGS[1]
cat("data file: ", DATAFILE, "\n")
stopifnot(file.exists(DATAFILE))

PLOTFILE = ARGS[2]
cat("plot file: ", PLOTFILE, "\n")

WATER = read.csv(file = DATAFILE)
cat("data read:\n")
print(WATER)

# get all 'taste' column names
taste_columns = grep(x = colnames(WATER), pattern = "^taste_.+$", value = TRUE)
users <- gsub(pattern = "^taste_", x = taste_columns, replacement = "")

cat("users:\n")
print(users)

mineral_columns = grep(x = colnames(WATER), pattern = "^min_.+$", value = TRUE)
minerals <- gsub(pattern = "^min_", x = mineral_columns, replacement = "")

cat("minerals:\n")
print(minerals)

# create correlation matrix
CORRMAT <- matrix(0, nrow = length(mineral_columns), 
                  ncol = length(taste_columns))
for(row in seq.int(along.with = mineral_columns)) { # loop over minerals
    for(col in seq.int(along.with = taste_columns)) { # loop over users
        taste <- WATER[taste_columns[col]]
        mineral <- WATER[mineral_columns[row]]
        cat("current tastes:\n"); print(taste)
        cat("current mineral:\n"); print(mineral)
        CORRMAT[row,col] <- cor(taste, mineral, use = "na.or.complete")
    }
}
CORRMAT <- t(CORRMAT) # stupid

#### plot ####
png(filename = PLOTFILE, pointsize = 16, width = 800, height = 600)
par(mar = c(8,5,2,2) + 0.1 )

user_colors <- topo.colors(length(users))

barplot(height = CORRMAT
        ,main = "correlation of mineral concentration with taste"
        ,beside = TRUE
        ,names.arg = minerals
        ,col = user_colors
        ,legend.text = users
        ,ylim = c(-1,1)
        ,las = 2
        )

dev.off()
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

mineral_colors <- topo.colors(length(minerals))
mineral_colors <- rainbow(length(minerals))

#### plot ####
png(filename = PLOTFILE, pointsize = 16, width = 800, height = 600)
par(mfrow=c(1,length(users)))

user_colors <- topo.colors(length(users))
mineral_symbols <- seq.int(along.with = minerals)

for(user_nr in seq.int(along.with = taste_columns)){
    plot(x = 1 ,y = 1, type="n",xlim=c(0,10)
         ,ylim = range(WATER[,mineral_columns],na.rm=T)
         ,main = users[user_nr]
         ,xlab = "taste [0=bad, 10=good]"
         ,ylab = "concentration [mg/l]"
         ,log = "y"
         )
    for(mineral_nr in seq.int(along.with = mineral_columns)) {
        print(minerals[mineral_nr])
        points(x = WATER[,taste_columns[user_nr]]
               ,y = WATER[,mineral_columns[mineral_nr]]
               ,pch = mineral_symbols[mineral_nr]
               # ,pch = 20
               ,col = mineral_colors[mineral_nr]
               ,cex = 2
               )
    }
    legend(x = "bottomleft", cex= 0.7, 
           legend = minerals, 
           pch = mineral_symbols,
           # pch = 20, 
           col = mineral_colors, 
           box.col = NA, bg = NA)
}

dev.off()
#!/usr/bin/env Rscript
options(stringsAsFactors = FALSE)

ARGS = commandArgs(trailingOnly = TRUE)
# ARGS = c("data/water.csv", "plots/mean_taste_vs_name.png")
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

# calculate mean taste
WATER$mean_taste = apply(X = as.matrix(sapply(WATER[,taste_columns],as.numeric)), MARGIN = 1, FUN = function(x)mean(x, na.rm=TRUE))

png(filename = PLOTFILE, pointsize = 16, width = 800, height = 600)
par(mar = c(5,7,2,2) + 0.1 )
ord <- order(WATER$mean_taste)
bar_colors <- topo.colors(nrow(WATER))
if(!is.null(WATER$color)) {
    correct_colors <- grepl(x=WATER$color,pattern="#[a-zA-Z0-9]{6}")
    bar_colors[correct_colors] <- WATER$color[correct_colors]
}
bars = barplot(
    height = WATER$mean_taste[ord]
    , names.arg = WATER$brand[ord]
    , col = bar_colors[ord]
    , horiz = TRUE
    , main = "mean water taste by name"
    , xlab = "mean water taste"
    , xlim = c(0,10)
    , las = 1
    )
legend("bottomright"
    ,legend = rev(WATER$name[ord])
    ,fill = rev(bar_colors[ord])
)
dev.off()
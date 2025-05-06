library(hexSticker)
library(gridExtra) # for tableGrob
library(grid)
library(showtext)

# Load Google font
font_add_google("Gochi Hand", "gochi")
showtext_auto()

# Create matrix with NA display as character for formatting
tbl <- matrix(c("1", "NA", "NA", "4"), nrow = 2, byrow = TRUE)
# Replace "NA" with styled gray version using expression
# Create table without row/column names
table_plot <- tableGrob(tbl, rows = NULL, cols = NULL)

# Slight table tweaks: enlarge text, nicer font
for (i in seq_along(table_plot$grobs)) {
  g <- table_plot$grobs[[i]]
  if (inherits(g, "text")) {
    g$gp <- gpar(fontsize = 14, fontfamily = "gochi", col = "black")
    table_plot$grobs[[i]] <- g
  }
}

# Sticker with nicer green background
s <- sticker(
  subplot = table_plot,
  package = "missr",
  p_size = 20,
  p_color = "orange",
  p_family = "gochi",
  s_x = 1, s_y = 0.8,
  s_width = 1.2, s_height = 1.2,
  h_fill = "#d5f5e3", # fresher light green
  filename = "inst/figures/baseplot.png"
)

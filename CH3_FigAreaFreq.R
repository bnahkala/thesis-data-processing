# combine area frequency curves for publication


# using ggplots generated in data_viz.R


png(filename = "freq.curve.all2.png", height = 800, width = 600)

arr <- ggarrange(
  g1,
  g2,
  g3,
  g4,
  labels = c("A", "B", "C", "D"),
  ncol = 2,
  nrow = 2, 
  common.legend = T, 
  legend = "top"
)
annotate_figure(arr, 
                left =text_grob("Fraction of Maximum Pothole Volume", rot = 90),
                bottom = text_grob("Fraction of Years Simulated"))

dev.off()



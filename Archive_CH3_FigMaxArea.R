# TITLE: DATA CONVERSIONS
# AUTHOR: BRADY NAHKALA
# LAST REVISED: 27 MAY 2020
# data from 
# create maximum area per month plots, function coming from previous
# annagnps project 'AnnAGNPS_Output'
# 

# LIBRARY ====
library(tidyr)
library(dplyr)
library(ggplot2)
library(reshape2)
library(ggpubr)

# SCENARIOS ===== 

simulation_numbers <- data.frame("Drain0" = c(22, 23, 24, 3, 12, 13, 1),
                                 "Drain1" = c(4, 14, 25, 19, 29, 33, 36),
                                 "Drain2" = c(5, 15, 26, 20, 30, 34, 37),
                                 "Drain3" = c(6, 16, 27, 21, 31, 35, 38))
simulation_numbers2 <- data.frame("CSCV" = c(22, 4, 5, 6),
                                  "CSCT" = c(23, 14, 15, 16),
                                  "CSNT" = c(24, 25, 26, 27),
                                  "RCV" = c(3, 19, 20, 21),
                                  "RCT" = c(12, 29, 30, 31),
                                  "RNT" = c(13, 33, 34, 35),
                                  "RR" = c(1, 36, 37, 38))

simulation_numbers3 <- data.frame("PDCC" = c(0, 7, 8, 9, 10, 17))

simulation_shortIDs <- data.frame("Drain0" = c("D0-CS-CV", "D0-CS-CT", "D0-CS-NT", "D0-R-CV", "D0-R-CT", "D0-R-NT","D0-R-R"),
                                  "Drain1" = c("D1-CS-CV", "D1-CS-CT", "D1-CS-NT", "D1-R-CV", "D1-R-CT", "D1-R-NT","D1-R-R"),
                                  "Drain2" = c("D2-CS-CV", "D2-CS-CT", "D2-CS-NT", "D2-R-CV", "D2-R-CT", "D2-R-NT","D2-R-R"),
                                  "Drain3" = c("D3-CS-CV", "D3-CS-CT", "D3-CS-NT", "D3-R-CV", "D3-R-CT", "D3-R-NT","D3-R-R"))
simulation_shortIDs2 <- data.frame("CSCV" = c("D0-CS-CV", "D1-CS-CV", "D2-CS-CV", "D3-CS-CV"),
                                   "CSCT" = c("D0-CS-CT", "D1-CS-CT", "D2-CS-CT", "D3-CS-CT"),
                                   "CSNT" = c("D0-CS-NT", "D1-CS-NT", "D2-CS-NT", "D3-CS-NT"),
                                   "RCV" = c("D0-R-CV", "D1-R-CV", "D2-R-CV", "D3-R-CV"),
                                   "RCT" = c("D0-R-CT", "D1-R-CT", "D2-R-CT", "D3-R-CT"),
                                   "RNT" = c("D0-R-NT", "D1-R-NT", "D2-R-NT", "D3-R-NT"),
                                   "RR" = c("D0-R-R", "D1-R-R", "D2-R-R", "D3-R-R"))
simulation_shortIDs3 <- data.frame("PDCC" = c("DX-X-CV","PD-2E", "PD-2L", "PD-4L", "PD-6L", "DX-CC-NT"))

simulation_names <- data.frame("Drain0" = c("Drain0", "Drain0CT", "Drain0NT", "RetiredPothole", "ConTillRetired", "NoTillRetired","RetiredAll"),
                               "Drain1" = c("Drain01", "ConTillDrain01", "Drain1NT", "Drain1Retired", "Drain1RetiredCT", "Drain1RetiredNT","Drain1RetiredAll"),
                               "Drain2" = c("Drain02", "ConTillDrain02", "Drain2NT", "Drain2Retired", "Drain2RetiredCT", "Drain2RetiredNT","Drain2RetiredAll"),
                               "Drain3" = c("Drain03", "ConTillDrain03", "Drain3NT", "Drain3Retired", "Drain3RetiredCT", "Drain3RetiredNT","Drain3RetiredAll"))

simulation_names2 <- data.frame("CSCV" = c("Drain0", "Drain01", "Drain02", "Drain03"),
                                "CSCT" = c("Drain0CT", "ConTillDrain01", "ConTillDrain02", "ConTillDrain03"),
                                "CSNT" = c("Drain0NT", "Drain1NT", "Drain2NT", "Drain3NT"),
                                "RCV" = c("RetiredPothole", "Drain1Retired", "Drain2Retired", "Drain3Retired"),
                                "RCT" = c("ConTillRetired", "Drain1RetiredCT", "Drain2RetiredCT", "Drain3RetiredCT"),
                                "RNT" = c("NoTillRetired", "Drain1RetiredNT", "Drain2RetiredNT", "Drain3RetiredNT"),
                                "RR" = c("RetiredAll", "Drain1RetiredAll", "Drain2RetiredAll", "Drain3RetiredAll"))
simulation_names3 <- data.frame("PDCC" = c("Base", "PlantDate01", "PlantDate02", "PlantDate03", "PlantDate04", "CoverCrop"))



# FUNCTIONS ====
# function originally from 'AnnAGNPS_Output.Rproj' -> data_functions.R
find.monthly.max <- function(data.df) {
  max.by.month <- data.df %>%
    dplyr::group_by(Year, Month) %>%
    dplyr::summarise(
      Base = max(Base),
      RetiredAll = max(RetiredAll),
      ConTill = max(ConTill),
      RetiredPothole = max(RetiredPothole),
      Drain01 = max(Drain01),
      Drain02 = max(Drain02),
      Drain03 = max(Drain03),
      PlantDate01 = max(PlantDate01),
      PlantDate02 = max(PlantDate02),
      PlantDate03 = max(PlantDate03),
      PlantDate04 = max(PlantDate04),
      NoTill = max(NoTill),
      ConTillRetired = max(ConTillRetired),
      NoTillRetired = max(NoTillRetired),
      ConTillDrain01 = max(ConTillDrain01),
      ConTillDrain02 = max(ConTillDrain02),
      ConTillDrain03 = max(ConTillDrain03),
      CoverCrop = max(CoverCrop),
      BaseRetired = max(BaseRetired),
      Drain1Retired = max(Drain1Retired),
      Drain2Retired = max(Drain2Retired),
      Drain3Retired = max(Drain3Retired),
      Drain0 = max(Drain0),
      Drain0CT = max(Drain0CT),
      Drain0NT = max(Drain0NT),
      Drain1NT = max(Drain1NT),
      Drain2NT = max(Drain2NT),
      Drain3NT = max(Drain3NT),
      BaseRetiredCT = max(BaseRetiredCT),
      Drain1RetiredCT = max(Drain1RetiredCT),
      Drain2RetiredCT = max(Drain2RetiredCT),
      Drain3RetiredCT = max(Drain3RetiredCT),
      BaseRetiredNT = max(BaseRetiredNT),
      Drain1RetiredNT = max(Drain1RetiredNT),
      Drain2RetiredNT = max(Drain2RetiredNT),
      Drain3RetiredNT = max(Drain3RetiredNT),
      Drain1RetiredAll = max(Drain1RetiredAll),
      Drain2RetiredAll = max(Drain2RetiredAll),
      Drain3RetiredAll = max(Drain3RetiredAll)
    )
  return(max.by.month)
}

# function originally from 'AnnAGNPS_Output.Rproj' -> data_viz_functions.R
plot.max.monthly <- function(data.df, id) {
  
  mm <- data.df %>%
    group_by(Month) %>%
    summarise(Base=max(Base), RetiredAll=max(RetiredAll), ConTill =max(ConTill), 
              RetiredPothole=max(RetiredPothole), Drain01=max(Drain01), Drain02=max(Drain02),
              Drain03=max(Drain03), PlantDate01=max(PlantDate01), PlantDate02=max(PlantDate02),
              PlantDate03=max(PlantDate03), PlantDate04=max(PlantDate04), NoTill=max(NoTill),
              ConTillRetired=max(ConTillRetired), NoTillRetired=max(NoTillRetired), 
              ConTillDrain01=max(ConTillDrain01), ConTillDrain02=max(ConTillDrain02),ConTillDrain03=max(ConTillDrain03),
              CoverCrop=max(CoverCrop), BaseRetired=max(BaseRetired), Drain1Retired=max(Drain1Retired), 
              Drain2Retired=max(Drain2Retired), Drain3Retired=max(Drain3Retired)) %>%
    melt(id="Month") %>%
    as.data.frame()
  
  if (id == 1){
    col = "steelblue"
    nm = "bunny"
  } else if (id == 2) {
    col="tan4"
    nm = "walnut"
  }else if (id == 3) {
    col="seagreen"  
    nm = "lettuce"
  }else if (id == 4) {
    col="firebrick3"
    nm = "cardinal"
  }else if (id == 5) {
    col="goldenrod"
    nm = "hen"
  }else if (id == 6) {
    col="mediumpurple3"
    nm = "mouth"
  } else {
    col = "black"
  }
  
  png(paste("median.max.monthly.plot.",nm, ".png"), width = 1200, height = 800)
  # windows()
  plot.all <- ggplot(mm, aes(x=Month, y=value))+
    geom_bar(stat="identity", fill=col)+
    facet_wrap(~variable)+
    ylim(0, 7500)+
    labs(
      x="Month",
      y="Average Monthly Maximum Volume (m^3)")
  
  
  
  return(plot.all)
}

# function originally from 'AnnAGNPS_Output.Rproj' -> data_partitioning.R
max.function.partitioned3 <- function(data.df, id, supp.labs, labnms) {
  temp <- data.df %>%
    group_by(Month, Pothole, scen) %>%
    summarise(avg.max=mean(value), median.max=median(value)) #%>%
    # filter(avg.max != 0)
  
  labs <- as.character(supp.labs)
  names(labs) <- as.character(labnms)
  
  png(filename = paste0("avg_", id, "_comparison.png"), width=800, height=500)
  # windows()
  plot.max <- ggplot(temp, aes(x=Month, y=avg.max, fill=Pothole))+
    geom_bar(stat="identity")+
    facet_grid(cols = vars(scen), rows = vars(Pothole), labeller = labeller(scen = labs))+
    ylim(0, 25000)+
    theme(axis.text.x = element_text(angle = 90))+
    theme(text = element_text(size=9))+
    theme(legend.position = "none")+
    labs(
      x="",
      y="")+
    scale_fill_brewer(palette = "Dark2", labels=c("DX-CS-CV","DX-CS-CT","DX-CS-NT","DX-R-CV","DX-R-CT","DX-R-NT","DX-R-R"))
  plot.max
  return(plot.max)
}

# DATA PREP ====
area.max.month.bunny <- find.monthly.max(area.bunny.df)
area.max.month.walnut <- find.monthly.max(area.walnut.df)
area.max.month.lettuce <- find.monthly.max(area.lettuce.df)
area.max.month.cardinal <- find.monthly.max(area.cardinal.df)
area.max.month.hen <- find.monthly.max(area.hen.df)
area.max.month.mouth <- find.monthly.max(area.mouth.df)

data.for.partitioning2 <- rbind(area.max.month.bunny, area.max.month.walnut, area.max.month.lettuce, 
                                area.max.month.cardinal, area.max.month.hen, area.max.month.mouth)
data.for.partitioning2$Pothole <- c(rep("Bunny", 300), rep("Walnut", 300), rep("Lettuce", 300),
                                    rep("Cardinal", 300), rep("Hen", 300), rep("Mouth", 300))
# data.for.partitioning2 <- melt(data.for.partitioning2, id=c("Year", "Month", "Pothole"))


# PARTITIONING DATA =====

# drainage matrices ====

max.data.drain0 <- data.for.partitioning2[ , c(1:2, 42, (simulation_numbers$Drain0+3))]
max.data.drain0 <- max.data.drain0 %>%
  gather("variable", "value", 4:10)

max.data.drain0$scen <- factor(max.data.drain0$variable, levels = c("Drain0", "Drain0CT", "Drain0NT",
                                                                    "RetiredPothole", "ConTillRetired",
                                                                    "NoTillRetired", "RetiredAll"))

# max.data.drain0.filter <- max.data.drain0 %>%
#   filter(Pothole != "Mouth" & Pothole != "Hen") %>%
#   filter(variable == "Drain0" | variable == "RetiredPothole" | variable == "RetiredAll")

max.data.drain1 <- data.for.partitioning2[ , c(1:2, 42, (simulation_numbers$Drain1+3))]
max.data.drain1 <- max.data.drain1 %>%
  gather("variable", "value", 4:10)

max.data.drain1$scen <- factor(max.data.drain1$variable, levels=c("Drain01", "ConTillDrain01", "Drain1NT",
                                                                   "Drain1Retired", "Drain1RetiredCT", 
                                                                   "Drain1RetiredNT", "Drain1RetiredAll"))

max.data.drain2 <- data.for.partitioning2[ , c(1:2, 42, (simulation_numbers$Drain2+3))]
max.data.drain2 <- max.data.drain2 %>%
  gather("variable", "value", 4:10)

max.data.drain2$scen <- factor(max.data.drain2$variable, levels=c("Drain02", "ConTillDrain02", "Drain2NT",
                                                                  "Drain2Retired", "Drain2RetiredCT", 
                                                                  "Drain2RetiredNT", "Drain2RetiredAll"))


max.data.drain3 <- data.for.partitioning2[ , c(1:2, 42, (simulation_numbers$Drain3+3))]
max.data.drain3 <- max.data.drain3 %>%
  gather("variable", "value", 4:10)

max.data.drain3$scen <- factor(max.data.drain3$variable, levels=c("Drain03", "ConTillDrain03", "Drain3NT",
                                                                  "Drain3Retired", "Drain3RetiredCT", 
                                                                  "Drain3RetiredNT", "Drain3RetiredAll"))


# tillage matrices ====
max.data.CSCV <- data.for.partitioning2[ , c(1:2, 42, (simulation_numbers2$CSCV)+3)]
max.data.CSCV <- max.data.CSCV %>%
  gather("variable", "value", 4:7)

max.data.CSCT <- data.for.partitioning2[ , c(1:2, 42, (simulation_numbers2$CSCT)+3)]
max.data.CSCT <- max.data.CSCT %>%
  gather("variable", "value", 4:7)

max.data.CSNT <- data.for.partitioning2[ , c(1:2, 42, (simulation_numbers2$CSNT)+3)]
max.data.CSNT <- max.data.CSNT %>%
  gather("variable", "value", 4:7)

max.data.RCV <- data.for.partitioning2[ , c(1:2, 42, (simulation_numbers2$RCV)+3)]
max.data.RCV <- max.data.RCV %>%
  gather("variable", "value", 4:7)

max.data.RCT <- data.for.partitioning2[ , c(1:2, 42, (simulation_numbers2$RCT)+3)]
max.data.RCT <- max.data.RCT %>%
  gather("variable", "value", 4:7)

max.data.RNT <- data.for.partitioning2[ , c(1:2, 42, (simulation_numbers2$RNT)+3)]
max.data.RNT <- max.data.RNT %>%
  gather("variable", "value", 4:7)

max.data.RR <- data.for.partitioning2[ , c(1:2, 42, (simulation_numbers2$RR)+3)]
max.data.RR <- max.data.RR %>%
  gather("variable", "value", 4:7)


# APPLY PLOT FUNCTIONS ======

# drainage matrices ====

m1 <- max.function.partitioned3(max.data.drain0, "drain0", simulation_shortIDs$Drain0, simulation_names$Drain0)
dev.off()

# max.function.partitioned2(max.data.drain0.filter, "Simulation Comparison, No Drainage Present", "drain0_abbr", simulation_shortIDs$Drain0, simulation_names$Drain0)
# dev.off()

m2 <- max.function.partitioned3(max.data.drain1, "drain1", simulation_shortIDs$Drain1, simulation_names$Drain1)
dev.off()

m3 <- max.function.partitioned3(max.data.drain2, "drain2", simulation_shortIDs$Drain2, simulation_names$Drain2)
dev.off()

m4 <- max.function.partitioned3(max.data.drain3, "drain3", simulation_shortIDs$Drain3, simulation_names$Drain3)
dev.off()

# windows()
png(filename = "pub_maxplot.png", width=1000, height=750)
arr <- ggarrange(
  m1+theme(axis.text.x = element_blank()),
  m2+theme(axis.text.x = element_blank(), axis.text.y = element_blank()),
  m3,
  m4+theme(axis.text.y = element_blank()),
  labels = c("A", "B", "C", "D"),
  ncol = 2,
  nrow = 2
)
annotate_figure(arr, 
                left =text_grob("Pothole Surface Area (m^2)", rot = 90),
                bottom = text_grob("Month"))
dev.off()


# data frame for plots
plt.data1 <- layer_data(m1, 1)
write.csv(plt.data1, "m1.csv", sep = ",")
plt.data2 <- layer_data(m2, 1)
write.csv(plt.data2, "m2.csv", sep = ",")
plt.data3 <- layer_data(m3, 1)
write.csv(plt.data3, "m3.csv", sep = ",")
plt.data4 <- layer_data(m4, 1)
write.csv(plt.data4, "m4.csv", sep = ",")



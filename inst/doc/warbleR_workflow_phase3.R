## ---- eval=FALSE---------------------------------------------------------
#  
#  library(warbleR)
#  
#  # set your working directory appropriately
#  # setwd("/path/to/working directory")
#  
#  # run this if you have restarted RStudio between vignettes without saving your workspace
#  # assumes that you are in your /home/username directory
#  setwd(file.path(getwd(),"warbleR_example"))
#  
#  # Check your location
#  getwd()
#  

## ---- eval=TRUE, echo=FALSE, message=FALSE-------------------------------

# this sets my working directory if necessary
# knitted output will be saved to a temp dir instead of warbleR local repo
# setwd(tempdir())

library(warbleR)
library(knitr)


## ---- eval=FALSE---------------------------------------------------------
#  
#  tin <- querxc(qword = 'Tinamus', download = FALSE)
#  
#  # select a single recording
#  tin <- tin[tin$Recordist == "Marcelo Araya-Salas", ]
#  
#  # download this recording
#  querxc(X = tin, download = TRUE)
#  mp32wav()
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  Tin.sels <- run_raven(raven.path = "/home/gsvidaurre/opt/Raven-1.5.0.0035/", sound.files = "Tinamus-major-154191.wav", import = TRUE, all.data = FALSE, name.from.file = TRUE, ext.case = "lower", freq.cols = FALSE)
#  str(Tin.sels)
#  
#  # write selections as a physical file you you can read them back in at any time
#  # good way to save all your work
#  write.csv(Tin.sels, "Tinamus-major-154191_sels.csv", row.names = FALSE)
#  
#  # generate individual cuts for freqeuency range measurements below
#  cut_sels(Tin.sels, mar = 0.05, labels = c("sound.files", "selec"))
#  

## ---- eval=TRUE, echo=FALSE----------------------------------------------

# Tin.sels <- read.csv("Tinamus-major-154191_sels.csv", header = TRUE)


## ---- eval=FALSE---------------------------------------------------------
#  
#  # note that changing the threshold argument in combination with the bandpass argument can improve the detection
#  frange.detec(readWave("Tinamus-major-154191-6.wav"), flim = c(0, 2.5), bp = c(0, 3), threshold = 15)
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  # here, giving a strict bandpass with very low threshold improves frange detection
#  # since the curving end of the tinamou signal is lower amplitude than the rest of the signal
#  frange.detec(readWave("Tinamus-major-154191-6.wav"), flim = c(0, 2.5), bp = c(0, 3), threshold = 1)
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  # use arguments from frange.detec above
#  fr <- frange(Tin.sels, threshold = 1, res = 100, flim = c(0, 2.5), bp = c(0.5, 2.5))
#  str(fr)
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  se <- sp.en.ts(Phae.hisnrt, wl = 300, length.out = 10, threshold = 10, img = TRUE, img.suffix = "sp.en.ts", type = "b", ovlp = 90, sp.en.range = c(-25, 10))
#  

## ---- eval=FALSE, echo=FALSE---------------------------------------------
#  
#  # 03 Aug 17 GSV sp.en.ts sometimes yields null entropy and symbols w/o lines for both Phae.hisnrt and Tin.sels,
#  # but works for selec.table
#  # disappeared for Tin.sels when I removed the bp argument, still getting one warning for Phae.hisnrt
#  
#  # sp.en.ts bug? stretching the range to negative yields drastic differences using the code above
#  # e.g. when sp.en.range default the time series is high above the signal
#  
#  
#  se <- sp.en.ts(Phae.hisnrt, wl = 300, length.out = 10, threshold = 10, img = TRUE, img.suffix = "sp.en.ts", type = "b")
#  
#  se <- sp.en.ts(Tin.sels, length.out = 10, threshold = 10, img = TRUE, img.suffix = "sp.en.ts", type = "b", sp.en.range = c(-25, 10))
#  
#  # without clip edges
#  names(selec.table)
#  sp.en.ts(X = selec.table, threshold = 10, bp = NULL, clip.edges = F, length.out = 10,
#   type = "b", sp.en.range = c(-25, 10))
#  
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  Phae.hisnrt <- read.csv("seltailor_output.csv", header = TRUE)
#  
#  compare.methods(X = Phae.hisnrt, flim = c(0, 10), bp = c(0, 10),
#                  wl = 300, n = 10, methods = c("XCORR", "dfDTW"))
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  # Note that the dominant frequency measurements are almost always more accurate
#  trackfreqs(Phae.hisnrt, wl = 300, flim = c(2, 10), bp = c(1, 12), it = "jpeg")
#  
#  # We can change the lower end of bandpass to make the frequency measurements more precise
#  trackfreqs(Phae.hisnrt, wl = 300, flim = c(1, 10), bp = c(2, 12), col = c("purple", "orange"),
#             pch = c(17, 3), res = 300, it = "jpeg")
#  

## ---- eval=TRUE, echo=FALSE----------------------------------------------

Phae.hisnrt <- read.csv("seltailor_output.csv")
params <- read.csv("acoustic_parameters.csv")


## ---- eval=FALSE---------------------------------------------------------
#  
#  params <- specan(Phae.hisnrt, bp = c(2, 10), threshold = 15)
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  # As always, it's a good idea to write .csv files to your working directory
#  write.csv(params, "acoustic_parameters.csv", row.names = FALSE)
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  params <- params[, grep("fun|peakf", colnames(params), invert = TRUE)]
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  # Harmonic Phaethornis signals
#  dm <- dfDTW(Phae.hisnrt, length.out = 30, flim = c(2, 10), bp = c(2, 9), wl = 300, img = TRUE)
#  

## ---- eval=FALSE---------------------------------------------------------
#  # Tonal Tinamou signals
#  Tin.sels <- read.csv("Tinamus-major-154191_sels.csv", header = TRUE)
#  dm <- dfDTW(Tin.sels, length.out = 30, flim = c(0, 2.5), bp = c(0.5, 2.5), wl = 512, img = TRUE)
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  xc <- xcorr(Phae.hisnrt, wl = 300, na.rm = FALSE, frange = c(2,10))
#  str(xc)
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  xc <- xcorr(Phae.hisnrt, wl = 300, na.rm = FALSE, frange = c(2,10), cor.mat = FALSE)
#  
#  jpeg("xcorr_graph.jpeg", width = 30, height = 30, units = "cm", res = 200)
#  xcorr.graph(xc, cex.cor = 1, cex.lab = 1, cex.axis.lab = 1)
#  dev.off()
#  

## ---- eval=TRUE, dpi=220-------------------------------------------------

# Run the PCA with only numeric variables of params
pca <- prcomp(x = params[, sapply(params, is.numeric)], scale. = TRUE)

# Check loadings
summary(pca)

# Extract PCA scores
pcascor <- as.data.frame(pca[[5]])

# Plot the 2 first PCs
plot(pcascor[, 1], pcascor[, 2], col = as.numeric(params$sound.files), pch = 20, 
     cex = 1, xlab = "PC1", ylab = "PC2")

# Add recordings/individuals labels 
x <- tapply(pcascor[, 1], params$sound.files, mean)
y <- tapply(pcascor[, 2], params$sound.files, mean)

labs <- gsub(".wav", "", unique(sapply(as.character(params$sound.files), function(x){
  strsplit(x, split = "-", fixed = TRUE)[[1]][3]
  }, USE.NAMES = FALSE)))

text(x, y, labs, cex = 0.75)


## ---- eval=TRUE, dpi=220-------------------------------------------------

# Create a song type variable

# First, extract recording ID
songtype <- gsub(".wav", "", sapply(as.character(params$sound.files), function(x){
  strsplit(x, split = "-", fixed = TRUE)[[1]][3]
  }, USE.NAMES = FALSE))

# Now change IDs for letters representing song types
songtype <- gsub("154070|154072", "A", songtype)
songtype <- gsub("154129|154161", "B", songtype)
songtype <- gsub("154138", "C", songtype)

# Add song type as a variable representing symbol type
plot(pcascor[, 1], pcascor[, 2], col = as.numeric(params$sound.files), 
pch = as.numeric(as.factor(songtype)), 
     cex = 1, xlab = "PC1", ylab = "PC2")

# Add song type labels 
x <- tapply(pcascor[, 1], songtype, mean)
y <- tapply(pcascor[, 2], songtype, mean)

text(x, y, unique(songtype), cex = 1)


## ---- eval=TRUE, echo=TRUE-----------------------------------------------

data(sim.coor.sing)
str(sim.coor.sing)


## ---- eval=FALSE---------------------------------------------------------
#  
#  # save plots in a list
#  g <- coor.graph(sim.coor.sing, it = "jpeg", img = FALSE, res = 300)
#  
#  # print list of plots to graphics device
#  g
#  

## ---- eval=TRUE, echo=TRUE-----------------------------------------------

cs <- coor.test(sim.coor.sing, iterations = 1000, less.than.chance = TRUE, cutoff = 10)
str(cs)



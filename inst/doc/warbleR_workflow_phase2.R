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
#  Phae.hisnr <- read.csv("Phae_hisnr.csv", header = TRUE)
#  
#  specreator(Phae.hisnr, wl = 300, flim = c(2, 10), it = "jpeg", res = 150, osci = TRUE, ovlp = 90)
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  # remove selections after deleting corresponding image files
#  Phae.hisnr2 <- filtersels(Phae.hisnr, it = "jpeg", incl.wav = TRUE)
#  nrow(Phae.hisnr2) # 23 selections left
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  # if selections can be read, "OK" will be printed to check.res column
#  checksels(Phae.hisnr2, check.header = FALSE)
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  cut_sels(Phae.hisnr2, labels = c("sound.files", "selec"))
#  

## ---- eval=FALSE, echo+FALSE---------------------------------------------
#  
#  # bug in the above cut_sels code
#  
#  # Error in apply(X[, sapply(X, is.factor)], 2, as.character) :
#  #   dim(X) must have a positive length

## ---- eval=FALSE---------------------------------------------------------
#  
#  seltailor(Phae.hisnr2, wl = 300, flim = c(2,10), wn = "hanning", mar = 0.1,
#   osci = TRUE, title = c("sound.files", "selec"))
#  
#  Phae.hisnrt <- read.csv("seltailor_output.csv", header = TRUE)
#  str(Phae.hisnrt)
#  

## ---- eval=FALSE, echo=FALSE---------------------------------------------
#  
#  # bug in above seltailor code
#  # two warnings per signal (2 freqs)
#  # In is.na(X$high.freq[j]) :
#  #   is.na() applied to non-(list or vector) of type 'NULL'
#  
#  

## ---- eval=TRUE, echo=FALSE----------------------------------------------

Phae.hisnrt <- read.csv("seltailor_output.csv", header = TRUE)
str(Phae.hisnrt)


## ---- eval=FALSE---------------------------------------------------------
#  
#  # highlight selected signals
#  lspec(Phae.hisnrt, wl = 300, flim = c(2, 10), ovlp = 10, sxrow = 6, rows = 15, it = "jpeg")
#  
#  # concatenate lspec image files into a single PDF per recording
#  # lspec images must be jpegs
#  lspec2pdf(keep.img = FALSE, overwrite = TRUE)
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  # we will use Phaethornis songs and selections from the warbleR package
#  data(list = c("Phae.long1", "selec.table"))
#  writeWave(Phae.long1, "Phae.long1.wav") #save sound files
#  
#  # subset selection table
#  # already contains the frequency range for these signals
#  st <- selec.table[selec.table$sound.files == "Phae.long1.wav",]
#  
#  # read wave file as an R object
#  sgnl <- tuneR::readWave(as.character(st$sound.files[1]))
#  
#  # create color column
#  st$colors <- c("red2", "blue", "green")
#  
#  # highlight selections
#  color.spectro(wave = sgnl, wl = 300, ovlp = 90, flim = c(1, 8.6), collevels = seq(-90, 0, 5),
#                dB = "B", X = st, col.clm = "colors", base.col = "skyblue",  t.mar = 0.07, f.mar = 0.1)
#  

## ---- eval = FALSE, echo = FALSE-----------------------------------------
#  
#  # was getting bugs using the xeno-canto recordings
#  # but code sort of works for the following code:
#  # problem is that code takes a while to run and then shows the whole long spectrogram
#  # suggestion for color spctro - argument to zoom in on section of x-axis?
#  
#  X <- Phae.hisnrt[Phae.hisnrt$sound.files == "Phaethornis-longirostris-154072.wav", ]
#  X$colors <- c("red2", "blue", "green", "yellow", "orange")
#  
#  X2 <- frange(X)
#   View(X2)
#  
#  color.spectro(wave = readWave("Phaethornis-longirostris-154072.wav"), wl = 300, ovlp = 90, flim = c(1, 8.6), collevels = seq(-90, 0, 5),
#                dB = "B", X = X2, col.clm = "colors", base.col = "skyblue",  t.mar = 0.07, f.mar = 0.1)
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  # create a column of recording IDs for friendlier catalog labels
#  rec_ID <- sapply(1:nrow(Phae.hisnrt), function(x){
#    strsplit(strsplit(as.character(Phae.hisnrt$sound.files[x]), split = "-")[[1]][[3]], split = ".w")[[1]][1]
#  })
#  
#  Phae.hisnrt$rec_ID <- rec_ID
#  str(Phae.hisnrt)
#  
#  # set color palette
#  # alpha controls transparency for softer colors
#  cmc <- function(n) cm.colors(n, alpha = 0.8)
#  
#  catalog(X = Phae.hisnrt, flim = c(1, 10), nrow = 4, ncol = 3, height = 10, width = 10, tag.pal = list(cmc), cex = 0.8, same.time.scale = TRUE, mar = 0.01, wl = 300, gr = FALSE, labels = "rec_ID", tags = "rec_ID", hatching = 1, group.tag = "rec_ID", spec.mar = 0.4, lab.mar = 0.8, max.group.cols = 5)
#  
#  catalog2pdf(keep.img = FALSE, overwrite = TRUE)
#  
#  # assuming we are working from the warbleR_example directory
#  # the ~/ format does not apply to Windows
#  # make sure you have already moved or deleted all other pdf files
#  move.imgs(from = ".", it = "pdf", create.folder = TRUE, folder.name = "Catalog_image_files")
#  

## ---- eval = FALSE, echo = FALSE-----------------------------------------
#  
#  # suggestion for move.imgs
#  # add argument for regex so as not to delete/move all image files of a given type
#  # and be able to move just "Cat*.pdf"...etc

## ---- eval=FALSE---------------------------------------------------------
#  # now create a catalog without labels, tags, groups or axes
#  Phae.hisnrt$no_label <- ""
#  
#  catalog(X = Phae.hisnrt, flim = c(1, 10), nrow = 4, ncol = 3, height = 10, width = 10, cex = 0.8, same.time.scale = TRUE, mar = 0.01, wl = 300, spec.mar = 0.4, rm.axes = TRUE, labels = "no_label")
#  
#  catalog2pdf(keep.img = FALSE, overwrite = TRUE)
#  


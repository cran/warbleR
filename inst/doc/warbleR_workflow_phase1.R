## ---- eval=FALSE---------------------------------------------------------
#  
#  # install warbleR from CRAN
#  # install.packages("warbleR")
#  
#  # install warbleR from GitHub repository, which contains the latest updates
#  # install.packages("devtools") # run this if devtools is not already installed
#  library(devtools)
#  install_github("maRce10/warbleR")
#  
#  library(warbleR) # load warbleR into your global environment
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  # Create a new directory and set your working directory
#  dir.create(file.path(getwd(),"warbleR_example"))
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


## ---- eval=TRUE----------------------------------------------------------

# Query xeno-canto for all recordings of the hummingbird genus Phaethornis
Phae <- querxc(qword = "Phaethornis", download = FALSE) 

# Print column names of data frame to explore metadata 
names(Phae) 


## ---- eval=FALSE---------------------------------------------------------
#  
#  # Check out the structure of the data frame
#  str(Phae)
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  # Query xeno-canto for all recordings of the species Phaethornis longirostris
#  Phae.lon <- querxc(qword = "Phaethornis longirostris", download = FALSE)
#  str(Phae.lon)
#  

## ---- eval=TRUE, echo=FALSE, message=FALSE-------------------------------

Phae.lon <- querxc(qword = "Phaethornis longirostris", download = FALSE) 


## ---- eval=FALSE---------------------------------------------------------
#  
#  # Image type default is jpeg, but tiff files have better resolution
#  
#  # When the data frame contains multiple species,
#  # you will have one map per species
#  xcmaps(X = Phae, img = TRUE, it = "tiff")
#  xcmaps(X = Phae.lon, img = FALSE)
#  

## ---- eval=TRUE, echo=FALSE, message=FALSE-------------------------------

xcmaps(X = Phae.lon, img = FALSE) 


## ---- eval=TRUE----------------------------------------------------------

# Find out number of available recordings
nrow(Phae.lon) 

# Find out how many types of signal descriptions exist in the xeno-canto metadata
levels(Phae.lon$Vocalization_type)

# How many recordings per signal type?
table(Phae.lon$Vocalization_type)


## ---- eval=TRUE----------------------------------------------------------

# There are many levels to the Vocalization_type variable. 
# Some are biologically relevant signals, but most just 
# reflect variation in data entry.

# Select just the signals we want
# Regular expression is always a good filtering option
Phae.lon.song <- Phae.lon[grep("song", Phae.lon$Vocalization_type, 
                                ignore.case = TRUE), ]

# Check resulting data frame
str(Phae.lon.song) 


## ---- eval=FALSE---------------------------------------------------------
#  
#  # In case you want more than one type of signals:
#  Phae.lon.sc <- Phae.lon[grep("song|call", Phae.lon$Vocalization_type,ignore.case = TRUE), ]
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  # How many recordings per locatity?
#  table(Phae.lon.song$Locality)
#  

## ---- eval=TRUE----------------------------------------------------------

# Filter by location
Phae.lon.LS <- Phae.lon.song[grep("La Selva Biological Station, Sarapiqui, Heredia", Phae.lon.song$Locality,
                              ignore.case = FALSE), ]

# Select highest quality recordings
Phae.lon.LS <- Phae.lon.LS[Phae.lon.LS$Quality == "A", ]


## ---- eval=TRUE----------------------------------------------------------

# map in the RStudio graphics device (img = FALSE)
xcmaps(Phae.lon.LS, img = FALSE)


## ---- eval=FALSE, echo=FALSE---------------------------------------------
#  
#  # Not working as of 01 Aug 2017
#  # This copies the selected sound files to a dropbox folder so they can be shared
#  # do not show this code
#  fn <- with(Phae.lon.LS, paste(paste(Genus, Specific_epithet, Recording_ID, sep = "-"), ".wav", sep = " "))
#  file.copy(from = file.path("/home/m/Documents/Biblioteca de cantos/Trochilidae/XC/wavs",fn), to = file.path("/home/m/Dropbox/Projects/warbleR package/vignette files", fn), overwrite = TRUE)
#  
#  wlist <- lapply(fn,function(x) downsample(readWave(file.path("/home/m/Dropbox/Projects/warbleR package/vignette files", x)), samp.rate = 22500))
#  
#  names(wlist) <- fn
#  
#  saveRDS(wlist, file = "/home/m/Dropbox/Sharing/warbleR/recs.RDS")
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  # Download sound files
#  querxc(X = Phae.lon.LS)
#  
#  # Save each data frame object as a .csv file
#  write.csv(Phae.lon.LS, "Phae_lon.LS.csv", row.names = FALSE)
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  # Neither of these functions requires arguments
#  # Always check you're in the right directory beforehand
#  # getwd()
#  mp32wav()
#  
#  # Use checkwavs to see if wav files can be read
#  checkwavs()
#  
#  # Create a list of all the recordings in the directory
#  wavs <- list.files(pattern = "wav$")
#  
#  # Downsample the wav files and speed up downstream analyses
#  invisible(lapply(wavs, function(x) writeWave(downsample(readWave(x), samp.rate = 22050),
#                                    filename = x)))

## ---- eval=FALSE, echo=FALSE---------------------------------------------
#  
#  # Not working 01 Aug 2017
#  
#  ### If you were unable to convert _mp3_ to _wav_ format:
#    + download the file in [this link](https://www.dropbox.com/s/htpbxbdw8s4i23k/recs.RDS?dl=0) and put it in your working directory
#    + then run the following code:
#  
#  
#  recs <- readRDS(file = "recs.RDS")
#  
#  for(i in 1:length(recs))
#    writeWave(recs[[i]], filename = names(recs)[i])
#  
#  *Note: In case you have your own recordings in _wav_ format and have skipped previous sections, you must specify the location of your sound files prior to running downstream functions.*
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  # Create a list of all the recordings in the directory
#  wavs <- list.files(pattern = "wav$")
#  
#  # Select a subset of recordings to explore lspec() arguments
#  # Based on the list of wav files we created above
#  sub <- wavs[c(1,3)]
#  
#  # How long are these files? will determine number of pages returned by lspec
#  wavdur(sub)
#  
#  # ovlp = 10 to speed up function
#  # tiff image files are better quality and are faster to produce
#  lspec(flist = sub, ovlp = 10, it = "tiff")
#  
#  # We can zoom in on the frequency axis by changing flim,
#  # the number of seconds per row, and number of rows
#  lspec(flist = sub, flim = c(2, 10), sxrow = 6, rows = 15, ovlp = 10, it = "tiff")
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  lspec(flim = c(2, 10), ovlp = 10, sxrow = 6, rows = 15, it = "jpeg")
#  
#  # concatenate lspec image files into a single PDF per recording
#  # lspec images must be jpegs
#  lspec2pdf(keep.img = FALSE, overwrite = TRUE)
#  

## ---- eval=FALSE, echo=FALSE---------------------------------------------
#  
#  # make all page-size images 700 pxls width

## ---- eval=FALSE---------------------------------------------------------
#  
#  # Select a subset of the recordings
#  wavs <- list.files(pattern = ".wav$", ignore.case = TRUE)
#  
#  # Set a seed so we all have the same results
#  set.seed(1)
#  sub <- wavs[sample(1:length(wavs), 3)]
#  
#  # Run autodetec() on subset of recordings
#  autodetec(flist = sub, bp = c(1, 10), threshold = 10, mindur = 0.05, maxdur = 0.5, envt="abs",
#            ssmooth = 300, ls = TRUE, res = 100,
#            flim = c(1, 12), wl = 300, set =TRUE, sxrow = 6, rows = 15,
#            redo = FALSE, it = "tiff")
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  autodetec(flist = sub, bp = c(2, 10), threshold = 20, mindur = 0.09, maxdur = 0.22,
#                       envt = "abs", ssmooth = 900, ls = TRUE, res = 100,
#                       flim= c(1, 12), wl = 300, set =TRUE, sxrow = 6, rows = 15,
#                       redo = TRUE, it = "tiff", img = TRUE, smadj = "end")

## ---- eval=FALSE---------------------------------------------------------
#  
#  Phae.ad <- autodetec(bp = c(2, 10), threshold = 20, mindur = 0.09, maxdur = 0.22,
#                       envt = "abs", ssmooth = 900, ls = TRUE, res = 100,
#                       flim = c(2, 10), wl = 300, set =TRUE, sxrow = 6, rows = 15,
#                       redo = TRUE, it = "tiff", img = TRUE, smadj = "end")
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  table(Phae.ad$sound.files)
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  # A margin that's too large causes other signals to be included in the noise measurement
#  # Re-initialize X as needed, for either autodetec or manualoc output
#  
#  # Try this with 10% of the selections first
#  # Set a seed first, so we all have the same results
#  set.seed(5)
#  
#  X <- Phae.ad[sample(1:nrow(Phae.ad),(nrow(Phae.ad)*0.1)), ]
#  
#  snrspecs(X = X, flim = c(2, 10), snrmar = 0.5, mar = 0.7, it = "tiff")
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  # This smaller margin is better
#  snrspecs(X = X, flim = c(2, 10), snrmar = 0.04, mar = 0.7, it = "tiff")
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  Phae.snr <- sig2noise(X = Phae.ad[seq(1, nrow(Phae.ad), 2), ], mar = 0.04)
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  Phae.hisnr <- Phae.snr[ave(-Phae.snr$SNR, Phae.snr$sound.files, FUN = rank) <= 5, ]
#  
#  # save the selections as a physical file
#  write.csv(Phae.hisnr, "Phae_hisnr.csv", row.names = FALSE)
#  
#  # Double check the number of selection per sound files
#  table(Phae.hisnr$sound.files)
#  

## ---- eval=TRUE, echo=FALSE----------------------------------------------

Phae.hisnr <- read.csv("Phae_hisnr.csv", header = TRUE)
table(Phae.hisnr$sound.files)


## ---- eval=FALSE---------------------------------------------------------
#  
#  # Run manualoc() with frequency range set for Phaethornis longirostris
#  # Recording comments are enabled to mark recording quality
#  # Selection comments enabled to include visual classifications
#  manualoc(flim = c(2, 10), reccomm = TRUE, selcomm = TRUE, osci = TRUE, seltime = 2)
#  
#  # Read manualoc() output back into RStudio as an object
#  # This data frame object can be used as input for later functions
#  manualoc_out <- read.csv("manualoc_output.csv", header = TRUE)
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  Phae.hisnr <- read.csv("Phae_hisnr.csv", header = TRUE)
#  
#  # remove SNR column and select the first sound file
#  sub <- droplevels(Phae.hisnr[Phae.hisnr$sound.files == levels(Phae.hisnr$sound.files)[1], -grep("SNR", names(Phae.hisnr))])
#  
#  str(sub)
#  
#  # extract recording name without ".wav" extension
#  # save filtered autodetec output as a Raven selection file
#  exp_raven(X = sub, file.name = paste(strsplit(unique(as.character(sub$sound.files)), split = ".w")[[1]][1], "hisnr", sep = "_"))
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  # the object sels will contain selections you made in the target recordings
#  # use arguments from imp.raven to return selection table in correct format for warbleR functions
#  sels <- run_raven(raven.path = "~/opt/Raven-1.5.0.0035/", sound.files = c("Phaethornis-longirostris-154072.wav", "Phaethornis-longirostris-154070.wav"), at.the.time = 2, import = TRUE, all.data = FALSE, name.from.file = TRUE, ext.case = "lower", freq.cols = FALSE)
#  str(sels)
#  
#  # write the imported selections as a .csv for later use
#  write.csv(sels, "Raven_sels.csv", row.names = FALSE)
#  

## ---- eval=TRUE, echo=FALSE----------------------------------------------

# xeno-canto mp3 files must be remade into wav files with the correct atrributes to work in Raven 
sels <- read.csv("Raven_sels.csv", header = TRUE)

str(sels)



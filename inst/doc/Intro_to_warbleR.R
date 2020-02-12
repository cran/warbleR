## ----extn_sel_2, echo = FALSE, message = FALSE----------------------------------------------------

rm(list = ls())

# unload all non-based packages
out <- sapply(paste('package:', names(sessionInfo()$otherPkgs), sep = ""), function(x) try(detach(x, unload = FALSE, character.only = TRUE), silent = T))

#load packages
library(warbleR)
library(knitr)

cf <- read.csv("function_descrip_table.csv", stringsAsFactors = FALSE)


data(list = c("Phae.long1", "Phae.long2", "Phae.long3", "Phae.long4"))
writeWave(Phae.long1, file.path(tempdir(), "Phae.long1.wav"))
writeWave(Phae.long2, file.path(tempdir(), "Phae.long2.wav"))
writeWave(Phae.long3, file.path(tempdir(), "Phae.long3.wav"))
writeWave(Phae.long4, file.path(tempdir(), "Phae.long4.wav")) 


warbleR_options(wav.path = tempdir()) 

options(knitr.table.format = "html") 
opts_chunk$set(comment = "")
opts_knit$set(root.dir = tempdir())
options(width = 100, max.print = 100)


## ----extn_sel_4.1, eval=FALSE---------------------------------------------------------------------
#  
#  data("lbh_selec_table")
#  
#  lbh_selec_table
#  

## ----extn_sel_4.2, echo=FALSE, eval = FALSE-------------------------------------------------------
#  
#  kbl <- kable(lbh_selec_table, align = "c", row.names = F,  format = "html")
#  
#  kbl <-  kable_styling(kbl, bootstrap_options = "striped", font_size = 14)
#  
#  kbl <- scroll_box(kbl, width = "740px",
#  box_css = "border: 1px solid #ddd; padding: 1px; ", extra_css = NULL)
#  
#  kbl
#  

## ----extn_sel_4.32, eval = FALSE------------------------------------------------------------------
#  
#  data(list = c("Phae.long1", "Phae.long2", "Phae.long3", "Phae.long4"))
#  writeWave(Phae.long1, file.path(tempdir(), "Phae.long1.wav"))
#  writeWave(Phae.long2, file.path(tempdir(), "Phae.long2.wav"))
#  writeWave(Phae.long3, file.path(tempdir(), "Phae.long3.wav"))
#  writeWave(Phae.long4, file.path(tempdir(), "Phae.long4.wav"))
#  
#  # parametros globales
#  warbleR_options(wav.path = tempdir())
#  
#  st <- selection_table(X = lbh_selec_table, pb = FALSE)
#  
#  st

## ---- eval = TRUE, echo = FALSE-------------------------------------------------------------------

st <- selection_table(X = lbh_selec_table, pb = FALSE)

st

## -------------------------------------------------------------------------------------------------

class(st)


## ----extn_sel_4.3, eval = FALSE-------------------------------------------------------------------
#  
#  
#  #  global parameters
#  warbleR_options(wav.path = "PONER RUTA A 'ejemplos' AQUI")
#  
#  
#  ext_st <- selection_table(X = lbh_selec_table, pb = FALSE,
#            extended = TRUE, confirm.extended = FALSE)
#  

## ----extn_sel_4.33, eval = TRUE, echo = FALSE-----------------------------------------------------

ext_st <- selection_table(X = lbh_selec_table, pb = FALSE, 
          extended = TRUE, confirm.extended = FALSE)



## ----extn_sel_5-----------------------------------------------------------------------------------

is_extended_selection_table(ext_st)


## ----extn_sel_6-----------------------------------------------------------------------------------

ext_st2 <- ext_st[1:2, ]

is_extended_selection_table(ext_st2)


## ----extn_sel_7-----------------------------------------------------------------------------------

## print
print(ext_st)


## ----extn_sel_7.1, eval=FALSE---------------------------------------------------------------------
#  
#  ext_st
#  

## ----extn_sel_7/2, echo=FALSE---------------------------------------------------------------------

print(ext_st)


## ----extn_sel_8, eval = FALSE---------------------------------------------------------------------
#  
#  ext_st3 <- ext_st[1:5, ]
#  
#  ext_st4 <- ext_st[6:11, ]
#  
#  ext_st5 <- rbind(ext_st3, ext_st4)
#  
#  #print
#  ext_st5
#  

## ----extn_sel_8.1, echo=FALSE---------------------------------------------------------------------

ext_st3 <- ext_st[1:5, ]

ext_st4 <- ext_st[6:11, ]

ext_st5 <- rbind(ext_st3, ext_st4)

#print
print(ext_st5)


## ----extn_sel_8.2---------------------------------------------------------------------------------

# igual q el original
all.equal(ext_st, ext_st5)


## ----extn_sel_8.21--------------------------------------------------------------------------------

wv1 <- read_wave(X = ext_st, index = 3, from = 0, to = 0.37)


## ----extn_sel_8.22, out.width= 750----------------------------------------------------------------

class(wv1)

wv1

spectro(wv1, wl = 150, grid = FALSE, scale = FALSE, ovlp = 90)

## ----extn_sel_8.23, out.width= 750----------------------------------------------------------------
par(mfrow = c(3, 2), mar = rep(0, 4))

for(i in 1:6){
  
  wv <- read_wave(X = ext_st, index = i, from = 0.05, to = 0.32)

  spectro(wv, wl = 150, grid = FALSE, scale = FALSE, axisX = FALSE,
          axisY = FALSE, ovlp = 90)

}


## ----extn_sel_8.24--------------------------------------------------------------------------------

# crear nueva base de datos
Y <- data.frame(sound.files = ext_st$sound.files, site = "La Selva", lek = c(rep("SUR", 5), rep("CCL", 6)))

# combinar
mrg_ext_st <- merge(ext_st, Y, by = "sound.files")

# revisar clase
is_extended_selection_table(mrg_ext_st)


## ----extn_sel_8.25--------------------------------------------------------------------------------

# arreglar
mrg_ext_st <- fix_extended_selection_table(X = mrg_ext_st, Y = ext_st)

# revisar clase
is_extended_selection_table(mrg_ext_st)


## ----extn_sel_12.1, eval=FALSE--------------------------------------------------------------------
#  
#  #  parametros espectrales
#  sp <- specan(ext_st)
#  
#  sp

## ---- extn_sel_12.2, echo= FALSE, eval = FALSE----------------------------------------------------
#  
#  sp <- specan(ext_st)
#  
#  kbl <- kable(sp, align = "c", row.names = F,  format = "html")
#  
#  kbl <-  kable_styling(kbl, bootstrap_options = "striped", font_size = 14)
#  
#  kbl <- scroll_box(kbl, width = "740px",
#  box_css = "border: 1px solid #ddd; padding: 1px; ", extra_css = NULL)
#  
#  kbl
#  
#  

## ----extn_sel_12.5, eval=FALSE--------------------------------------------------------------------
#  
#  snr <- sig2noise(ext_st, mar = 0.05)
#  
#  snr

## ---- extn_sel_12.6, echo= FALSE, eval = FALSE----------------------------------------------------
#  
#  snr <- sig2noise(ext_st, mar = 0.05)
#  
#  kbl <- kable(snr, align = "c", row.names = F,  format = "html")
#  
#  kbl <-  kable_styling(kbl, bootstrap_options = "striped", font_size = 14)
#  
#  kbl <- scroll_box(kbl, width = "740px",
#  box_css = "border: 1px solid #ddd; padding: 1px; ", extra_css = NULL)
#  
#  kbl
#  

## ----extn_sel_12.7, eval=FALSE--------------------------------------------------------------------
#  
#  dtw.dist <- dfDTW(ext_st, img = FALSE)
#  
#  dtw.dist
#  

## ---- extn_sel_12.8, echo= FALSE, eval = FALSE----------------------------------------------------
#  
#  dtw.dist <- dfDTW(ext_st, img = FALSE)
#  
#  kbl <- kable(dtw.dist, align = "c", row.names = T,  format = "html")
#  
#  kbl <-  kable_styling(kbl, bootstrap_options = "striped", font_size = 14)
#  
#  kbl <- scroll_box(kbl, width = "740px",
#  box_css = "border: 1px solid #ddd; padding: 1px; ", extra_css = NULL)
#  
#  kbl
#  

## ----extn_sel_13, eval = FALSE--------------------------------------------------------------------
#  
#  # create long selection table
#  lng.selec.table <- do.call(rbind, replicate(10, lbh_selec_table,
#                          simplify = FALSE))
#  
#  # relabels selec
#  lng.selec.table$selec <- 1:nrow(lng.selec.table)
#  
#  # create extended selection table
#  lng_ext_st <- selection_table(X = lng.selec.table, pb = FALSE,
#                          extended = TRUE, confirm.extended = FALSE)
#  
#  
#  # load packages
#  library(microbenchmark)
#  library(ggplot2)
#  
#  # check performance
#  mbmrk.snr <- microbenchmark(extended = sig2noise(lng_ext_st,
#        mar = 0.05), regular = sig2noise(lng.selec.table,
#                      mar = 0.05), times = 50)
#  
#  autoplot(mbmrk.snr) + ggtitle("sig2noise")
#  

## -------------------------------------------------------------------------------------------------

data("Phae.long.est")

Phae.long.est

table(Phae.long.est$lek.song.type)


## ---- eval = FALSE, echo = FALSE------------------------------------------------------------------
#  
#  library(warbleR)
#  
#  wf <- ls("package:warbleR")
#  
#  wf <- wf[-c(2, 7, 8, 10, 12, 16, 17, 19, 20, 23, 24, 28, 31, 32, 33, 38, 42, 43, 44, 47, 50, 53, 59, 64, 66, 68, 68, 72, 74, 80, 81, 85, 90, 93, 94, 96)]
#  
#  df <- data.frame(funciones = wf, `Obtener-preparar grabaciones` = "", `Anotar` = "", `Medir` = "",  `Revision` = "", `Inspección visual` = "", `Análisis estadístico` = "", `Otros` = "")
#  
#  df2 <- edit(df)
#  
#  
#  df2$`organizar.anotaciones` <- ""
#  
#  names(df2) <- names(df2)[c(1:3, 9, 4:8)]
#  
#  df3 <- edit(df2)
#  
#  df4 <- df3
#  
#  df4[is.na(df4)] <- ""
#  
#  df4 <- df4[df4$Obtener.preparar.grabaciones != "borrar", ]
#  
#  names(df4) <- c("Función", "Obtener-preparar grabaciones", "Anotar", "Organizar anotaciones", "Medir estructura", "Verificar", "Inspección visual", "Análisis estadístico", "Otros")
#  
#  rownames(df4) <- 1:nrow(df4)
#  
#  df5 <- df4[order(df4$`Obtener-preparar grabaciones`, df4$Anotar, df4$`Organizar anotaciones`, df4$`Medir estructura`, df4$Verificar, df4$`Inspección visual`, df4$`Análisis estadístico`, df4$Otros, decreasing = TRUE),]
#  
#  df4 <- df4[c(5, 8, 18, 29, 34, 35, 37, 38, 39, 55, 56, 26, 1, 19, 40, 46, 4, 11, 16, 17, 24, 25, 32, 41, 45, 7, 12, 13, 14, 15, 23, 27, 30, 42, 47, 48, 57, 2,  3, 28, 44, 50, 51, 52, 58, 9, 10, 21, 22, 59, 6, 20, 31, 33, 36, 43, 49, 53, 54), ]
#  
#  # write.csv(df4, "cuadro de funciones warbleR.csv", row.names = FALSE)
#  

## ---- echo = FALSE, eval = FALSE------------------------------------------------------------------
#  
#  library(kableExtra)
#  
#  names(cf) <- gsub("\\.", " ", names(cf))
#  
#  cf2 <- cf[cf$`Obtener preparar grabaciones` == "x", c("Function", "Description", "Works on", "Output")]
#  
#  cf2$Function <- cell_spec(x = cf2$Function, link = paste0("https://marce10.github.io/warbleR/reference/", cf2$Function, ".html"))
#  
#  kbl <- kable(cf2, align = "c", row.names = F,  format = "html", escape = F)
#  
#  kbl <- column_spec(kbl, 1, bold = TRUE)
#  
#  kbl <- column_spec(kbl, 2:4, italic = TRUE)
#  
#  kbl <-  kable_styling(kbl, bootstrap_options = "striped", font_size = 14)
#  
#  kbl
#  

## ---- echo = FALSE, eval = FALSE------------------------------------------------------------------
#  
#  cf2 <- cf[cf$Anotar == "x",  c("Function", "Description", "Works on", "Output")]
#  
#  cf2$Function <- cell_spec(x = cf2$Function, link = paste0("https://marce10.github.io/warbleR/reference/", cf2$Function, ".html"))
#  
#  kbl <- kable(cf2, align = "c", row.names = F,  format = "html", escape = F)
#  
#  kbl <- column_spec(kbl, 1, bold = TRUE)
#  
#  kbl <- column_spec(kbl, 2:4, italic = TRUE)
#  
#  kbl <-  kable_styling(kbl, bootstrap_options = "striped", font_size = 14)
#  
#  kbl
#  

## ---- echo = FALSE, eval = FALSE------------------------------------------------------------------
#  
#  cf2 <- cf[cf$`Organizar anotaciones` == "x",  c("Function", "Description", "Works on", "Output")]
#  
#  cf2$Function <- cell_spec(x = cf2$Function, link = paste0("https://marce10.github.io/warbleR/reference/", cf2$Function, ".html"))
#  
#  kbl <- kable(cf2, align = "c", row.names = F,  format = "html", escape = F)
#  
#  kbl <- column_spec(kbl, 1, bold = TRUE)
#  
#  kbl <- column_spec(kbl, 2:4, italic = TRUE)
#  
#  kbl <-  kable_styling(kbl, bootstrap_options = "striped", font_size = 14)
#  
#  kbl
#  

## ---- echo = FALSE, eval = FALSE------------------------------------------------------------------
#  
#  cf2 <- cf[cf$`Medir estructura` == "x",  c("Function", "Description", "Works on", "Output")]
#  
#  cf2$Function <- cell_spec(x = cf2$Function, link = paste0("https://marce10.github.io/warbleR/reference/", cf2$Function, ".html"))
#  
#  kbl <- kable(cf2, align = "c", row.names = F,  format = "html", escape = F)
#  
#  kbl <- column_spec(kbl, 1, bold = TRUE)
#  
#  kbl <- column_spec(kbl, 2:4, italic = TRUE)
#  
#  kbl <-  kable_styling(kbl, bootstrap_options = "striped", font_size = 14)
#  
#  kbl
#  

## ---- echo = FALSE, eval = FALSE------------------------------------------------------------------
#  
#  cf2 <- cf[cf$Verificar == "x",  c("Function", "Description", "Works on", "Output")]
#  
#  cf2$Function <- cell_spec(x = cf2$Function, link = paste0("https://marce10.github.io/warbleR/reference/", cf2$Function, ".html"))
#  
#  kbl <- kable(cf2, align = "c", row.names = F,  format = "html", escape = F)
#  
#  kbl <- column_spec(kbl, 1, bold = TRUE)
#  
#  kbl <- column_spec(kbl, 2:4, italic = TRUE)
#  
#  kbl <-  kable_styling(kbl, bootstrap_options = "striped", font_size = 14)
#  
#  kbl
#  

## ---- echo = FALSE, eval = FALSE------------------------------------------------------------------
#  
#  cf2 <- cf[cf$`Inspección visual` == "x",  c("Function", "Description", "Works on", "Output")]
#  
#  cf2$Function <- cell_spec(x = cf2$Function, link = paste0("https://marce10.github.io/warbleR/reference/", cf2$Function, ".html"))
#  
#  kbl <- kable(cf2, align = "c", row.names = F,  format = "html", escape = F)
#  
#  kbl <- column_spec(kbl, 1, bold = TRUE)
#  
#  kbl <- column_spec(kbl, 2:4, italic = TRUE)
#  
#  kbl <-  kable_styling(kbl, bootstrap_options = "striped", font_size = 14)
#  
#  kbl
#  

## ---- echo = FALSE, eval = FALSE------------------------------------------------------------------
#  
#  cf2 <- cf[cf$`Análisis estadístico` == "x" | cf$Otros == "x",  c("Function", "Description", "Works on", "Output")]
#  
#  cf2$Function <- cell_spec(x = cf2$Function, link = paste0("https://marce10.github.io/warbleR/reference/", cf2$Function, ".html"))
#  
#  kbl <- kable(cf2, align = "c", row.names = F,  format = "html", escape = F)
#  
#  kbl <- column_spec(kbl, 1, bold = TRUE)
#  
#  kbl <- column_spec(kbl, 2:4, italic = TRUE)
#  
#  kbl <-  kable_styling(kbl, bootstrap_options = "striped", font_size = 14)
#  
#  kbl
#  

## ----session info, echo=F-------------------------------------------------------------------------

sessionInfo()



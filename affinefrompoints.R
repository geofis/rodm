setwd() #This step set the working directory containing both images and .point files
#The script assumes that both images and .point files are named consistently
affinegcpfiles <- list.files(getwd(), 'points')
warpingsentences <- sapply(
  affinegcpfiles, function(x){
    gcpfile <- read.csv(x)
    sentence <- paste0(
      "convert ",
      gsub('.points', '', x), ' ',
      "-virtual-pixel black -distort Affine '",
      paste0(
        with(gcpfile,
             paste0(
               round(pixelX,0), ",", round(abs(pixelY),0), " ",
               round(mapX,0), ",", round(abs(mapY),0)
             )
        ),
        collapse=' '), "' ",
      "-crop ", max(abs(gcpfile$mapX)), "x", max(abs(gcpfile$mapY)), "+0+0",
      " aff_", gsub('.points', '', x)
    )
    system(sentence)
  }, simplify = T, USE.NAMES = F
)
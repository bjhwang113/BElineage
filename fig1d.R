#!/usr/bin/Rscript



# zones <- matrix(c(1,1,1, 
                  # 0,5,0, 
                  # 2,6,4, 
                  # 0,3,0), ncol = 3, byrow = TRUE)
# layout(zones, widths=c(0.3,4,1), heights = c(1,3,10,.75))
# layout.show(n=6)


scatterhist <- function(x, y, xlab = "", ylab = "", plottitle="", xsize=1, cleanup=TRUE,...){
  # save the old graphics settings-- they may be needed
  def.par <- par(no.readonly = TRUE)
  
  zones <- matrix(c(1,1,1, 0,5,0, 2,6,4, 0,3,0), ncol = 3, byrow = TRUE)
  layout(zones, widths=c(0.3,4,1), heights = c(1,3,10,.75))
  
  # tuning to plot histograms nicely
  xhist <- hist(x, plot = FALSE)
  yhist <- hist(y, plot = FALSE)
  top <- max(c(xhist$counts, yhist$counts))
  
  # for all three titles: 
  #   drop the axis titles and omit boxes, set up margins
  par(xaxt="n", yaxt="n",bty="n",  mar = c(.3,2,.3,0) +.05)
  # fig 1 from the layout
  plot(x=1,y=1,type="n",ylim=c(-1,1), xlim=c(-1,1))
  text(0,0,paste(plottitle), cex=2)
  # fig 2
  plot(x=1,y=1,type="n",ylim=c(-1,1), xlim=c(-1,1))
  text(0,0,paste(ylab), cex=1.5, srt=90)
  # fig 3
  plot(x=1,y=1,type="n",ylim=c(-1,1), xlim=c(-1,1))
  text(0,0,paste(xlab), cex=1.5)
  
  # fig 4, the first histogram, needs different margins
  # no margin on the left
  par(mar = c(2,0,1,1))
  barplot(yhist$counts, axes = FALSE, xlim = c(0, top),
          space = 0, horiz = TRUE)
  # fig 5, other histogram needs no margin on the bottom
  par(mar = c(0,2,1,1))
  barplot(xhist$counts, axes = FALSE, ylim = c(0, top), space = 0)
  # fig 6, finally, the scatterplot-- needs regular axes, different margins
  par(mar = c(2,2,.5,.5), xaxt="s", yaxt="s", bty="n")
  # this color allows traparency & overplotting-- useful if a lot of points
  plot(x, y , xlim=c(0,20), ylim=c(0,20), pch=19, col="#00000022", cex=xsize, ...)
  
  # reset the graphics, if desired 
  if(cleanup) {par(def.par)}
}



fig1c <- read.table("fig1c_input_final2.txt")

x<- fig1c$V1
y<- fig1c$V2

scatterhist(x,y, xsize = 1)
# abline(lm(y~x), col="red")



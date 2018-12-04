#!/usr/bin/R

# for visualization of the trees
library(collapsibleTree)

test <- read.csv("fig2c_new1.csv")

collapsibleTree(
  test,
  hierarchy = c("FIRSTGEN", "SECONDGEN", "THIRDGEN", "FOURTH", "FIFTH"), 
  fill = c(
    # The root
    "seashell",
    # Unique first
    rep("forestgreen", length(unique(test$FIRSTGEN))),
    # Unique second per first node
    rep("forestgreen", length(unique(paste(test$FIRSTGEN, test$SECONDGEN)))),
    # Unique third per second node
    rep("forestgreen", length(unique(paste(test$SECONDGEN, test$THIRDGEN)))),
	# Unique fourth per third node
    rep("forestgreen", length(unique(paste(test$THIRDGEN, test$FOURTH)))),
	# Unique fifth per fourth node
    rep("forestgreen", length(unique(paste(test$FOURTH, test$FIFTH))))
	
  )
)


# below is working example

collapsibleTree(
  test,
  hierarchy = c("FIRSTGEN", "SECONDGEN"), 
  fillBylevel=FALSE,
  fill = c(
    # The root
    "seashell",
    # Unique first
    rep("forestgreen", length(unique(test$FIRSTGEN))),
    # Unique second per first node
    rep("forestgreen", length(unique(paste(test$FIRSTGEN, test$SECONDGEN))))
	)
)

sgRNA_1 <- read.csv("fig2c_input.csv")
# sgRNA_1$Color <- sgRNA_1$
levels(sgRNA_1$COL) <- colorspace::rainbow_hcl(11)

collapsibleTreeNetwork(
  sgRNA_1, 
   fill = "Color"
  )
	
collapsibleTreeNetwork(
  test, collapsed = FALSE, fill=c("yellow"),tooltipHtml=NULL,
  )
 
 
# 1-3 clone_2
# 1-8 clone3
# 1-10 clone4
# 1-13 clone5
# 1-16 clone6
# 1-20 clone7
# 1-21 clone8
# 1-24 clone9

# sgRNA_1 tree
 
org <- data.frame(
  Manager = c(
    NA, "sgRNA_1", "sgRNA_1", "sgRNA_1", "sgRNA_1", "sgRNA_1", "sgRNA_1", "sgRNA_1", "sgRNA_1",
    "1-3", "1-3", "1-3", "1-3", "1-8", "1-8", "1-8", "1-8", "1-13", "1-13", "1-13", "1-13", "1-20", "1-20","1-20","1-20",
  "1-3-1","1-3-1","1-3-1","1-3-1","1-3-2","1-3-2","1-3-2","1-3-2","1-3-3","1-3-3","1-3-3","1-3-3","1-3-4","1-3-4","1-3-4","1-3-4","1-8-1","1-8-1","1-8-1","1-8-1","1-8-2","1-8-2","1-8-2","1-8-2","1-8-3","1-8-3","1-8-3","1-8-3", "1-13-1","1-13-2","1-13-3","1-13-4","1-20-1","1-20-2","1-20-3","1-20-4",
  "1-3-1-1","1-3-1-2","1-3-1-3","1-3-1-4","1-3-2-1","1-3-2-2","1-3-2-3","1-3-2-4","1-3-3-1","1-3-3-2","1-3-3-3","1-3-3-4","1-3-4-1","1-3-4-2","1-3-4-3","1-3-4-4","1-8-1-1","1-8-1-2","1-8-1-3","1-8-1-4","1-8-2-1","1-8-2-2","1-8-2-3","1-8-2-4","1-8-3-1","1-8-3-2","1-8-3-3","1-8-3-4"),
  Employee = c(
    "sgRNA_1", "1-3", "1-8", "1-10", "1-13", "1-16", "1-20", "1-21","1-24",
    "1-3-1", "1-3-2", "1-3-3", "1-3-4", "1-8-1", "1-8-2", "1-8-3", "1-8-4", "1-13-1", "1-13-2", "1-13-3", "1-13-4", "1-20-1", "1-20-2","1-20-3","1-20-4",
"1-3-1-1","1-3-1-2","1-3-1-3","1-3-1-4","1-3-2-1","1-3-2-2","1-3-2-3","1-3-2-4","1-3-3-1","1-3-3-2","1-3-3-3","1-3-3-4","1-3-4-1","1-3-4-2","1-3-4-3","1-3-4-4", "1-8-1-1","1-8-1-2","1-8-1-3","1-8-1-4","1-8-2-1","1-8-2-2","1-8-2-3","1-8-2-4","1-8-3-1","1-8-3-2","1-8-3-3","1-8-3-4","1-13-1-1","1-13-2-1","1-13-3-1","1-13-4-1","1-20-1-1","1-20-2-1","1-20-3-1","1-20-4-1",
 "1-3-1-1-1","1-3-1-2-1","1-3-1-3-1","1-3-1-4-1","1-3-2-1-1","1-3-2-2-1","1-3-2-3-1","1-3-2-4-1","1-3-3-1-1","1-3-3-2-1","1-3-3-3-1","1-3-3-4-1","1-3-4-1-1","1-3-4-2-1","1-3-4-3-1","1-3-4-4-1","1-8-1-1-1","1-8-1-2-1","1-8-1-3-1","1-8-1-4-1","1-8-2-1-1","1-8-2-2-1","1-8-2-3-1","1-8-2-4-1","1-8-3-1-1","1-8-3-2-1","1-8-3-3-1","1-8-3-4-1"),
  Title = c(
    "clone_1","clone_2","clone_3","clone_4","clone_5","clone_6","clone_7","clone_8","clone_9",
	"clone_2","clone_2","clone_2","clone_2","clone_3","clone_3","clone_3","clone_3","clone_5","clone_5","clone_5","clone_5","clone_7","clone_7","clone_7","clone_7",
	"clone_2","clone_2","clone_2","clone_2","clone_2","clone_2","clone_2","clone_2","clone_2","clone_2","clone_2","clone_2","clone_2","clone_2","clone_2","clone_2", "clone_3","clone_3","clone_3","clone_3","clone_3","clone_3","clone_3","clone_3","clone_3","clone_3","clone_3","clone_3","clone_5","clone_5","clone_5","clone_5","clone_7","clone_7","clone_7","clone_7",
	"clone_2","clone_2","clone_2","clone_2","clone_2","clone_2","clone_2","clone_2","clone_2","clone_2","clone_2","clone_2","clone_2","clone_2","clone_2","clone_2","clone_3","clone_3","clone_3","clone_3","clone_3","clone_3","clone_3","clone_3","clone_3","clone_3","clone_3","clone_3")
 )


# colorspace::rainbow_hcl(8)
#'yellow','green','blue','indigo','violet','black','grey','orange')
# levels(org$Color) 
org$Color <- org$Title
levels(org$Color)<- c('red','#E495A5', '#D2A277','#ABB065','#72BB83', '#39BEB1','#64B5D6','#ACA4E2','#D995CF')

collapsibleTreeNetwork(org, fill = "Color",  collapsed=FALSE)
   

# sgRNA_3 tree
# 3-1 clone_2
# 3-6 clone3
# 3-10 clone4
# 3-13 clone5

org2 <- data.frame(
  Manager = c(
    NA, "sgRNA_3", "sgRNA_3", "sgRNA_3", "sgRNA_3",
    "3-1", "3-1", "3-1", "3-6", "3-6", "3-6", "3-6", "3-10", "3-13",
  "3-1-1","3-1-2","3-1-2","3-1-2","3-6-3","3-6-4","3-13-1","3-13-1","3-13-1",
  "3-1-2-1","3-1-2-2","3-1-2-2","3-1-2-2","3-1-2-3","3-13-1-1","3-13-1-1","3-13-1-1","3-13-1-1","3-13-1-2","3-13-1-2","3-13-1-3","3-13-1-3"),
  Employee = c(
    "sgRNA_3", "3-1", "3-6", "3-10", "3-13",
    "3-1-1", "3-1-2", "3-1-3", "3-6-1", "3-6-2", "3-6-3", "3-6-4", "3-10-1", "3-13-1",
"3-1-1-1","3-1-2-1","3-1-2-2","3-1-2-3","3-6-3-1","3-6-4-1","3-13-1-1","3-13-1-2","3-13-1-3",
 "3-1-2-1-2","3-1-2-2-1","3-1-2-2-2","3-1-2-2-3","3-1-2-3-2","3-13-1-1-1","3-13-1-1-2","3-13-1-1-3","3-13-1-1-4","3-13-1-2-2","3-13-1-2-4","3-13-1-3-1","3-13-1-3-3"),
  Title = c(
    "clone_1","clone_2","clone_3","clone_4","clone_5",
	"clone_2","clone_2","clone_2","clone_3","clone_3","clone_3","clone_3","clone_4", "clone_5",
	"clone_2","clone_2","clone_2", "clone_2","clone_3","clone_3","clone_5","clone_5","clone_5",
	"clone_2","clone_2","clone_3","clone_2","clone_2","clone_5","clone_5","clone_4","clone_5","clone_5","clone_5","clone_4","clone_5")
 )
# #ABB065 3rd color ambiguous  -> blue
org2$Color <- org2$Title
levels(org2$Color)<- c('red','#E495A5', '#D2A277','skyblue','#72BB83')

collapsibleTreeNetwork(
  org2, 
   fill = "Color", collapsed=FALSE) 

# sgRNA_3  HELA tree
# 3-1 clone_2
# 3-3 clone3
# 3-6 clone4
# 3-8 clone5

org3 <- data.frame(
  Manager = c(
    NA, "sgRNA_3", "sgRNA_3", "sgRNA_3", "sgRNA_3",
    "3-1", "3-1", "3-1", "3-3", "3-3", "3-3", "3-6", "3-6", "3-6", "3-8", "3-8", "3-8",
  "3-1-2","3-1-2","3-1-3","3-1-3","3-1-4","3-1-4","3-3-1","3-3-1","3-3-2", "3-3-2","3-3-3", "3-6-2","3-6-2","3-6-3","3-6-4","3-6-4","3-8-1","3-8-1", "3-8-2","3-8-2", "3-8-3","3-8-3",
  "3-1-2-2","3-1-2-3","3-1-3-2","3-1-3-3","3-1-4-2","3-1-4-3","3-3-1-2","3-3-1-3","3-3-2-2","3-3-2-3","3-3-3-1","3-6-2-2","3-6-2-3","3-6-3-1","3-6-4-1","3-6-4-2","3-8-1-1","3-8-1-2","3-8-2-1","3-8-2-2", "3-8-3-1", "3-8-3-2"),
  Employee = c(
    "sgRNA_3", "3-1", "3-3", "3-6", "3-8",
    "3-1-2", "3-1-3", "3-1-4", "3-3-1", "3-3-2", "3-3-3", "3-6-2", "3-6-3", "3-6-4", "3-8-1", "3-8-2", "3-8-3",
"3-1-2-2","3-1-2-3","3-1-3-2","3-1-3-3","3-1-4-2","3-1-4-3","3-3-1-2","3-3-1-3","3-3-2-2","3-3-2-3","3-3-3-1","3-6-2-2","3-6-2-3","3-6-3-1","3-6-4-1","3-6-4-2","3-8-1-1","3-8-1-2","3-8-2-1","3-8-2-2","3-8-3-1","3-8-3-2",
 "3-1-2-2-1","3-1-2-3-1","3-1-3-2-1","3-1-3-3-1","3-1-4-2-1","3-1-4-3-1","3-3-1-2-1","3-3-1-3-1","3-3-2-2-1","3-3-2-3-1","3-3-3-1-1","3-6-2-2-1","3-6-2-3-1","3-6-3-1-1", "3-6-4-1-1", "3-6-4-2-1", "3-8-1-1-1", "3-8-1-2-1", "3-8-2-1-1", "3-8-2-2-1", "3-8-3-1-1", "3-8-3-2-1"),
  Title = c(
    "clone_1","clone_2","clone_3","clone_4","clone_5",
	"clone_2","clone_2","clone_2","clone_3","clone_3","clone_3","clone_4","clone_4", "clone_4", "clone_5","clone_5","clone_5",
	"clone_2","clone_2","clone_2", "clone_2","clone_2","clone_2","clone_3","clone_3","clone_3","clone_3","clone_3","clone_4","clone_4","clone_4","clone_4","clone_4","clone_5","clone_5","clone_5","clone_5","clone_5","clone_5",
	"clone_2","clone_2","clone_2","clone_2","clone_3","clone_2","clone_3","clone_3","clone_3","clone_3","clone_2","clone_4","clone_4","clone_4","clone_4","clone_4","clone_5","clone_5","clone_4","clone_5","clone_5","clone_4")
 )

org3$Color <- org3$Title
levels(org3$Color)<- c('red','#E495A5', '#D2A277','skyblue','#72BB83')

collapsibleTreeNetwork(
  org3, 
   fill = "Color", collapsed=FALSE)    
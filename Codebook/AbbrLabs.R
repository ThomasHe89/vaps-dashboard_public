#########################################################################
### Title:  Gener AbbrLabs.csv
###
### Author: Hauke Licht
### Data:   August 4, 2016
### produced under R version 3.2.3

# IMPORTANT: Set working directory to local 'vaps-dashboard_public' directory first
if ( Sys.info()["user"] == "lichthau" ) { setwd("~/Documents/Humboldt/Electoral_Vulnerability/Projects/vaps-dashboard_public/Codebook/TeX/")
} else if ( Sys.info()["user"] == "johndoe" ) { setwd("../vaps-dashboard_public/Codebook/TeX/")
} else if ( Sys.info()["user"] == "mio-mio1" ) { setwd("../vaps-dashboard_public/Codebook/TeX/")
} else warning("Sorry, but could not find path to 'vaps-Codebook/TeX' directory.")

system(paste("cd",getwd()))
system("pwd")
system("ls *.txt")
system("rm content.txt")
system("touch content.txt")
system("ls *.tex | cat > content.txt")
system("ls *.txt")
system("cat content.txt")

tabs.tex <- read.delim("content.txt",header=F,sep="\n")
tabs.tex <- as.character(tabs.tex[grepl("tab_",tabs.tex[,1]),1])

B <- data.frame(abbr="1",label="1")
  
  for (a in seq_along(tabs.tex)) {
    A <- read.csv(tabs.tex[a], header = F, sep="&")
    A$abbr <- gsub("[\\]","",A$V1)
    A$abbr <- gsub("[[:blank:]]","",A$abbr)
    A <- A[!grepl("tabularnewline",A$abbr),]
    
    A$label <- gsub("[\\]footnote.*|[\\]footref.*|[\\]tabularnewline.*","",A$V2)
    A$label <- gsub("[\t]","",A$label)
    A$label <- trimws(A$label)
    
    A <- A[,c("abbr", "label")]
    B <- rbind(B,A)
  }
AbbrLabs <- as.data.frame( apply(B,2,function(x) as.character(x)), stringsAsFactors = F)
AbbrLabs <- AbbrLabs[grepl("[[:alpha:]|.*[:digit:].$]", AbbrLabs$abbr),]
AbbrLabs

write.csv(AbbrLabs,"../../AbbrLabs.csv")  # write in local vaps-dashboard_public directory

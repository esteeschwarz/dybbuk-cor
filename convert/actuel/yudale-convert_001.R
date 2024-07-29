#14313.yudale.TEI.refactoring
#20240729(19.51)
################
# base convert .txt to eazydrama markup for further TEI conversion
##################################################################
# Q:
src<-"~/boxHKW/21S/DH/local/EXC2020/dybbuk/yudale_xml-edited006.14312-FIN/yudale_xml-edited006.14312-FIN.m.txt"
text<-readLines(src)
# regex arrays
# speaker:
m<-grep(":",text)
length(m)
head(text[m],15)

#manual
#frontispiz
a1<-21:30
#dramatis personae
a2<-37:50
#head 1
a3<-56
######
#tag speaker
m.sp<-m[2:length(m)]
###
text.1<-text
text.1[m.sp]<-paste0(text.1[m.sp],"@")
text.1[m.sp[1:10]]
#wks.
#####
# m<-grep("[()]",text.1)
# length(m)
# m1<-m>=a3
# m<-m[m1]
# reg1<-"[()]"
# text.1[m[1]]
# text.1[m[1]]<-gsub(reg1,"$",text.1[m[1]])
# text.1[m[1]]
# text.1[m]<-gsub(reg1,"$",text.1[m])
# 
text.1[56:100]
# NOTE ezdrama
#$ means new stage direction. NB: brackets like this () are converted to stage directions automatically and do not require any special treatment with metasymbols. In case you don't want brackets to be treated as metasymbols, initialize Parser with bracketstages = False (this parameter is True by default) NB 2: the $ will also put into the current stage tag all next lines before any new metasymbol
###
# acts
# library(stringi)
# ract<-stri_split_regex(text.1[56]," ",simplify = T)
# ract
# m2<-grep(ract,text.1)
# length(m2)
# ract.c <- gsub("\\p{M}", "", ract, perl = TRUE)
# m3<-grep(ract.c,text.1)
# length(m3)
# 
# text.1[m3]
actm<-c(56,577)
text.1[56]<-paste0(text.1[56],"#")
text.1[actm]
text.1[577]<-paste0(text.1[577],"#")

#dramatis_personae
cast<-37
text.1[37]<-paste0(text.1[37],"^")

#pagebreaks
m<-grep("[0-9]{1,2}",text.1)
length(m)
#no. first correct in transcription source
###
writeLines(text.1,"~/boxHKW/21S/DH/local/EXC2020/dybbuk/TEI/yudale_ezd_pre.txt")


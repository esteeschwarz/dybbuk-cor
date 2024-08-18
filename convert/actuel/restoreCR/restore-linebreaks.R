#20240818(11.32)
#14342.linebreaks restore essai
###############################
# Q: https://scm.cms.hu-berlin.de/schluesselstellen/quid

###############################
library(jsonlite)
quid<-read_json("quid_result-6.json")
# looks good
library(readtext)
transcript_ed<-readtext("yudale_edit_01-06.txt")$text
transcript_pre<-readtext("yudale_pre_01-06.txt")$text
corpus.ed.chars<-unlist(strsplit(transcript_ed,""))
corpus.pre.chars<-unlist(strsplit(transcript_pre,""))
corpus.cr.res<-corpus.pre.chars

###############################
put_linebreaks<-function(runs){
#runs<-11
for (k in runs){  
pos.s<-quid[[k]][["source_span"]]
pos.t<-quid[[k]][["target_span"]]
# pos.s$start
# pos.t$start
# pos.t$text
# pos.s$text
#library(quanteda)

#transcript_ed
# char.ed<-paste0(corpus.ed.chars[pos.t$start:pos.t$end],collapse = "")
# char.t<-paste0(corpus.pre.chars[pos.s$start:pos.s$end],collapse = "")
#corpus.ed.chars[1000:1500]
# char.pre<-pos.t$text
# char.ed<-pos.s$text
#char.ed<-gsub("\n"," ",char.t)
# blödsinn

#char.t
# char.ed<-corpus.ed.chars[pos.s$start:pos.s$end]
# char.pre<-corpus.pre.chars[pos.t$start:pos.t$end]
# char.ed
# char.pre
# get the linebreaks from pre to ed
char.ed<-pos.s$text
char.pre<-pos.t$text
char.ed<-unlist(strsplit(char.ed,""))
#char.ed
char.pre<-unlist(strsplit(char.pre,""))
pos.cr.pre<-grep("\n",char.pre)
pos.cr.pre
pos.cr.pre<-c(50,60)
#pos.cr.pre<-pos.cr.pre-1
pos.cr.pre
sub<-c(-1:length(pos.cr.pre))
sub<-sub[1:(length(sub)-length(pos.cr.pre))]
sub
pos.cr.pre.f<-pos.cr.pre+sub
pos.cr.pre.f
# check for niqqud on position:
print(char.ed.cr[pos.cr.pre.f])
m<-grep("\\p{M}",char.ed.cr,perl = T)
#pos.cr.pre
char.ed.cr<-char.ed
c<-2
for(c in pos.cr.pre.f){
  # go to next whitespace in place
  
  range<-char.ed.cr[c]
if(c%in%m) # if position is a niqqud
  c<-c+2

char.ed.cr<-append(char.ed.cr,"\n",after = c)
}
print(char.ed.cr)
cat("pre\n")
cat(paste0(char.pre,collapse = ""))

cat("edited\n")
cat(paste0(char.ed,collapse = ""))

cat("restored\n")
cat(paste0(char.ed.cr,collapse = ""))

#wks.

  trans.char.res<-paste0(char.ed.cr,collapse = "")
  trans.char.pre<-paste0(corpus.pre.chars[pos.t$start:pos.t$end],collapse = "")
  # corpus.cr.res<-corpus.pre.chars
  corpus.cr.res[pos.t$start:pos.t$end]<-char.ed.cr
 # corpus.cr.res[pos.t$start:pos.t$end]
  #trans.char.pre<-corpus.ed.chars[pos.t$start:pos.t$end]
  #corpus.pre.chars[pos.t$start:pos.t$end]
#print(  char.ed.cr)
#cat(trans.char.pre) # original 
#cat(trans.char.res)
corpus.compact<-paste0(corpus.cr.res,collapse = "")
#cat(corpus.compact)
}
#print(  corpus.pre.chars[pos.t$start:pos.t$end])
  #trans.char.pre<-paste0(corpus.pre.chars[pos.s$start:pos.s$end],collapse = "")
  
return(corpus.compact)  
}
corpus.compact<-put_linebreaks(1:length(quid))
corpus.compact<-put_linebreaks(6)
cat(corpus.compact)
# wks, but niqqud appear as single token, 
# so linebreaks in that envrironment should not be allowd
#corpus.compact<-paste0(corpus.restored,collapse = "")
writeLines(corpus.compact,"testcorpus.res.txt")

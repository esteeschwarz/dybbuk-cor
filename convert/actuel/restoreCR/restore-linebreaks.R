#20240818(11.32)
#14342.linebreaks restore essai
###############################
# Q: https://scm.cms.hu-berlin.de/schluesselstellen/quid
# pip install Quid
# $ quid compare sourcetext targettext
###############################
library(jsonlite)
#quid<-read_json("quid_result-6.json")
quidsrc<-"quidcli-001.json"
quid<-readLines(quidsrc)
quidmod<-"quid_result-8.json"
writeLines(quid[2:length(quid)],quidmod)
quid<-read_json(quidmod)
#quid<-read_json("quidcli-001.json")
# looks good
library(readtext)
transcript_ed<-readtext("yudale_edit_01-06.txt")$text
transcript_pre<-readtext("yudale_pre_01-06.txt")$text
corpus.ed.chars<-unlist(strsplit(transcript_ed,""))
corpus.pre.chars<-unlist(strsplit(transcript_pre,""))
corpus.cr.res<-corpus.pre.chars
#runs<-1
k<-22
k
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
cat("pre\n")
print(char.pre)
cat("edit\n")
print(char.ed)
pos.cr.pre<-grep("\n",char.pre)
pos.cr.pre
precr<-char.pre[pos.cr.pre]
edcr<-char.ed[pos.cr.pre]
pos.cr.syn<-precr==edcr
if(length(which(pos.cr.syn))>0)
  pos.cr.pre<-pos.cr.pre[!pos.cr.syn]
pos.cr.pre
#pos.cr.pre<-c(50,60)
#pos.cr.pre<-pos.cr.pre-1
#pos.cr.pre
#sub<-c(-1:length(pos.cr.pre))
subf<--0
x<-length(pos.cr.pre)-subf
x
sub<-c(subf:x)
x<-length(sub)-length(pos.cr.pre)
sub
length(pos.cr.pre)
sub
length(sub)
# x<-sub[1]+length(pos.cr.pre)
# x
# sub.1<-c(sub[1]:x)
# sub.1
sub.l<-length(sub)
pos.cr.pre.f<-pos.cr.pre[1:sub.l]+sub
pos.cr.pre.f<-pos.cr.pre.f[!is.na(pos.cr.pre.f)]
pos.cr.pre.f
# check for niqqud on position:
#print(char.ed.cr[pos.cr.pre.f])
print(char.ed[pos.cr.pre.f])
char.ed.cr<-char.ed
print(char.ed.cr)
print(char.pre)
#print(char.ed.cr[pos.cr.pre.f])
m<-grep("\\p{M}",char.ed.cr,perl = T)
print(char.ed[m])
#pos.cr.pre
c<-1
c
space<-0
insert.cr<-function(){
for(c in 1:length(pos.cr.pre.f)){
  # go to next whitespace in place
range<-char.ed.cr[c]
n<-pos.cr.pre.f[c]  
if(n%in%m) # if position is a niqqud
  c<-c+2
n<-pos.cr.pre.f[c]  
n
sp<-char.ed.cr[n]
sp
length(sp)
move.array<-c(" ","@","\n")
whiteplus<-function(sp,n){
  while (sp!=" "&!is.na(sp!=" ")&sp!="@"&sum(n)>0){
    n<-n-1
    sp<-char.ed.cr[n]
    sp
  }
  return(n)
}
if(!is.na(sp)&sum(n)>0)
  n<-whiteplus(sp,n)
n
pos.x<-space+n
#char.ed.cr<-append(char.ed.cr,"\n",after = pos.x)
char.ed.cr[pos.x]<-"\n"
#space<-space-1
}
c
return(char.ed.cr)
}
if (length(pos.cr.pre.f)>0)
char.ed.cr<-insert.cr()

print(char.ed.cr)
cat("pre\n")
cat(paste0(char.pre,collapse = ""))

cat("edited\n")
cat(paste0(char.ed,collapse = ""))

cat("restored",k,"\n")
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
cat ("finished run",k,"\n")
}
#print(  corpus.pre.chars[pos.t$start:pos.t$end])
  #trans.char.pre<-paste0(corpus.pre.chars[pos.s$start:pos.s$end],collapse = "")
  
return(corpus.compact)  
}
corpus.compact<-put_linebreaks(1:length(quid))
#corpus.compact<-put_linebreaks(6)
#cat(corpus.compact)
# wks, but niqqud appear as single token, 
# so linebreaks in that envrironment should not be allowd
#corpus.compact<-paste0(corpus.restored,collapse = "")
writeLines(corpus.compact,"testcorpus.res.txt")

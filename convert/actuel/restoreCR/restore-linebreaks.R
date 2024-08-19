#20240818(11.32)
#14342.linebreaks restore essai
###############################
# Q: https://scm.cms.hu-berlin.de/schluesselstellen/quid
# pip install Quid
# $ quid compare sourcetext targettext
###############################
# perform quid compare
txt.src<-"yudale_edit_01-06.txt"
txt.target<-"yudale_pre_01-06.txt"
quidsrc<-"quidcli-001.json"
# only run on changes
runquid<-F
########################
run.quid<-function(run){
  quidstatic<-"quid_result-8.json"
  
if(run){
  quidtemp<-tempfile("quidwrite.json")
  quidwrite<-system(paste0("quid compare ",txt.src," ",txt.target),intern = T)
library(jsonlite)
#quid<-read_json("quid_result-6.json")
#quid<-readLines(quidsrc)
writeLines(quidwrite[2:length(quidwrite)],quidtemp)
writeLines(quidwrite[2:length(quidwrite)],quidstatic)
quid<-read_json(quidtemp)
}
if(!run)
  quid<-read_json(quidstatic)

return(quid)
}
quid<-run.quid(runquid)
#######################
#quid<-read_json("quidcli-001.json")
# looks good
library(readtext)
transcript_ed<-readtext(txt.src)$text
transcript_pre<-readtext(txt.target)$text
corpus.ed.chars<-unlist(strsplit(transcript_ed,""))
corpus.pre.chars<-unlist(strsplit(transcript_pre,""))
corpus.cr.res<-corpus.pre.chars
#runs<-1
k<-1
k
###############################
put_linebreaks<-function(runs){
#runs<-1
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
############
# other method with replacing instead inserting \n
pos.cr.pre.f<-pos.cr.pre
########################
# check for niqqud on position:
#print(char.ed.cr[pos.cr.pre.f])
print(char.ed[pos.cr.pre.f])
char.ed.cr<-char.ed
print(char.ed.cr)
print(char.pre)
#print(char.ed.cr[pos.cr.pre.f])
m<-grep("\\p{M}",char.ed.cr,perl = T)
niqqud.array<-char.ed[m]
print(char.ed[m])
#pos.cr.pre
c<-2
c
space<-0
######################
insert.cr<-function(char.ed.cr){
for(c in 1:length(pos.cr.pre.f)){
  # go to next whitespace in place
range<-char.ed.cr[c]
c
n<-pos.cr.pre.f[c]
n
# if(n%in%m) # if position is a niqqud
#   c<-c+2
c
pos.cr.pre.f[2]
n<-pos.cr.pre.f[c]  
n
sp<-char.ed.cr[n]
sp
r<-1
length(sp)
move.array<-c(" ","\n","/")
!sp%in%move.array&!is.na(sp!=" ")&r<4
!sp%in%move.array&r<4
r
sp==" "
!sp%in%move.array&r<5|sp%in%niqqud.array
!sp%in%niqqud.array
#sp<-" "
n
f<-look.f<-c(n:(n+8))
b<-look.b<-c(n:(n-7))
equal<-b
#equal<-f
forward<-function(n,f=look.f){
  #m<-match(sp,move.array)
  m.p.f<-match(move.array,char.ed.cr[look.f])
  print(return(m.p.f))
}
backward<-function(n,b=look.b){
#  m<-match(sp,move.array)
 # is.na(m)
  m.p.b<-match(move.array,char.ed.cr[look.b])
  print(return(m.p.b))
  
}
backward(n)
forward(n)

get.position<-function(n,f,b){
m.s.f<-sum(forward(n),na.rm = T)
m.s.b<-sum(backward(n),na.rm = T)
if(m.s.b==m.s.f)
  return(b[m.s.b])
ifelse(m.s.f<m.s.b,return(f[m.s.f]),return(b[m.s.b]))
}
n
pos.x<-get.position(n,look.f,look.b)

whiteplus<-function(sp,n){
  while (!sp%in%move.array&r<5|sp%in%niqqud.array){
  n
      r<-r+1
    n
    n<-n-1
    sp<-char.ed.cr[n]
    n
    sp
    r
    if(r>4){
     # n<-c+n
      cat("forward n+1\n")
      sp<-char.ed.cr[n]
      
    }
  }
  !sp%in%move.array&!is.na(sp!=" ")|sp%in%niqqud.array
    while (!sp%in%move.array&!is.na(sp!=" ")|sp%in%niqqud.array){      
      n<-n+1
      n
      sp<-char.ed.cr[n]
      sp
    }
   # }
    print(n)
    print(sp)
      
 # }
  return(n)
}
#cat("run:", run)
# if(!is.na(sp)&sum(n)>0)
#   n<-whiteplus(sp,n)
# n
# pos.x<-space+n
# pos.x
#char.ed.cr<-append(char.ed.cr,"\n",after = pos.x)
#char.ed.cr[pos.x]<-"\n"
#space<-space-1
#}
c
# if (length(pos.cr.pre.f)>0)
char.ed.cr[pos.x]<-"\n"
n
} #pos.cr.pre loop
  return(char.ed.cr)
  
} # insert.cr fun()
if (length(pos.cr.pre.f)>0){
  char.ed.cr<-insert.cr(char.ed.cr)
  print(k)
  cat("linebreaks",k,"inserted\n")
}
#n
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
#corpus.compact<-put_linebreaks(1)
cat(corpus.compact)
# wks, but niqqud appear as single token, 
# so linebreaks in that envrironment should not be allowd
#corpus.compact<-paste0(corpus.restored,collapse = "")
writeLines(corpus.compact,"testcorpus.res.txt")

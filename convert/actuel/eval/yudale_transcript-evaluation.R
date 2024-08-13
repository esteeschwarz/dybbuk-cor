#20240813(19.18)
#14334.transcript evaluation
#####################
# creates transcript token df with frequencies and most used spelling alternative
# (of to date checked pages)
########################################################################
mini<-"/Volumes/EXT"
lapsi<-"/Users/guhl/Documents"
fns.base.1<-"/boxHKW/21S/DH/local/EXC2020/dybbuk/"
minichk<-list.files(mini)
#fns.base<-paste0(lapsi,fns.base)
#fns<-"/boxHKW/21S/DH/local/EXC2020/dybbuk/Yudale_der_blinder,_Emkroyt1908-xp001/Yudale_der_blinder,_Emkroyt1908-xp001/page/"
if(length(minichk)>0)
  fns.base.2<-paste0(mini,fns.base.1)
if(length(minichk)<1)
  fns.base.2<-paste0("~/Documents/GitHub/dybbuk-cor/convert/actuel/TEI")
fns.base.2
fns.file<-"yudale_ezd_pre_semicor_003.txt"
fns.file<-paste(fns.base.2,fns.file,sep = "/")
text<-readLines(fns.file)
m<-grep("STOP",text)
#preproc.fun<-function(pages.cor){ # not called function to get token list of half corrected transcription
  #library(xml2)
  library(collostructions)
  library(quanteda)
  library(purrr)
  tlist<-list()
m.gold<-1:m
m.train<-m:length(text)
### tokenize
  tokens.gold<-tokenize_word1(text[m.gold])
  tokens.train<-tokenize_word1(text[m.train])
## with lines information
  tok.df.gold<-cbind(tokens.gold)
  install.packages("abind")
  library(abind)
  t1<-abind(tok.df.gold[[26]][1],"f1")
  t1
  tok.freq.gold<-freq.list(unlist(tokens.gold))
tok.freq.gold
tok.sort.gold<-tok.freq[order(tok.freq.gold$WORD),]
tok.sort.gold
### get duplicates w/o niqqud
tok.sort.gold$sansniqqud<-gsub("\\p{M}", "", tok.sort.gold$WORD, perl = TRUE)
tok.sort.gold$duplicated<-duplicated(tok.sort.gold$sansniqqud)
sum(m.dup) # still 365 duplicates i.e. alternative spelling
tok.sort.gold.dup<-tok.sort.gold[order(tok.sort.gold$duplicated,decreasing = T),]
tok.sort.gold.dup.sans<-tok.sort.gold[order(tok.sort.gold$sansniqqud,decreasing = F),]
### get max truth
m<-grepl("[^א-ת]",tok.u)
m<-tok.sort.gold.dup.sans$sansniqqud=="א"
m<-which(m)
aleph<-m[1]
tok.sort.gold.dup.sans$sansniqqud[1:m[1]-1]
tok.u<-unique(tok.sort.gold.dup.sans$sansniqqud[aleph:length(tok.sort.gold.dup.sans$sansniqqud)])
#tok.u<-tok.u[!m]
sum(tok.u=="")
sum(is.na(tok.u))
tok.u<-tok.u[!is.na(tok.u)]
k<-1
tok.sort.gold.dup.sans$max.tok[m]<-NA
tok.sort.gold.dup.sans$which.max.tok<-NA
tok.sort.gold.dup.sans$tok.most<-NA

for (k in 1:length(tok.u)){
  m<-tok.sort.gold.dup.sans$sansniqqud%in%tok.u[k]
  m.w<-which(m)
  tok.sort.gold.dup.sans$sansniqqud[m]
  tok.max<-max(tok.sort.gold.dup.sans$FREQ[m])
  tok.which.max1<-which.max(tok.sort.gold.dup.sans$FREQ[m])
  tok.which.max2<-m.w[tok.which.max1]
  tok.sort.gold.dup.sans$max.tok[m]<-tok.max
  tok.sort.gold.dup.sans$which.max.tok[m]<-tok.which.max2
m.w  
  #tok.sort.gold.dup.sans$tok.most[m]<-tok.sort.gold.dup.sans$WORD[tok.sort.gold.dup.sans$which.max.tok[m]]
  #tok.sort.gold.dup.sans$tok.most[m.w]<-levels(tok.sort.gold.dup.sans$WORD)[tok.sort.gold.dup.sans$which.max.tok[m]]
  tok.sort.gold.dup.sans$tok.most[m.w]<-as.character(tok.sort.gold.dup.sans$WORD[[tok.which.max2]])
}
#levels(tok.sort.gold.dup.sans$WORD)[114]
#tok.sort.gold.dup.sans$WORD[[111]]
#write.csv(tok.sort.gold.dup.sans,"~/Documents/GitHub/dybbuk-cor/convert/actuel/eval/yudale_tok_freq.csv")
#save(tok.sort.gold.dup.sans,file = "~/Documents/GitHub/dybbuk-cor/convert/actuel/eval/yudale_tok_freq.RData")
#f1%>% xml_ns_strip()
#library(quanteda)
fun.dep<-function(){
chars<-char_segment(a2.cor,".",valuetype = "regex",remove_pattern = F)
chars[100:550]
ngrams.2<-char_ngrams(chars,2,concatenator = "")
#ngrams[1:100]
ngrams.2[1:100]
ng.t<-table(ngrams.2)
ng.t
write.csv(ng.t,"~/Documents/GitHub/ETCRA5_dd23/dybbuk/yudale_2grams.csv")
ngrams.3<-char_ngrams(chars,3,concatenator = "")
ng.t3<-table(ngrams.3)
ng.t
write.csv(ng.t3,"~/Documents/GitHub/ETCRA5_dd23/dybbuk/yudale_3grams.csv")
ngrams.4<-char_ngrams(chars,4,concatenator = "")
ng.t4<-table(ngrams.4)
write.csv(ng.t4,"~/Documents/GitHub/ETCRA5_dd23/dybbuk/yudale_4grams.csv")
m<-grepl("[א-ת]",chars)
sum(m)
chars[m]
###########################
j1<-stringdist_join(a1,a2,by="WORD",max_dist = 99,mode = "left",method = "jw",distance_col = "dist")
j3<-stringdist_join(a1,a2,by="WORD",max_dist = 1,method = "jw",distance_col = "dist")
j1[j1$dist>=1&j1$dist<=2,]
m<-j1$dist<0.8&j1$dist>0.74
j2<-j1[m,]

m<-j3$dist<0.8&j3$dist>0.7
j4<-j3[m,]
library(stringdist)
t1<-"ביז"
#tok.sort[m,] 
t2<-"בִּיז"
t1<-"arbeit"
t2<-"erbeit"
stringsim(t1,t2,method = "lv",p=0.1)
tok.ed$tok.2<-NA
tok.ed$tok.2[1:length(tok.sort$WORD)]<-levels(tok.sort$WORD)
}

#14313.yudale.TEI.refactoring
#20240729(19.51)
################
# base convert .txt to eazydrama markup for further TEI conversion
##################################################################
# Q:

### set T if new ezd parsing from actualised .txt source
library(tools)
###
run.ezdrama=T
### else F will use the latest first stage .xml output of ezdrama for further
### xml adaptations
###################
### for device dependent routine if apply ezd (above = T), T on lapsi
run.python.prepare=T
tapee<-F
### run with all sources from git
run.src.git = F
#check.local()
### chose .txt file explicitly, comment in/out for configuration
### set in L168, check.src()
path.chose<-function(file,local=TRUE){
ifelse(local,
  path.dir<-"~/Documents/GitHub/dybbuk-cor/convert/actuel/TEI",
path.dir<-"https://raw.githubusercontent/esteeschwarz/dybbuk-cor/main/convert/actuel/TEI")
chose.file<-file
#chose.file<-"yudale_ezd_pre_semicor_003.txt" # last used working version
#chose.file<-"yudale_ezd_pre_semicor_003STfwd.txt" # forward edited version 
### > chose finalised .xml output file at script bottom
path.chose.file<-paste(path.dir,chose.file,sep = "/")
path.chose.file
if (chose.file!="")
  chose.file<-path.chose.file
return(chose.file)
}
# not run
temp.dep<-function(){
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
#text.1[m.sp]<-paste0(text.1[m.sp],"@")
text.1[m.sp]<-paste0("@",text.1[m.sp])
text.1[m.sp[1:10]]
text.2<-text.1
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
text.1[56]<-paste0("#",text.1[56])
text.1[actm]
text.1[577]<-paste0("#",text.1[577])

#dramatis_personae
cast<-37
text.1[37]<-paste0("^",text.1[37])

#interpunktion to the end of sentence
m<-grep("(^[?!.-])",text.1)
text.1[43]
text.2[43]
  gsub("(^[?!.-])(.*)","\\2\\1",text.2[43])

#remove speaker niqqud
text.cor<-readLines("~/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_ezd_pre_semikorrigiert.txt")
m<-grep("@.+:",text.cor)
text.cor[m]
text.cor[m]<-gsub("(\\p{M})","",text.cor[m],perl = T)  

# remove linebreaks
text.cor<-readLines("~/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_ezd_pre_semicor_002.txt")
reg1<-"((?<!:)\n)([^)(@#$])"
reg2<-"^(" #whole stage line
m<-grep(reg1,text.cor)
text.cor.tx<-readtext::readtext("~/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_ezd_pre_semicor_002.txt")$text
text.cor.tx.2<-gsub(reg1," \\1",text.cor.tx,perl = T)
# #pagebreaks
# m<-grep("[0-9]{1,2}",text.1)
# length(m)
#no. first correct in transcription source
###
writeLines(text.1,"~/boxHKW/21S/DH/local/EXC2020/dybbuk/TEI/yudale_ezd_pre.txt")

writeLines(text.cor.tx.2,"~/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_ezd_pre_semicor_002.txt")

text.cor.3<-readLines("~/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_ezd_pre_semicor_002.txt")
text.cor.3[359]
} #end legacy function
######################
prepare.python<-function(run=F){
  if (run){
  library(reticulate)
 #use_virtualenv("r-miniconda")
# use_python_version()
 #py_eval("1+1")
#py_list_packages()
#py_install("transliterate")
# py_discover_config()
 #py_config()
 use_miniconda("/Users/guhl/Library/r-miniconda/bin/python") # on lapsi!
 # use_python_version("3.10")
# install_python(version = '3.10')
# edited in textfile manually
#virtualenv_list()
#virtualenv_remove("r-reticulate")
#virtualenv_create(version = "3.10")
#install_python(version = '3.10')
  }
  return(run)
}
### for device dependent routine
#run.python.prepare=T
check.local<-function(){
if (!run.src.git)
  if(file.exists("~/checkdevice.R"))
    source("~/checkdevice.R")
    return(run.python.prepare)
return(run.ezdrama)
}
check.local()
check.python<-prepare.python(check.local())
check.python
#############################
check.src<-function(what){
  
  ezd_markup_text<-"/Users/guhl/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_ezd_pre_semicor_003.txt"
  # ezd_markup_text.sf<-"/Users/guhl/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/CopyOfyudale_ezd_pre_semicor_003.txt"
  ezd_markup_text.git<-"https://raw.githubusercontent.com/esteeschwarz/dybbuk-cor/main/convert/actuel/TEI/yudale_ezd_pre_semicor_003.txt"
  #ifelse(check.python,return(ezd_markup_text),ezd_markup_text.git)
  #chose.file<-"yudale_ezd_pre_semicor_003.txt" # last used working version
  #chose.file<-"yudale_ezd_pre_semicor_003STfwd.txt" # forward edited version 
  ezd_markup_text<-file_path_sans_ext(ezd_markup_text)
  ifelse(what=="xml",ezd_markup_text <- paste0(ezd_markup_text,".xml"),
         ezd_markup_text <- paste0(ezd_markup_text,".txt"))
  if(check.python)
    return(path.chose("yudale_ezd_pre_semicor_003.txt",local = T))
  return(ezd_markup_text)
  
}
# single line stage direction markup:
ezd_markup_text<-check.src(what = "xml")
ezd_markup_text
qfile<-ezd_markup_text
process.ezd<-function(check.python,ezd_markup_text){
check.local()
# check.src<-function(check.local){
# 
#   ezd_markup_text<-"/Users/guhl/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_ezd_pre_semicor_003.txt"
#  # ezd_markup_text.sf<-"/Users/guhl/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/CopyOfyudale_ezd_pre_semicor_003.txt"
#   ezd_markup_text.git<-"https://raw.githubusercontent.com/esteeschwarz/dybbuk-cor/main/convert/actuel/TEI/yudale_ezd_pre_semicor_003.txt"
#   #ifelse(check.python,return(ezd_markup_text),ezd_markup_text.git)
#   if(check.python)
#     return(path.chose())
# }
# # single line stage direction markup:
 ezd_markup_text<-check.src("txt")
#  ezd_markup_text<- paste0(ezd_markup_text,".txt")
  
### depr., we will do this in xml  
fun.depr.2<-function(){
  text.m<-readLines(ezd_markup_text)
#text.m<-readLines(check.src())
#text.m<-readLines(ezd_markup_text.sf)
m<-grepl("^[(][^)(]{1,150}[)]{1}\\.$",text.m) #grep all single line stage directions

# TODO: check transcript for . at the end of each stage line!!!
m3<-grepl("^[(][^)(]{1,150}[)]\\.?$",text.m) #grep all single line stage directions

sum(m)
sum(m3) # +7 lines!!!
head(text.m[m])
m<-m3
text.m[m3]
text.m[m]<-paste0("$",text.m[m])
text.m[m]<-gsub("[)(]","",text.m[m])

# pagebreak
text.m.pb<-gsub(":?([0-9]{1,2}):?",'<!--<pb n="\\1"/>-->',text.m)
text.m.pb[1:50]
######################################
# MIND: not activate, will overwrite markup text! only if changes applied in script.
#writeLines(text.m.pb,ezd_markup_text)
#wks.
}
###################################

### convert with local ezdrama parser:
#ezd_markup_text<-"/Users/guhl/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_ezd_pre_semicor_003.txt"
run_on_tape<-function(){
  
  source_python("~/Documents/GitHub/dybbuk-cor/convert/actuel/parser.local.src.py")
}
check.python
 #library(reticulate)
#ezd_markup_text.ext<- paste0(ezd_markup_text,".txt")
if(run.ezdrama&check.python){
  if(tapee)
    run_on_tape()
  system(paste0("python3 /Users/guhl/Documents/GitHub/dybbuk-cor/convert/actuel/parser.local.py ",ezd_markup_text))
  print("finished python ezd")
}
} #end ezd process .txt
# 2nd way:
# library(reticulate)
# source_python()
xml.cor.1<-function(){
  library(xml2)
  library(purrr)
  library(tools)
 
  # file.ns.ex<-file_ext(ezd_markup_text)
  file.base<-file_path_sans_ext(ezd_markup_text)
  file.xml<-paste0(file.base,".xml")
  file.xml
#  xml.src.local<-"~/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_ezd_pre_semicor_003.xml"
  xml.src.local<-file.xml
    xml.src.git<-"https://raw.githubusercontent.com/esteeschwarz/dybbuk-cor/main/convert/actuel/TEI/yudale_ezd_pre_semicor_003.xml"
xml.src<-ifelse(run.src.git,xml.src.git,xml.src.local)
xmltop<-read_xml(xml.src)

  # xmltop<-read_xml("~/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_ezd_pre_semicor_003.xml")
  
speaker.who.cor<-data.frame(neg=c("fishl","freydede","freydle","freyde","rze"),pos=c("fishel","freydele","freydele","freydele","rz"))
speaker.who.cor$neg<-paste0("#",speaker.who.cor$neg)
speaker.who.cor$pos<-paste0("#",speaker.who.cor$pos)
xmlt2<-xmltop%>%xml_ns_strip()
tei<-xml_find_all(xmlt2,"//TEI")
allsp<-xml_find_all(tei,"//sp")
sp.who<-xml_attr(allsp,"who")
#sp.who<-paste0(sp.who)
sp.who.u<-unique(sp.who)       
m<-sp.who%in%speaker.who.cor$neg
#sum(sp.who.neg)
sp.who.all<-data.frame(sp=sp.who,cor=sp.who)
for (k in 1:length(sp.who.all$sp)){
  sp<-sp.who.all$sp[k]
  m2<-sp==speaker.who.cor$neg
  sp.cor<-speaker.who.cor$pos[m2]
  if(sum(m2)>0)
    sp.who.all$cor[k]<-sp.cor
  
}
xml_set_attr(allsp,"who",sp.who.all$cor)
head(xml_text(allsp))

sp.who.t<-xml_attr(allsp,"who")
#unique(sp.who.t)
# wks.

# <edit>markup restore
# &lt;edit&gt;digit6.30&lt;/edit&gt
m<-grepl(".{4}(/?edit).{4}",xml_text(allsp))
sum(m)
#gsub("<(/?edit).{4}","p\\1p",xml_text(allsp[m]))
# R doesnt find, has converted yet into <> 

# xmltarget<-"~/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_003_normalised_01.xml"
# remove : in speaker
allspk<-xml_find_all(allsp,"speaker")
allspk.m<-gsub("[:]","",xml_text(allspk))
xml_text(allspk)<-allspk.m
# wks.
# remove () in stage
allstage<-xml_find_all(tei,"//stage")
allstage.m<-gsub("[)(]","",xml_text(allstage))
xml_text(allstage)<-allstage.m
#wks.
return(tei)
} #end xml.cor.1
# if(run.ezdrama)
  # process.ezd() # performs ezd transformation and writes to file
#tei<-xml.cor.1() # reads from created .xml to finalize xml # run for test castediting
##############################
# castlist speaker role:
xml.cor.2<-function(){
castlist<-xml_find_all(tei,"//castItem")
cast.txt<-xml_text(castlist)
cast.txt
m.desc<-grep("-",cast.txt)
library(stringi)
#library(purrr)
role<-stri_split_regex(cast.txt," - ",simplify = T)
role
#role.markup<-stri_extract_all_regex(rol)
role.2<-stri_split_regex(role[,1],"\\+!",simplify = T)
role.2
role.markup<-gsub("!\\+","",role.2[,2])
role.markup
markup.array<-c(group="cg",rend="braced",corresp="list")
markup.array
markup.what<-list()
mk<-markup.array[1]
for (mk in markup.array){
m.1<-grep(mk,role.markup)
m.1
markup.what[[mk]]<-m.1
}
length(markup.what)
markup.what
role.3<-cbind(role.2[,1],role[,2],gsub("[^0-9]","",role.2[,2]),0,NA,NA)
role.3[markup.what[[1]],5]<-names(markup.what)[1]
role.3[markup.what[[2]],5]<-names(markup.what)[2]
role.3[markup.what[[3]],5]<-names(markup.what)[3]
role.3[markup.what[[1]],6]<-names(markup.array)[1]
role.3[markup.what[[2]],6]<-names(markup.array)[2]
role.3[markup.what[[3]],6]<-names(markup.array)[3]
###
m4<-role[,2]!=""
m5.1<-role.3[,3]!=""&role.3[,2]!=""
m5.2<-role.3[,3]!=""&role.3[,2]==""
k<-2
m6.1<-role.3[,1:3]==""
m6.2<-grep(".*",role.3[m6.1])
m6.2<-grepl("\n",role.3[,1])
#role.3[m6.2,1]
role.3<-role.3[!m6.2,]
role.3
castlist
xml_remove(castlist[[which(m6.2)]]) # removes empty entry in castlist

castlist.elm<-xml_find_all(tei,"//castList")
castlist.elm
castlist<-xml_find_all(tei,"//castItem") # refresh after deleting!
castlist
xml_text(castlist)

##############
get.casttype.list<-function(){
  m<-grep("list",role.3[,5])
  cg.group<-role.3[m,1]
#  cg.single<-stri_split_regex(cg.group,",",simplify = T)
 # cg.single<-gsub("^ ","",cg.single)
  #cg.single<-paste(cg.single)
}

##############
group.list.dep<-function(){
get.cg.ingroup<-function(x)grepl(",",xml_text(x))
cg.sep<-lapply(castlist, get.cg.ingroup)
cg.sep.u<-unlist(cg.sep)
cg.group<-xml_text(castlist[cg.sep.u])
cg.single<-stri_split_regex(cg.group,",",simplify = T)
cg.single<-gsub("^ ","",cg.single)
cg.single
role.3[cg.sep.u,1]
df<-cbind(t(cg.single),role.3[cg.sep.u,2],role.3[cg.sep.u,3],role.3[cg.sep.u,4])
role.3.2<-rbind(role.3[!cg.sep.u,],df)
role.3.2[,1]<-gsub("[+0-9cg!.]","",role.3.2[,1])
role.3<-role.3.2
for (k in 1:length(role.3[,2])){
  cg<-role.3[k,3]
  if (role.3[k,2]==""&role.3[k,3]!=""){
    m5.3<-role.3[,3]==cg&role.3[,2]!=""
    if(sum(m5.3)>0)
      role.3[k,2]<-role.3[m5.3,2]
  }
}
}
role.3[is.na(role.3)]<-""
for (k in 1:length(role.3[,2])){
  cg<-role.3[k,3]
  if (role.3[k,2]==""&role.3[k,3]!=""){
    m5.3<-role.3[,3]==cg&role.3[,2]!=""
    if(sum(m5.3)>0)
      role.3[k,2]<-role.3[m5.3,2]
  }
}

return(role.3)
} #end xml.cor.2
###################
#process.ezd() # performs ezd transformation and writes to file
if(run.ezdrama)
  process.ezd(check.python,F) # performs ezd transformation and writes to file
#############
tei<-xml.cor.1() # reads from created .xml to finalize xml
################
# castgroup editing
role.3<-xml.cor.2() # gets castlist df template for castgroup/role editing
###################
castlist<-xml_find_all(tei,"//castItem")
castlist.elm<-xml_find_all(tei,"//castList")

########################################
k<-2
castlist
done<-expression(role.3[k,4]==1)
#eval(done)
done.set<-expression(role.3[k,4]<-1)

####### WAIT
for (k in 1:length(castlist)){
  sp.role<-role.3[k,1]
  sp.desc<-role.3[k,2]
  sp.cg<-role.3[k,3]
  sp.id<-role.3[k,6]
  sp.id.value<-role.3[k,5]
  m.cg<-role.3[,3]==sp.cg
  m.cg.w<-which(m.cg)
  castlist
  eval(done)
  sp.cg!=""&!eval(done)
  if (sp.cg!=""&sp.id.value!="list"&!eval(done)){
  # instead create new node
   # cg.node<-list()
    cg.node<-xml_new_root("castGroup")
    if (!is.na(sp.id))
      xml_set_attr(cg.node,sp.id,sp.id.value)
    k
    for (r in 1:length(m.cg.w)) {
    xml_add_child(cg.node,"castItem")
    xml_add_child(xml_child(cg.node,r),"role",role.3[m.cg.w[r],1])
    }
    xml_child(cg.node,1)
      eval(done.set)
    xml_add_child(cg.node,"roleDesc",sp.desc)
    xml_replace(castlist[[k]],cg.node)
    m<-role.3[,3]==sp.cg
    role.3[m,4]<-1 # done set 1
  }
  k
  if (sp.id.value=="list"){
    xml_set_attr(castlist[k],sp.id,sp.id.value)
    xml_set_text(castlist[k],sp.role)
    eval(done.set)
  }
    
  if (sp.desc!=""&sp.cg==""&!eval(done)){
    xml_set_text(castlist[k],"")
    xml_add_child(castlist[k],"role",sp.role)
    xml_add_child(castlist[k],"roleDesc",sp.desc)
    role.3[k,4]<-1
    eval(done.set)
  }
  print(k)
 }
# remove obsolete nodes in castlist
sp.cg<-unique(role.3[,3])
sp.cg<-as.double(sp.cg)
sp.cg<-sp.cg[!is.na(sp.cg)]
sp.cg
m1<-role.3[,3]%in%sp.cg
m<-which(m)
castnew<-xml_find_all(tei,"//castList")
for (cg in sp.cg){
m2<-match(cg,role.3[,3])  
m1[m2]<-F
m1
}
nodes.to.remove<-which(m1)
  nodes.to.remove<-nodes.to.remove[nodes.to.remove<length(castlist)]
  nodes.to.remove<-nodes.to.remove[!is.na(nodes.to.remove)]
    xml_remove(
      castlist[nodes.to.remove],free = T
      )
    print(nodes.to.remove)
### wks.
########
### edit personlist sex
role.3[,1]
sex.array<-c("MALE","FEMALE","MALE","MALE","MALE","FEMALE","FEMALE","MALE","MALE","MALE","MALE","UNKNOWN")
role.3<-cbind(role.3[,1:length(role.3[1,])],sex.array)
tei.person<-xml_find_all(tei,"//person")
xml.att.id<-xml_attr(tei.person,"id")
xml.att.id
xml.att.sex<-xml_attr(tei.person,"sex")
xml.att.sex
person.id<-c("vldmn","rz","lteril","ydle","irkhm","ikhne","dbrh","freydele","bermn","isr","edelmn","khr")
role.3<-cbind(role.3[,1:length(role.3[1,])],person.id)
k<-2
for (k in 1:length(role.3[,8])){
  id<-role.3[k,8]
  sex<-role.3[k,7]
  m<-id==xml.att.id
  xml_set_attr(tei.person[m],"sex",sex)
}

### finalise TEI
# add tei/filedesc
# csv.meta<-read.csv(path.chose("yudale.desc.csv"),sep = ";")
# #csv.meta$text
# xml.filedesc<-read_xml(path.chose("sample.filedesc.xml"))
# desc.author<-xml_find_all(xml.filedesc,"//author")
# filedesc.ns<-tei%>%xml_ns_strip%>%xml_find_all("//fileDesc")
# title<-xml_find_all(filedesc.ns,"//title")
# #title<-xml_find_all(xml.filedesc,"//title")
# xml_add_sibling(title,"title")
# xml_set_attr(xml_child(xml_child(filedesc.ns),3),"type","sub")
# xml_set_attr(xml_child(xml_child(filedesc.ns),3),"xml:lang","eng")
# xml_set_text(xml_child(xml_child(filedesc.ns),3),
#              csv.meta$text[csv.meta$att1.value=="sub"&csv.meta$att2.value=="eng"])
# xml_text(xml_child(xml_child(filedesc.ns),3))
# xml_text(title)
# xml_add_sibling(title,"title","Volksstück in vier Akten")
# ### new with metadata .csv
# l.minus<-length(csv.meta$tag[csv.meta$tag=="title"])
# for(k in 1:4){
#   q1<-xml_find_all(csv.meta$tag[k])
#   
# }
xml.filedesc<-read_xml(path.chose("yudale.filedesc.xml"))
filedesc<-xml_find_all(tei,"//fileDesc")
xml_replace(filedesc,xml.filedesc)

### add standoff (wikidata/dracor id)
xml.standoff<-read_xml(path.chose("yudale.standoff.xml"))
standoff<-xml_find_all(tei,"//standOff")
xml_replace(standoff,xml.standoff)

### remove jonah notes on editing
allp<-xml_find_all(tei,"//p")
allp[10:20]
m<-grep("stop|STOP",allp)
allp[m]
m
#xml_text(allp[[m]])
if(length(m)>0)
  xml_remove(allp[[m]])
# THIS can only be run after all changes to TEI corpus have been applied,
# the nodeset is gone afterwards without ns_strip
# edit TEI header
xmltemp<-tempfile()

fin.tei.head<-function(tei){
    xml_set_attr(tei,"xmlns","http://www.tei-c.org/ns/1.0")
    xml_set_attr(tei,"xml:id","tochange")
    xml_set_attr(tei,"xml:lang","ger")
   # xml_set
    

write_xml(tei,xmltemp)
}
# wks. TODO reformat xmlformat.pl...
# next: remove () in <stage>CHK, remove : in <speaker>CHK, castlist role, single line stage directions CHK
# <edit>markup restore CHK 
##### >>> THIS HAS to be future done according the dracor editorial annotation scheme!!!!!!!
fin.tei.head(tei)
xmlt<-readLines(xmltemp)
#writeLines(xmlt,"xmltemp.xml")

# TODO: consistent markup > +!xxx!+
# editorial markup
# this method has to be changed, editorial annotation better in comment element in .txt
# m<-grepl("&lt;(/?edit)&gt;",xmlt)
#sum(m3)
m<-grep("\\+!.+!\\+",xmlt)
m2<-grep("edit",xmlt[m]) # for editorial notes
xmlt[m]
xmlt[m2]
xmlt[m][m2]
m<-m[m2]
xmlt[m]<-gsub("\\+!(.+)!\\+",'<note>\\1</note>',xmlt[m])
### the following is not validated
#xmlt[m]<-gsub("\\+!(.+)!\\+",'<note type="editorial" resp="#ST">\\1</note>',xmlt[m])
#xmlt[m]<-gsub("&lt;(/?edit)&gt;","<\\1>",xmlt[m])

### wks.
# pagebreaks restore
# the first two pb before <text> have to be commented in txt else they mess up,
# the suggested parser [9:] pattern doesnt work with this text to create pb elements
# also i didnt found any command in the parser to perform that action

regp0<-'<comment>&lt;pb n="([0-9]{1,2})"/&gt;</comment>'
#regpb<-'<comment>&lt;(pb n="[0-9]{1,2}"/)&gt;</comment>'
m1<-grepl(regp0,xmlt)
#m2<-grepl(regp2,xmlt)
sum(m1)
xmlt[m1]<-gsub(regp0,'<pb n="\\1"/>',xmlt[m1])
#xmlt[m2]<-gsub(regp2,'<pb n="\\1"/>',xmlt[m2])
regp1<-"([0-9]{1,2}):"
regp2<-":([0-9]{1,2})"
m1<-grepl(regp1,xmlt)
m2<-grepl(regp2,xmlt)
sum(m1)
xmlt[m1]<-gsub(regp1,'<pb n="\\1"/>',xmlt[m1])
xmlt[m2]<-gsub(regp2,'<pb n="\\1"/>',xmlt[m2])
reg.lt<-"&lt;"
reg.gt<-"&gt;"
m3<-grep(reg.lt,xmlt)
xmlt[m3]
xmlt[m3]<-gsub(reg.lt,"<",xmlt[m3])
m3<-grep(reg.gt,xmlt)
xmlt[m3]<-gsub(reg.gt,">",xmlt[m3])
### wks.
########
# add xml header
xmlhead<-readLines(path.chose("xml_dracor_header.xml", local = T))
xmlt.plus.header<-c(xmlhead,xmlt)
#writeLines(xmlt.plus.header,"testxml.xml")
#writeLines(xmlt,"testxml.xml")
### wks.

write.final.xml<-function(xmlsrc,xmltarget){
library(tools)
file.ns<-gsub(file_ext(xmltarget),"",xmltarget)
#indent<-""
file.base<-basename(xmltarget)
xmltarget.temp<-paste0("~/boxHKW/21S/DH/local/EXC2020/dybbuk/TEI/",file.base)
m<-grep("yidracor",xmltarget)
ifelse(length(m)==0,indent<-"indent.",indent<-"")
  writeLines(xmlsrc,xmltarget.temp)
print(xmltarget)
print(file_ext(xmltarget))
print(paste0("xmlformat ",xmltarget.temp," > ",paste0(file.ns,indent,file_ext(xmltarget))))
system(paste0("xmlformat ",xmltarget.temp," > ",paste0(file.ns,indent,file_ext(xmltarget))))
file.ns
cat("written",xmltarget,"\n")
# wks. ##########################################
}

# write.final.xml<-function(xmltarget){
#   writeLines(xmlt,xmltarget)
#   library(tools)
#   file.ns<-gsub(file_ext(xmltarget),"",xmltarget)
#   system(paste0("xmlformat ",xmltarget," > ",paste0(file.ns),"indent.",file_ext(xmltarget)))
#   # wks. ##########################################
# }
xmltarget.prod<-"~/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_003_normalised_01.xml"
xmltarget.dev<-"~/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_003_normalised_01.dev.xml"
xmltarget.dracor<-"~/Documents/GitHub/clones/yidracor/TEI/lateiner-yudale-der-blinder.xml"

writeLines(xmlt.plus.header,"~/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_003_normalised_01.temp.xml")
write.final.xml(xmlt.plus.header,xmltarget.dev)
#write.final.xml(xmlt.plus.header,xmltarget.prod)
write.final.xml(xmlt.plus.header,xmltarget.dracor)

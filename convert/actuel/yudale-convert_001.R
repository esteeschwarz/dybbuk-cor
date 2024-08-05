#14313.yudale.TEI.refactoring
#20240729(19.51)
################
# base convert .txt to eazydrama markup for further TEI conversion
##################################################################
# Q:
# not run
tempfun<-function(){
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
prepare.python<-function(run){
  if (run==T){
  library(reticulate)
 #use_virtualenv("r-miniconda")
# use_python_version()
 #py_eval("1+1")
#py_list_packages()
#py_install("transliterate")
# py_discover_config()
 #py_config()
 use_miniconda("/Users/guhl/Library/r-miniconda/bin/python")
 # use_python_version("3.10")
# install_python(version = '3.10')
# edited in textfile manually
#virtualenv_list()
#virtualenv_remove("r-reticulate")
#virtualenv_create(version = "3.10")
#install_python(version = '3.10')
  }
}
### for device dependent routine
run.python.prepare=T
if(file.exists("~/checkdevice.R"))
  source("~/checkdevice.R")
prepare.python(run.python.prepare)
#############################
process.ezd<-function(){
ezd_markup_text<-"/Users/guhl/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_ezd_pre_semicor_003.txt"
ezd_markup_text.sf<-"/Users/guhl/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/CopyOfyudale_ezd_pre_semicor_003.txt"

# single line stage direction markup:
text.m<-readLines(ezd_markup_text)
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
###################################

### convert with local ezdrama parser:
#ezd_markup_text<-"/Users/guhl/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_ezd_pre_semicor_003.txt"


 library(reticulate)

system(paste0("python3 /Users/guhl/Documents/GitHub/dybbuk-cor/convert/actuel/parser.local.py ",ezd_markup_text))
print("finished python ezd")
} #end process .txt
# 2nd way:
# library(reticulate)
# source_python()
xml.cor.1<-function(){
  library(xml2)
  library(purrr)
  
  xmltop<-read_xml("~/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_ezd_pre_semicor_003.xml")
  
speaker.who.cor<-data.frame(neg=c("fishl","freydede","freydle","freyde","rz"),pos=c("fishel","freydele","freydele","freydele","rze"))
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
process.ezd() # performs ezd transformation and writes to file
tei<-xml.cor.1() # reads from created .xml to finalize xml
##############################
# castlist speaker role:
xml.cor.2<-function(){
castlist<-xml_find_all(tei,"//castItem")
cast.txt<-xml_text(castlist)
m.desc<-grep("-",cast.txt)
library(stringi)
#library(purrr)
role<-stri_split_regex(cast.txt," - ",simplify = T)
role.2<-stri_split_regex(role[,1],"\\+!",simplify = T)
role.3<-cbind(role.2[,1],role[,2],gsub("[^0-9]","",role.2[,2]),0)
###
m4<-role[,2]!=""
m5.1<-role.3[,3]!=""&role.3[,2]!=""
m5.2<-role.3[,3]!=""&role.3[,2]==""
k<-2
m6.1<-role.3[,1:3]==""
m6.2<-grep(".*",role.3[m6.1])
m6.2<-grepl("\n",role.3[,1])
role.3[m6.2,1]
role.3<-role.3[!m6.2,]
role.3
castlist
xml_remove(castlist[[which(m6.2)]]) # removes empty entry in castlist
#castlist.r<-xml_remove(castlist[which(m6.2)])
#castlist.r<-castlist[1:12]
castlist.elm<-xml_find_all(tei,"//castList")
castlist.elm
castlist<-xml_find_all(tei,"//castItem") # refresh after deleting!
castlist
xml_text(castlist)
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
return(role.3)
} #end xml.cor.2
###################
#process.ezd() # performs ezd transformation and writes to file
#############
tei<-xml.cor.1() # reads from created .xml to finalize xml
################
role.3<-xml.cor.2()
###################
castlist<-xml_find_all(tei,"//castItem")
castlist.elm<-xml_find_all(tei,"//castList")

########################################
#m7.1<-grep(",",xml_text(castlist.elm[[1]]))
#k<-12
#length(castlist.elm[[1]][[1]])
#c1<-xml_replace(castlist.elm,castlist.r)
#rol
#k<-2
castlist
done<-expression(role.3[k,4]==1)
eval(done)
done.set<-expression(role.3[k,4]<-1)
k<-2
####### WAIT
for (k in 1:length(castlist)){
  sp.role<-role.3[k,1]
  sp.desc<-role.3[k,2]
  sp.cg<-role.3[k,3]
  m.cg<-role.3[,3]==sp.cg
  m.cg.w<-which(m.cg)
  castlist
  eval(done)
  sp.cg!=""&!eval(done)
#  xml_set_text(castlist[k],sp.desc)
  if (sp.cg!=""&!eval(done)){
   # xml_set_text(castlist[k],"")
    #instead create new node
   # cg.node<-list()
    cg.node<-xml_new_root("castGroup")
    
    #xml_replace(castlist[[k]],"castGroup")
    #cg<-xml_find_all(castlist[k],"//castGroup")
    #cg[[1]]
    k
    for (r in 1:length(m.cg.w)) {
    xml_add_child(cg.node,"castItem")
    xml_add_child(xml_child(cg.node,r),"role",role.3[m.cg.w[r],1])
    }
    ci<-xml_find_all(cg.node,"//castItem")
    
   # xml_remove(castlist,)
    #xml_add_child()
    length(ci)
    ci
    c<-1
    #
    r
   # for (c in 1:length(ci)){
      #if(!eval(done)){
    r
    xml_children(ci)
    xml_child(cg.node,1)
        # xml_add_child(xml_child(cg.node,r),"role",role.3[m.cg.w[r],1])
        # 
      #}
      eval(done.set)
 #   }
      
      cg.node
    eval(done.set)
  #  }
    xml_add_child(cg.node,"roleDesc",sp.desc)
    xml_replace(castlist[[k]],cg.node)
    eval(done.set)
    m<-role.3[,3]==sp.cg
    role.3[m,4]<-1
    
  }
    castlist[[2]]
  #  xml_text()
   # xml_set_text(cg.role.desc,sp.cg)
  
  if (sp.desc!=""&sp.cg==""&!eval(done)){
    xml_set_text(castlist[k],"")
    xml_add_child(castlist[k],"role",sp.role)
    xml_add_child(castlist[k],"roleDesc",sp.desc)
    role.3[k,4]<-1
    eval(done.set)
#    xml_set_text(xml_child(castlist[k]),sp.role)
 #   xml_text(xml_child(castlist[k]))
  }
    #k<-2
   
    k
  print(k)
 }
sp.cg<-unique(role.3[,3])
sp.cg<-as.double(sp.cg)
sp.cg<-sp.cg[!is.na(sp.cg)]
sp.cg
m1<-role.3[,3]%in%sp.cg
m<-which(m)

cg<-1
castnew<-xml_find_all(tei,"//castList")

for (cg in sp.cg){
m2<-match(cg,role.3[,3])  
m1[m2]<-F
m1
}
nodes.to.remove<-which(m1)
#m<-role.3[,3]==cg
#  m<-which(m)
#  m<-1:length(role.3[,3])
 # m<-m[m<length(castlist)]
  nodes.to.remove<-nodes.to.remove[nodes.to.remove<length(castlist)]
  nodes.to.remove<-nodes.to.remove[!is.na(nodes.to.remove)]
 # nodes.to.remove<-nodes.to.remove+1
  rm<-3
  #for (rm in nodes.to.remove){
    xml_remove(
      castlist[nodes.to.remove],free = T
      )
    print(nodes.to.remove)
   # print(xml_text(castnew[rm]))
  #}
  castlist
#}
#write_xml(xmlt2,xmltarget)
xmltemp<-tempfile()
write_xml(tei,xmltemp)
# wks. TODO reformat xmlformat.pl...
# next: remove () in <stage>CHK, remove : in <speaker>CHK, castlist role, single line stage directions CHK
# <edit>markup restore CHK 
##### >>> THIS HAS to be future done according the dracor editorial annotation scheme!!!!!!!
xmlt<-readLines(xmltemp)
# editorial markup
# this method has to be changed, editorial annotation better in comment element in .txt
m<-grepl("&lt;(/?edit)&gt;",xmlt)
sum(m)
xmlt[m]<-gsub("&lt;(/?edit)&gt;","<\\1>",xmlt[m])
### wks.
# pagebreaks restore
# regpb<-'<comment>&lt;(pb n="[0-9]{1,2}"/)&gt;</comment>'
# regpb<-'<comment>&lt;(pb n="[0-9]{1,2}"/)&gt;</comment>'
regp1<-"([0-9]{1,2}):"
regp2<-":([0-9]{1,2})"
m1<-grepl(regp1,xmlt)
m2<-grepl(regp2,xmlt)
sum(m1)
xmlt[m1]<-gsub(regp1,'<pb n="\\1"/>',xmlt[m1])
xmlt[m2]<-gsub(regp2,'<pb n="\\1"/>',xmlt[m2])
write.final.xml<-function(xmltarget){
writeLines(xmlt,xmltarget)
library(tools)
file.ns<-gsub(file_ext(xmltarget),"",xmltarget)
system(paste0("xmlformat ",xmltarget," > ",paste0(file.ns),"indent.",file_ext(xmltarget)))
# wks. ##########################################
}
write.final.xml<-function(xmltarget){
  writeLines(xmlt,xmltarget)
  library(tools)
  file.ns<-gsub(file_ext(xmltarget),"",xmltarget)
  system(paste0("xmlformat ",xmltarget," > ",paste0(file.ns),"indent.",file_ext(xmltarget)))
  # wks. ##########################################
}
xmltarget.prod<-"~/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_003_normalised_01.xml"
xmltarget.dev<-"~/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_003_normalised_01.dev.xml"
write.final.xml(xmltarget.dev)
write.final.xml(xmltarget.prod)

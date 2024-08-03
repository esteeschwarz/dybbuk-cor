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
prepare.python<-function(){
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
prepare.python()
#############################
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
#writeLines(text.m.pb,ezd_markup_text)
#wks.
###################################

### convert with local ezdrama parser:
#ezd_markup_text<-"/Users/guhl/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_ezd_pre_semicor_003.txt"


 library(reticulate)

system(paste0("python3 /Users/guhl/Documents/GitHub/dybbuk-cor/convert/actuel/parser.local.py ",ezd_markup_text))
print("finished python ezd")
# 2nd way:
# library(reticulate)
# source_python()
library(xml2)
xmltop<-read_xml("~/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_ezd_pre_semicor_003.xml")
       
speaker.who.cor<-data.frame(neg=c("fishl","freydede","freydle","freyde","rz"),pos=c("fishel","freydele","freydele","freydele","rze"))
speaker.who.cor$neg<-paste0("#",speaker.who.cor$neg)
speaker.who.cor$pos<-paste0("#",speaker.who.cor$pos)
library(purrr)
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

xmltarget<-"~/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_003_normalised_01.xml"
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
##############################
# castlist speaker role:
castlist<-xml_find_all(tei,"//castItem")
cast.txt<-xml_text(castlist)
m<-grep("-",cast.txt)
library(stringi)
#library(purrr)
role<-stri_split_regex(cast.txt," - ",simplify = T)
m4<-role[,2]!=""
k<-4
for (k in 1:length(cast.txt)){
  sp.role<-role[k,2]
  sp.desc<-role[k,1]
  xml_set_text(castlist[k],sp.desc)
  if (sp.role!=""){
    xml_add_child(castlist[k],"role")
    
    xml_set_text(xml_child(castlist[k]),sp.role)
    xml_text(xml_child(castlist[k]))
  }
  
}
#write_xml(xmlt2,xmltarget)
xmltemp<-tempfile()
write_xml(xmlt2,xmltemp)
# wks. TODO reformat xmlformat.pl...
# next: remove () in <stage>CHK, remove : in <speaker>CHK, castlist role, single line stage directions CHK
# <edit>markup restore CHK
##### >>> THIS HAS to be future done according the dracor editorial annotation scheme!!!!!!!
xmlt<-readLines(xmltemp)
m<-grepl("&lt;(/?edit)&gt;",xmlt)
sum(m)
xmlt[m]<-gsub("&lt;(/?edit)&gt;","<\\1>",xmlt[m])
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
writeLines(xmlt,xmltarget)
library(tools)
file.ns<-gsub(file_ext(xmltarget),"",xmltarget)
system(paste0("xmlformat ",xmltarget," > ",paste0(file.ns),"indent.",file_ext(xmltarget)))
# wks. ##########################################

# 14404.git workflow adaptation, ezdrama processing
# 20241001(17.07)
# essai TEI refactoring analogue <yudale-convert_001.R> via
# automated git workflow (git action)
#####################################
#####################################
# test routine
# call python script from R
system("python /home/runner/work/dybbuk-cor/dybbuk-cor/convert/actuel/hello.py ")
print("python script called, file written?")
### wks.
########
# insert and adapt yudale-convert_001.R script
############################################## start pasted script >>

#14313.yudale.TEI.refactoring
#20240729(19.51)
################
# base convert .txt to eazydrama markup for further TEI conversion
##################################################################
# Q:

### set T if new ezd parsing from actualised .txt source
library(tools)
###
#run.ezdrama=T
### else F will use the latest first stage .xml output of ezdrama for further
### xml adaptations
###################
local<-F
path.local.home<-"~/Documents/GitHub/dybbuk-cor"
path.git.tei<-"convert/actuel/TEI"
path.git.home<-"/home/runner/work/dybbuk-cor/dybbuk-cor"
path.dir<-paste(path.git.home,path.git.tei,sep = "/")
path.chose<-function(file,workflow=TRUE){
  ifelse(workflow,
         path.dir,
         path.dir<-paste(path.local.home,"convert/actuel/TEI",sep = "/"))
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
######################
### for device dependent routine
#############################
local<-F
check.src<-function(what){
  ezd_markup_text<-paste(path.dir,"yudale_ezd_pre_semicor_003.txt",sep = "/")
  ezd_markup_text<-file_path_sans_ext(ezd_markup_text)
  ifelse(what=="xml",ezd_markup_text <- paste0(ezd_markup_text,".xml"),
         ezd_markup_text <- paste0(ezd_markup_text,".txt"))
   if(local)
     return(path.chose("yudale_ezd_pre_semicor_003.txt",workflow = F))
  return(ezd_markup_text)
  
}
check.src("xml")
# 14402.reconstruct jonah changes in script: <l> tags for duets, linebreak issue
#library(readtext)
# remove <p> wrap of linebreaks:
ezd.preprocess.txt<-function(text){
  txt<-readLines(text)
  m<-grep("^[0-9]{1,2}:",txt)
  txt.pb<-txt[m]
  txt.r<-readtext(check.src("txt"))$text
  txt.r2<-gsub("\n( ?)([0-9]{1,2}:)\n","\\2",txt.r)
  txt.r2<-gsub("\n([0-9]{1,2}:)\n","\\1",txt.r2)
  txt.r2<-gsub("\n(:[0-9]{1,2})\n","\\1",txt.r2)
  txt.r2<-gsub("\n([0-9]{1,2}:)( ?)\n","\\1",txt.r2)
  txt.r2<-gsub("([0-9]{1,2}:)([@#$~)(])","\\1\n\\2",txt.r2)
  writeLines(txt.r2,check.src("txt"))
  return(txt.r)
}

#local<-F
# writes <pb> corrected file > only once, then transcript is corrected
#m.pb<-ezd.preprocess.txt(check.src("txt"))
#m.pb
# single line stage direction markup:
ezd_markup_text<-check.src(what = "xml")
ezd_markup_text
qfile<-ezd_markup_text
process.ezd<-function(){
  #check.local()
  # ifelse(local,path.local.home,path.git.home)
  ezd_markup_text<-check.src("txt")
    system(paste0("python ",ifelse(local,path.local.home,path.git.home),"/convert/actuel/","parser.git.py ",ezd_markup_text))
    print("finished python ezd")
} #end ezd process .txt
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
 # xml.src.git<-"https://raw.githubusercontent.com/esteeschwarz/dybbuk-cor/main/convert/actuel/TEI/yudale_ezd_pre_semicor_003.xml"
  #xml.src<-ifelse(run.src.git,xml.src.git,xml.src.local)
  xmltop<-read_xml(check.src("xml"))
  
  # xmltop<-read_xml("~/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_ezd_pre_semicor_003.xml")
  
  speaker.who.cor<-data.frame(neg=c("fishel","freydede","freydle","freyde","rze"),pos=c("fishl","freydele","freydele","freydele","rz"))
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
process.ezd() # performs ezd transformation and writes to file
tei<-xml.cor.1() # reads from created .xml to finalize xml # run for test castediting
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
#if(run.ezdrama)
#  process.ezd() # performs ezd transformation and writes to file
#############
#tei<-xml.cor.1() # reads from created .xml to finalize xml
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
#m<-which(m)
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
  castlist[nodes.to.remove],
  free = F
)
print(nodes.to.remove)
print(castlist)
### remove obsolete nodes in header personlist
# sp.cg<-unique(role.3[,3])
# sp.cg<-as.double(sp.cg)
# sp.cg<-sp.cg[!is.na(sp.cg)]
# sp.cg
# m1<-role.3[,3]%in%sp.cg
#m<-which(m)
tei.person<-xml_find_all(tei,"//person")
#person.new<-xml_find_all(tei,"//person")


#}
### wks.
########
### edit personlist sex
role.3[,1]
sex.array<-c("MALE","FEMALE","MALE","MALE","MALE","FEMALE","FEMALE","FEMALE","MALE","MALE","MALE","UNKNOWN","UNKNOWN","UNKNOWN","MALE","MALE")
role.3<-cbind(role.3[,1:length(role.3[1,])],sex.array)
#tei.person<-xml_find_all(tei,"//person")
xml.att.id<-xml_attr(tei.person,"id")
xml.att.id
xml.att.sex<-xml_attr(tei.person,"sex")
xml.att.sex
person.id<-c("vldmn","rz","lteril","ydle","irkhm","ikhne","dbrh","freydele","bermn","isr","edelmn","khr","beyde","le","fishl","khzn")
role.3<-cbind(role.3[,1:length(role.3[1,])],person.id)
role.3<-rbind(role.3,c("alle","","","","","","UNKNOWN","le"),
              c("beyde","","","","","","UNKNOWN","beyde"),
              c("fishl(missing)","","","","","","MALE","fishl"),
              c("khzn(missing)","","","","","","MALE","khzn"))
k<-2
for (k in 1:length(role.3[,8])){
  id<-role.3[k,8]
  sex<-role.3[k,7]
  m<-id==xml.att.id
  xml_set_attr(tei.person[m],"sex",sex)
}
person.id.x<-xml_attr(tei.person,"id")
print(person.id.x)
m<-person.id.x%in%role.3[,8]
sum(m)
person.out<-!m
m1<-person.id.x%in%role.3[,8]
# for (cg in person.id.x){
#   m2<-match(cg,role.3[,3])  
#   m1[m2]<-F
#   m1
# }
m1<-!m1
m1
nodes.to.remove<-which(m1)
person.id.x[nodes.to.remove]
nodes.to.remove<-nodes.to.remove[nodes.to.remove<=length(tei.person)]
nodes.to.remove<-nodes.to.remove[!is.na(nodes.to.remove)]
xml_remove(
  tei.person[nodes.to.remove],
  free = F
)
print(nodes.to.remove)
print(tei.person)


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
xml.filedesc<-read_xml(path.chose("yudale.filedesc.xml",workflow = T))
filedesc<-xml_find_all(tei,"//fileDesc")
xml_replace(filedesc,xml.filedesc)

### add standoff (wikidata/dracor id)
xml.standoff<-read_xml(path.chose("yudale.standoff.xml",workflow = T))
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
  xml_set_attr(tei,"xml:id","yi000003")
  xml_set_attr(tei,"xml:lang","yid")
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
### foreign tags
reg.he<-"\\+!foreign.xml:lang=he!(.+)\\+?!\\+"
reg.he<-"foreign"
#reg.he<-"\\+!foreign.xml:lang=he!(.+)!\\+"
m4<-grep(reg.he,xmlt)
xmlt[m4]
xmlt.f<-xmlt

m.he<-stri_extract_all_regex(xmlt.f,reg.he,simplify = T,omit_no_match = T)
m.he<-m.he[m.he!=""]
m.he
xmlt.f[m4]<-gsub(reg.he,'<foreign xml:lang="he">\\1<foreign>',xmlt[m4])
#writeLines(xmlt.f[m4],"archive/testforeign.xml")
########
# add xml header
xmlhead<-readLines(path.chose("xml_dracor_header.xml", workflow = T))
xmlt.plus.header<-c(xmlhead,xmlt)
#writeLines(xmlt.plus.header,"testxml.xml")
#writeLines(xmlt,"testxml.xml")
### wks.
#file.base
local<-F
write.final.xml<-function(xmlsrc,xmltarget){
  library(tools)
  file.ns<-gsub(file_ext(xmltarget),"",xmltarget)
  indent<-""
  file.base<-basename(xmltarget)
  path.dir
  xmltarget.temp<-paste0(file.base,".temp",".xml")
  path.expand(file.base)
 # path.sep<-stri_split()
 # m<-grep("yidracor",xmltarget)
  #ifelse(length(m)==0,indent<-"indent.",indent<-"")
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
xmltarget.git<-paste(path.git.home,path.git.tei,"validate","lateiner-yudale-der-blinder.xml",sep = "/")
print(xmltarget.git)
#writeLines(xmlt.plus.header,"~/Documents/GitHub/dybbuk-cor/convert/actuel/TEI/yudale_003_normalised_01.temp.xml")
#write.final.xml(xmlt.plus.header,xmltarget.dev)
#write.final.xml(xmlt.plus.header,xmltarget.prod)
#write.final.xml(xmlt.plus.header,xmltarget.dracor)
write.final.xml(xmlt.plus.header,xmltarget.git)


############################################## << end pasted script

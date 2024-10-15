#install dependencies, called if !cache hit
dir.create("rlibs")
cat(">>>>>> rlibs dir:\n")
libs<-list.files("rlibs")
print(libs)

#dep<-read.csv("convert/actuel/rdependencies.csv")
extract_libraries <- function(file) {
  lines <- readLines(file)
  libraries <- unique(gsub(".*library\\((.*)\\).*", "\\1", grep("library\\(", lines, value = TRUE)))
  print(libraries)
  return(libraries)
}
libraries<-extract_libraries("convert/actuel/yudale-convert_002.R")
rlib<-"rlibs"
repos<-'https://cloud.r-project.org'
#dep.array<-dep$pkg[dep$chk!=1]
dep.array<-libraries
dep.to.install<-dep.array
if(length(libs)>0){
  m<-dep.array%in%libs
  dep.to.install<-dep.array[!m]
}
cat(">>>>>> libs to install:\n")
print(dep.to.install)
#print(dep.to.install)
dep.array<-dep.to.install
#dep.array<-libraries
for(k in 1:length(dep.array)){
  li<-dep.array[k]
  cat(">>>>>>>> library to install:",li,"\n")
  install.packages(li,lib=rlib,repos=repos)
  cat(">>>>>>>> library installed\n")
  #dep$chk[dep$pkg==li]<-1
}
#dep$chk[4]<-1
#write.csv(dep,"rdependencies.csv",row.names = F)

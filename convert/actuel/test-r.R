test<-"testartifact"
             test<-list.files()
             writeLines(test,"./testart.md")
             print(list.files("."))
          #   source("test-r.R")
print(.libPaths())

try(library(xml2,lib.loc = "./rlibs")) # test libdir
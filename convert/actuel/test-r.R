test<-"testartifact"
             test<-list.files()
             writeLines(test,"./testart.md")
             print(list.files("."))
          #   source("test-r.R")
.libPaths()
try(library(xml2)) # test libdir
test<-"testartifact"
             test<-list.files()
             writeLines(test,"./testart.md")
             print(list.files("."))
          #   source("test-r.R")
print(.libPaths())

print(try(library(xml2,lib.loc = "./rlibs"))) # test libdir

.libPaths(new = "./rlibs")
print(try(library(purrr)))
# start transform
source("convert/actuel/yudale-convert_002.R")

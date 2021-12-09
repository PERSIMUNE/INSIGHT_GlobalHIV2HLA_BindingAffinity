# library(tidyverse)
# library(magrittr)
# #library(rhdf5)
# 
# fName = "./data/HIV_epitopes_259_index.h5"
# 
# #- Convert binding affinity data to HDF5 for fast indexing
# if (0) {
#   ba = readRDS("./data/HIV_epitopes_259_index.rds")
#   cnames = colnames(ba)[2:ncol(ba)]
#   rnames = ba$Peptides
#   ba = as.matrix(ba[,2:ncol(ba)])
#   
#   rhdf5::h5createFile(fName)
#   
#   rhdf5::h5createGroup(fName, "bindingaffinity")
#   rhdf5::h5write(ba, fName, "bindingaffinity/M")
#   rhdf5::h5write(cnames, fName, "bindingaffinity/colnames")
#   rhdf5::h5write(rnames, fName, "bindingaffinity/rownames")
#   rhdf5::h5closeAll()
# }
# 
# if (0) {
#   #- Get & Save HLA data
#   H = read.delim("./data/hla_lrna_country.tsv", as.is = TRUE)
#   H$MAJOR = str_sub(H$HLA,1,1)
#   for (st in unique(H$MAJOR)) {
#     if (is.na(st)) next()
#     cat(sprintf("Processing '%s'\n",st))
#     H %>% 
#       filter(MAJOR == st) %>% 
#       select(cty=country,hla=HLA) %>% 
#       mutate(has=TRUE) %>% distinct() %>% 
#       spread(cty,has,fill=FALSE) %>% 
#       tibble::column_to_rownames("hla") %>% 
#       saveRDS(sprintf("./data/country.specific/HLA.Alleles/country.specific.HLA-%s.alleles.RDS", st))
#   }
#   #- Get & Save HLA data for all country allele subtypes
#   H %>% 
#     select(cty=country,hla=HLA) %>% 
#     distinct() %>% 
#     mutate(has=TRUE) %>% 
#     spread(cty,has,fill=FALSE) %>% 
#     tibble::column_to_rownames("hla") %>% 
#     saveRDS("./data/country.specific/HLA.Alleles/country.specific.HLA-ACTUAL.alleles.RDS")
#   #- Get & Save HIV data for specific viral subtypes
#   P = readRDS("./data/pep_metadata_blast.rds")
#   for (st in unique(P$subtype)) {
#     if (is.na(st)) next()
#     cat(sprintf("Processing '%s'\n",st))
#     P %>% 
#       filter(subtype == st) %>% 
#       select(cty=country,pep=Peptides) %>% 
#       mutate(has=TRUE) %>% distinct() %>% 
#       spread(cty,has,fill=FALSE) %>% 
#       tibble::column_to_rownames("pep") %>% 
#       saveRDS(sprintf("./data/country.specific/HIV.Peptides/country.specific.HIV-%s.peptides.RDS", st))
#   }
#   #- Get & Save HIV data for all country viral subtypes
#   P %>% 
#     select(cty=country,pep=Peptides) %>% 
#     distinct() %>% 
#     mutate(has=TRUE) %>% 
#     spread(cty,has,fill=FALSE) %>% 
#     saveRDS("./data/country.specific/HIV.Peptides/country.specific.HIV-ACTUAL.peptides.RDS")
#   #- Precalc actual scores
#   getCountrySpecificPeptides = function(subtype) {
#     data = readRDS(sprintf("./data/country.specific/HIV.Peptides/country.specific.HIV-%s.peptides.RDS", subtype))
#     results = map(colnames(data), function(cname) rownames(data)[data[[cname]]])
#     names(results) = colnames(data)
#     results
#   }
#   getCountrySpecificAlleles = function(subtype) {
#     data = readRDS(sprintf("./data/country.specific/HLA.Alleles/country.specific.HLA-%s.alleles.RDS", subtype))
#     results = map(colnames(data), function(cname) rownames(data)[data[[cname]]])
#     names(results) = colnames(data)
#     results
#   }
#   fName = "./data/HIV_epitopes_259_index.h5"
#   M = rhdf5::h5read(fName, "/bindingaffinity/M")
#   M.hla = rhdf5::h5read(fName,"/bindingaffinity/colnames")
#   M.pep = rhdf5::h5read(fName,"/bindingaffinity/rownames")
#   nonbinder.threshold = 0.4
#   for (st.pep in c(unique(P$subtype),"ACTUAL")) {
#     cat(sprintf("--> Starting viral subtype: %s\n",st.pep))
#     peptides = getCountrySpecificPeptides(st.pep)
#     for (st.hla in c("A","B","C","ACTUAL")) {
#       alleles = getCountrySpecificAlleles(st.hla)
#       cat(sprintf("Processing HIV-%s:HLA-%s\n",st.pep,st.hla))
#       commonCountries = names(alleles)[names(alleles) %in% names(peptides)]
#       data = map(commonCountries, function(cty) {
#         cty.pep = peptides[[cty]]
#         cty.hla = alleles[[cty]]
#         subset.hla = which(M.hla %in% cty.hla)
#         subset.pep = which(M.pep %in% cty.pep)
#         subset.M   = M[subset.pep, subset.hla]
#         subset.M[subset.M < nonbinder.threshold] = NA
#         subset.M = as.numeric(subset.M)
#         #- Return new score
#         sum(subset.M[!is.na(subset.M)])
#       })
#       names(data) = commonCountries
#       #print (data)
#       saveRDS(data, sprintf("./data/country.specific/Scores/country.specific.scores.HLA-%s.HIV-%s.RDS",st.hla,st.pep))
#     }
#   }
#   #- Get & Save HIV data for all viral subtypes
#   #SKIP FOR LATER
#   #- Precompute cohort statistics
#   
# }
# 
# #- Get handles
# i.hla = rhdf5::h5read(fName,"/bindingaffinity/colnames")
# i.pep = rhdf5::h5read(fName,"/bindingaffinity/rownames")
# #M = rhdf5::H5Fopen(fName)&"/bindingaffinity/M"
# i.M = rhdf5::h5read(fName, "/bindingaffinity/M")
# 
# #- Define compute variables
# gms  = readRDS("./data/geometries.RDS")
# peps = readRDS("./data/pep_metadata_blast.rds") %>% 
#   select(country, peptides = Peptides) %>% 
#   distinct()
# hlas = read.delim("./data/hla_lrna_country.tsv") %>% 
#   select(country, hla = HLA) %>% 
#   distinct()
# 
# #- Calculate score and add to gms
# getCountryScore = function(cty, nonbinder.threshold = 0.4) {
#   cat(sprintf("Processing %s\n", cty))
#   choose.hla = unique((hlas %>% filter(country == cty))$hla     )
#   choose.pep = unique((peps %>% filter(country == cty))$peptides)
#   subset.hla = which(i.hla %in% choose.hla)
#   subset.pep = which(i.pep %in% choose.pep)
#   subset.M   = i.M[subset.pep, subset.hla]
#   subset.M[subset.M < nonbinder.threshold] = NA
#   subset.M = as.numeric(subset.M)
#   sum(subset.M[!is.na(subset.M)])
# }
# 
# gms$score = map_dbl(gms$country, getCountryScore)
# 
# #- Save to file
# saveRDS(gms, "./data/geometries.withScore.RDS")
# 
# #- Close all connections
# rhdf5::h5closeAll()

handleDataLoaders = function(rv) {
  #- Load main country-level dataset with geojson
  my_sf <<- reactive({
    readRDS("./data/world.RDS")
  })
  
  map_base <<- reactive({
    draw_base_map()
  })
  
  #- Load hla- and country-level sample data
  getStats <<- shiny::reactive({
    #Cols: HLA, country, n, lrna_mean, n_country, mean_lrna_country, carriers_freq
    readRDS("./data/hla_stats.RDS")
  })
  
  getHLACountry <<- shiny::reactive({
    getStats() %>% select(hla = HLA, country)
  })
  
  getSampling <<- shiny::reactive({
    getStats() %>% dplyr::select(country, samples=n_country) %>% dplyr::distinct()
  })
  
  getN <<- shiny::reactive({
    if (rv$country == "World") return(sum(getSampling()$samples))
    (getSampling() %>% dplyr::filter(country == rv$country))$samples
  })
  
  #- Load sample data
  getSamples <<- shiny::reactive({
    #Cols: sid "sample ID", subtype, country, region
    readRDS("./data/samples.RDS")
  })
  
  getSampleCount <<- shiny::reactive({
    if (rv$country == "World") return(dim(getSamples())[1])
    dim(getSamples() %>% filter(country == rv$country))[1]
  })
  
  #- Load peptide & subtype data
  getPeptideCounts <<- shiny::reactive({
    #Cols: country, peptides "unique peptide count"
    readRDS("./data/peptide_counts.RDS")
  })
  
  getPeptideCount <<- shiny::reactive({
    if (rv$country == "World") return(sum(getPeptideCounts()$peptides))
    (getPeptideCounts() %>% dplyr::filter(country == rv$country))$peptides
  })
  
  getPeptideCountry <<- shiny::reactive({
    #Cols: peptide, country
    readRDS("./data/peptide_country.RDS")
  })
  
  getPeptideProtein <<- shiny::reactive({
    #Cols: peptide, protein, start
    readRDS("./data/peptide_protein.RDS")
  })
  
  getSubtypeCounts <<- shiny::reactive({
    #Cols: country, subtype, patients "unique sample counts"
    readRDS("./data/subtype_counts.RDS")
  })
  
  getSubtypeCountsByCountry <<- shiny::reactive({
    if (rv$country == "World") {
      getSubtypeCounts() %>% dplyr::group_by(subtype) %>% summarise(patients = sum(patients))
    } else {
      getSubtypeCounts() %>% dplyr::filter(country == rv$country) %>% dplyr::select(subtype, patients)
    }
  })
  
  #- Load binding affinity data
  getPeptideBindingMatrix <<- shiny::reactive({
    #Fetches a binary matrix of peptides and the country's who have alleles that bind the peptide.
    readRDS("./data/peptide_country_bindmatrix.rds")
  })
  
  getPeptideBindingProfile <<- function(country) {
    getPeptideBindingMatrix()[, country]
  }
  
  getPeptideLocationMatix <<- shiny::reactive({
    #Fetches a binary matrix of peptides and the country's who have HIV samples coding for the peptide.
    readRDS("./data/peptide_country_foundmatrix.rds")
  })
  
  getPeptideLocationProfile <<- function(country) {
    getPeptideLocationMatix()[, country]
  }
  
  getHIVBinding <<- shiny::reactive({
    #- Setup base df
    data  = getPeptideBindingMatrix() %>% dplyr::select(peptide) %>% dplyr::mutate(Binder = "Inactive")
    #- Determine peptides bindable by local HLAs but not found locally
    bprof = getPeptideBindingProfile(rv$country)
    data$Binder[bprof==1] = "Exogenous"
    #- Determine peptides both bindable by local HLAs and peptides sampled locally
    lprof = getPeptideLocationProfile(rv$country)
    data$Binder[bprof * lprof == 1] = "Endogenous"
    data
  })
  
  getHIVBindingSummaryProtein <<- shiny::reactive({
    getHIVBinding() %>% dplyr::left_join(getPeptideProtein() %>% dplyr::select(peptide, protein), by = "peptide")
  })
  
  getHIVBindingSummaryPosition <<- shiny::reactive({
    data = getHIVBinding() %>% dplyr::left_join(getPeptideProtein() %>% dplyr::select(peptide, protein, start), by = "peptide")
    return (data)
  })
}
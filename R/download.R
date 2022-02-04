# Handle Data1 - HIV derived binding affinities
download_data1_title = "HLA functional clusters - HIV peptides"
download_data1_ui    = shinyWidgets::downloadBttn("data1", NULL, style = "simple", size = "xs")
download_data1_txt   = "HLA hierarchical nodes based on consensus clustering of predicted binding affinities to HIV peptides."
download_data1_srv   = shiny::downloadHandler(
  filename = function() {paste('data-bindingaffinity-hiv', '.tsv', sep='')},
  content = function(con) {file.copy("./data/HLA_nodes_HIV_peptides.tsv", con)}
)
# Handle Data2 - Binding affinities to random peptidomes
download_data2_title = "HLA functional clusters - Random peptides"
download_data2_ui    = shinyWidgets::downloadBttn("data2", NULL, style = "simple", size = "xs")
download_data2_txt   = "HLA hierarchical nodes based on consensus clustering of predicted binding affinities to random peptides from Uniprot."
download_data2_srv   = shiny::downloadHandler(
  filename = function() {paste('data-bindingaffinity-random', '.tsv', sep='')},
  content = function(con) {file.copy("./data/HLA_nodes_random_peptides.tsv", con)}
)
# Handle Data3 - 
download_data3_title = "Predicted binding affinities - HIV peptides"
download_data3_ui    = shinyWidgets::downloadBttn("data3", NULL, style = "simple", size = "xs")
download_data3_txt   = "Predicted binding affinities of HLA alleles. Downloaded as an R RDS file."
download_data3_srv   = shiny::downloadHandler(
  filename = function() {paste('percountry_hla_binding', '.rds', sep='')},
  content = function(con) {file.copy("./data/peptide_country_bindmatrix.rds", con)}
)
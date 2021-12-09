#> Bind
bind = read_rds("./data/HIV_epitopes_268_index.rds")
hla = readRDS("./data/hla_stats.RDS") %>% select(hla=HLA,country)
bindl = bind %>% tidyr::pivot_longer(-Peptides, names_to = "hla", values_to = "affinity")
bindlj = bindl %>% left_join(hla, by = "hla")
bindlj$pass = bindlj$affinity > 0.426
bindf = bindlj %>% select(-affinity) %>% filter(pass) %>% drop_na(country)
bindc = bindf %>% select(-hla) %>% group_by(Peptides, hla, country) %>% summarise(Pass = n())
bindw = bindc %>% pivot_wider(Peptides,names_from = "country", values_from = Pass, values_fill = 0) %>% mutate(World = as.integer(rowSums(across(where(is.numeric))) >= 1))

#> Update main
#--> Add basic country level data
hlastats = readRDS("./data/hla_stats.RDS")
hlastats.sub1 = hlastats %>% select(country, mean_viral_load=mean_lrna_country, patients=n_country) %>% distinct()
sf = readRDS("./data/geometries.withScore2.RDS") %>% 
  filter(code != "ATA") %>% # Filter out Antarctica.
  filter(score != 0) %>% 
  select(-score) %>% 
  left_join(hlastats.sub1)

#--> Add HLA diversity metrics
hlastats.sub2 = hlastats %>% select(hla=HLA, country, n) %>% pivot_wider(country,names_from = "hla", values_from = "n", values_fill = 0) %>% tibble::column_to_rownames("country")
sf = sf %>% left_join(
  data.frame(country = rownames(hlastats.sub2),
             hla.shannon = hlastats.sub2 %>% vegan::diversity("shannon"),
             hla.simpson = hlastats.sub2 %>% vegan::diversity("simpson"),
             hla.invsimp = hlastats.sub2 %>% vegan::diversity("invsimpson"))
)

#--> Add HIV subtype diversity metrics
hiv = readRDS("./data/subtype_counts.RDS") %>% pivot_wider(country,names_from = "subtype", values_from = "patients", values_fill = 0) %>% tibble::column_to_rownames("country")
sf = sf %>% left_join(
  data.frame(country = rownames(hiv),
             hiv.shannon = hiv %>% vegan::diversity("shannon"),
             hiv.simpson = hiv %>% vegan::diversity("simpson"),
             hiv.invsimp = hiv %>% vegan::diversity("invsimpson"))
)

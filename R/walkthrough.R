walkthrough = cicerone::Cicerone$new(
  id = "walkthrough",
  allow_close = FALSE,
  close_btn_text = "Skip",
)$ 
  step(
    "[data-value='Map']",
    "Welcome",
    "(1/7) Welcome to the app. This is the main view where cohort data is presented on the world map. Click 'Skip' to skip this tutorial, or click 'Next' if this is your first time. Refresh the page to get back to this tutorial.",
    is_id = FALSE
  )$
  step(
    "[data-value='About']",
    "About",
    "(2/7) You will find metadata here, including links to the main publication, supplementary material, and the reference should you find this work useful.",
    is_id = FALSE
  )$
  step(
    "myMap",
    "Main view",
    "(3/7) This map is your main tool to explore and view data by geography. Click-drag or use your mouse-wheel to navigate. Left-click on countries to select and highlight them in yellow. A random country is selected every time you start this app. Clicking the same country twice will select every country (all data). When you are in this 'World' mode, click on any country to focus on it.",
    position = "mid-center"
  )$
  step(
    "info_panel",
    "Information panel",
    "(4/7) Information is presented based on what country you have selected. This info box displays some useful statistics as well as informing you on what slice of data you are looking at."
  )$
  step(
    "btnShowHelp",
    "Need help?",
    "(5/7) Clicking on this button will bring up a panel to the far right with detailed help."
  )$
  step(
    "btnShowPlots",
    "Need to see data?",
    "(6/7) Clicking on this button will bring up a panel to the far right with several plots. These plots describe global distributions of HIV subtypes sampled across our cohort as well as imputed HLA haplotypes for all patients in our cohort. You will also find summaries for predicted HLA-allele:HIV-peptide binding affinities and lastly, derived from this data, the Functional HLA Clusters themselves."
  )$
  step(
    "btnSettings",
    "Map settings",
    "(7/7) The data views from the plot panel are detailed but they are not the only way to explore the data. Click on this settings icon for the choropleth map where you will find different options to select which data should be projected.",
    position = "right"
  )
  
  # step(
  #   "showHIV",
  #   "Enable or disable views",
  #   "(7/15) Use these top-level switches to enable or disable views you would like to focus on. By default, only this view on HIV subtype frequencies is enabled."
  # )$
  # step(
  #   "plotID_HIV",
  #   "The HIV view.",
  #   "(8/15) This plot displays the frequency of HIV subtypes sampled from local participants and then sequenced (by HT-Seq)."
  # )$
  # step(
  #   "showHLA",
  #   "Enable the HLA view",
  #   "(9/15) We've now disabled the HIV view and enabled HLA."
  # )$
  # step(
  #   "plotID_HLA",
  #   "The HLA view",
  #   "(10/15) This plot displays the frequency of HLA alleles imputed from the genotypes of cohort participants (by array)."
  # )$
  # step(
  #   "showBIND",
  #   "Enable the peptide binding view",
  #   "(11/15) We've now disabled the HLA view and enabled peptide binding."
  # )$
  # step(
  #   "plotID_BIND",
  #   "The peptide binding view",
  #   "(12/15) This plot displays the frequency of peptides from different geographies predicted to bind HLA alleles imputed from the locally genotyped population. Take a look at the help panel to find out more."
  # )$
  # step(
  #   "showDetailed",
  #   "Detailed peptide binding views",
  #   "(13/15) The peptide binding view allows you to drill down to the amino acid level for each viral protein using these options."
  # )$
  # step(
  #   "showDetailedByGroup",
  #   "Detailed peptide binding views",
  #   "(14/15) You can also look at several proteins belonging to 1-of-3 structural/functional groups."
  # )$
  # step(
  #   "btnSettings",
  #   "Map settings",
  #   "(15/15) The data views from the plot panel are detailed but also not the only way to explore this study's data. Click on this settings icon for the choropleth map where you will find different options to select which data should be projected.",
  #   position = "right"
  # )
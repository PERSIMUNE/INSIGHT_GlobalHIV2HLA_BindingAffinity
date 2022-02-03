## > Main borders ----
yTop <- "52px"

## > Map Info ----
mapInfoPanel <- absolutePanel(
  id = "info_panel", class = "panel panel-default",
  fixed = TRUE, draggable = FALSE,
  # top = yTop, right = "1%", width = "350px", height = "100px",
  bottom = "10px", left = "10px", width = "350px", height = "100px",
  htmlOutput("selectionSummary")
)

## > Main button positioning ----
yHelp <- yTop
xHelp <- "30px"
yPlot <- "75px"
xPlot <- "50px"
ySett <- "80px"
xSett <- "10px"

## > Map Help ----
helpBtn <- makeStateBtn(id = "btnShowHelp", label = NULL, icon = "question", top = yHelp, left = xHelp, color = "success")

helpPanel <- pushbar::pushbar(
  shiny::tags$style(shiny::HTML("table th, table td {padding: 10px;}")),
  shiny::includeMarkdown("./markdown/help.md"),
  id = "helpPushbar",
  from = "right",
  style = "background:#fff;padding:60px;top:0;right:0;width:35%;max-width:100%;height:100%;min-height:100vh"
)


## > Plot Legends ----
plotHIV.legend <- shiny::HTML("<p><b>HIV subtype counts</b><br /> HIV subtypes were assessed on plasma samples obtained from 2172 ART-naïve, HIV+ participants from 21 countries enrolled in the START study. Extracted HIV RNA was sequenced using Illumina MiSeq for paired-end sequencing. The counts depicted are based on the current selection, for the total counts of samples see the total of Available HIV samples stated on the on the left legend.</p>")
plotHLA.legend <- shiny::HTML("<p><b>Imputed HLA alleles counts</b><br /> Classic HLA class I alleles (HLA-A, HLA-B and HLA-C) for 2546 genotyped ART-naïve, HIV-infected participants were imputed using HIBAG at 4-digit resolution based on a multi-ethnic pre-trained model. The minimum out-of-bag accuracy was 90% for all loci. For more details check (Ekenberg et al., 2019)</p>")
plotBIND.legend <- shiny::HTML("<p><b>Predicted binding HIV peptides to imputed HLA alleles</b><br /> Extracted HIV reads were fragmented into 27-mers using KAT and those with a count higher than 1 were translated into peptide sequences of 9 amino acids length to fit the mean length of HLA Class I epitopes. Peptides were mapped to ten major HIV proteins (Asp, Gag-Pol, Nef, Vpr, Vpu, gp160, Vif, Pr55, Rev, Tat) from NCBI RefSeq NC001802.1 using BLAST 2.8.1 (blastp-short) excluding hits with an E-value > 1E-05. Binding affinities of 268 class I HLA alleles to HIV and random peptidomes were predicted using NetMHCpan 4.0. The binding threshold was set at 0.426, which when intersected with original of sample and corresponding imputed HLA types results in the 3 major groupings presented above: (Inactive) being those peptides that show no binding in locally imputed HLA types; (Exogenous) being those peptides that are not found in local HIV samples but that would be bound by locally imputed HLA types; and lastly (Endogenous) being those peptides found in local HIV samples and predicted to be bound by locally imputed HLA types.</p>")

## > Plot Panel ----
plotBtn <- makeStateBtn(id = "btnShowPlots", label = NULL, icon = "chart-bar", top = yPlot, left = xPlot, color = "primary")

plotPanel <- pushbar::pushbar(
  shiny::h3("Select data to plot:"),
  shinyWidgets::materialSwitch("showHIV", label = "Show HIV subtypes", value = TRUE, status = "info", inline = TRUE),
  shinyWidgets::materialSwitch("showHLA", label = "HLA alleles", value = FALSE, status = "info", inline = TRUE),
  shinyWidgets::materialSwitch("showBIND", label = "Binding affinity", value = FALSE, status = "info", inline = TRUE),
  shinyWidgets::materialSwitch("showTREE", label = "Functional HLA clustering", value = FALSE, status = "info", inline = TRUE),
  shiny::hr(),
  shiny::conditionalPanel("input.showHIV", shiny::div(id = "plotID_HIV", plotly::plotlyOutput("plotHIV", width = "100%") %>% mySpinner(), plotHIV.legend), shiny::hr()),
  shiny::conditionalPanel("input.showHLA", shiny::div(id = "plotID_HLA", plotly::plotlyOutput("plotHLA", width = "100%") %>% mySpinner(), plotHLA.legend), shiny::hr()),
  shiny::conditionalPanel(
    "input.showBIND",
    shiny::div(id = "plotID_BIND", plotly::plotlyOutput("plotBIND", width = "100%") %>% mySpinner(), plotBIND.legend),
    shiny::fluidRow(
      shiny::column(
        width = 6,
        shinyWidgets::prettyCheckboxGroup(
          inputId = "showDetailed",
          label = "Binding profile by amino acid position in:",
          choices = c("gag", "pol", "vif", "vpr", "tat", "vpu", "rev", "env", "nef", "asp"),
          icon = icon("check-square-o"),
          status = "primary",
          outline = TRUE,
          inline = TRUE,
          animation = "smooth"
        )
      ),
      shiny::column(
        width = 6,
        shinyWidgets::prettyCheckboxGroup(
          inputId = "showDetailedByGroup",
          label = "Show binding profile by protein group:",
          choices = c("Structural", "Essential", "Accessory"),
          icon = icon("check-square-o"),
          status = "primary",
          outline = TRUE,
          inline = TRUE,
          animation = "smooth"
        )
      )
    ),
    shiny::conditionalPanel('input.showDetailed.includes("gag") || input.showDetailedByGroup.includes("Structural")', plotlyOutput("plotPROT_Gag") %>% mySpinner()),
    shiny::conditionalPanel('input.showDetailed.includes("pol") || input.showDetailedByGroup.includes("Structural")', plotlyOutput("plotPROT_Pol") %>% mySpinner()),
    shiny::conditionalPanel('input.showDetailed.includes("vif") || input.showDetailedByGroup.includes("Accessory")', plotlyOutput("plotPROT_Vif") %>% mySpinner()),
    shiny::conditionalPanel('input.showDetailed.includes("vpr") || input.showDetailedByGroup.includes("Accessory")', plotlyOutput("plotPROT_Vpr") %>% mySpinner()),
    shiny::conditionalPanel('input.showDetailed.includes("tat") || input.showDetailedByGroup.includes("Essential")', plotlyOutput("plotPROT_Tat") %>% mySpinner()),
    shiny::conditionalPanel('input.showDetailed.includes("vpu") || input.showDetailedByGroup.includes("Accessory")', plotlyOutput("plotPROT_Vpu") %>% mySpinner()),
    shiny::conditionalPanel('input.showDetailed.includes("rev") || input.showDetailedByGroup.includes("Essential")', plotlyOutput("plotPROT_Rev") %>% mySpinner()),
    shiny::conditionalPanel('input.showDetailed.includes("env") || input.showDetailedByGroup.includes("Structural")', plotlyOutput("plotPROT_Env") %>% mySpinner()),
    shiny::conditionalPanel('input.showDetailed.includes("nef") || input.showDetailedByGroup.includes("Accessory")', plotlyOutput("plotPROT_Nef") %>% mySpinner()),
    shiny::conditionalPanel('input.showDetailed.includes("asp")', plotlyOutput("plotPROT_Asp") %>% mySpinner()),
    shiny::hr()
  ),
  # TODO move to tab
  shiny::conditionalPanel(
    "input.showTREE",
    shiny::div(
      id = "treeBIND",
      shiny::fluidRow(
        shiny::column(width = 4, shiny::tags$image(src = "./tree_small.png", width = "100%")),
        shiny::column(
          width = 5,
          shiny::tags$p(shiny::h3("Dendrogram of 268 HLA class I alleles based on consensus clustering of predicted binding affinities to HIV peptides"), shiny::p("Predicted binding affinities to 173,792 HIV peptides were used to calculate the HLA allele distances used for consensus clustering and represented as a dendrogram through hierarchical clustering. Associations to log10(HIV-VL) of each node (HLA functional node) and leaves (HLA alleles) in the dendrogram were tested and adjusted by sex, self-reported race, and country. Associations were defined by an adjusted p-value (Benjamini-Hochberg) < 0.05 and are represented as thick branches for nodes and black triangles for leaves. White triangles indicate HLA alleles detected in our cohort. The effect of the respective associations is color-coded from protective effect (blue) to detrimental (red). On the outer ring, HLA allele counts are depicted as green bars."), shiny::p("Click 'Zoom' to open a large version of the dendogram. Click 'Interactive' to open a new tab to the version on iTOL.", style = "color: blue;")),
          shinyWidgets::actionBttn("btnTreeZoom", label = "Zoom", icon = shiny::icon("search"), style = "jelly", color = "primary"),
          shiny::tags$a(
            shinyWidgets::actionBttn("btnTreeLink1", label = "Interactive", icon = shiny::icon("play"), style = "jelly", color = "primary"),
            href = bindTreeURL, target = "_blank"
          )
        )
      )
    )
  ),
  id = "plotPushbar",
  from = "right",
  style = "background:#fff;padding:60px;top:0;right:0;width:50%;max-width:100%;height:100%;min-height:100vh"
)

# TODO move to tab
treePanel <- pushbar::pushbar(
  shiny::h3("Dendrogram of 268 HLA class I alleles based on consensus clustering of predicted binding affinities to HIV peptides"),
  shiny::p("Predicted binding affinities to 173,792 HIV peptides were used to calculate the HLA allele distances used for consensus clustering and represented as a dendrogram through hierarchical clustering. Associations to log10(HIV-VL) of each node (HLA functional node) and leaves (HLA alleles) in the dendrogram were tested and adjusted by sex, self-reported race, and country. Associations were defined by an adjusted p-value (Benjamini-Hochberg) < 0.05 and are represented as thick branches for nodes and black triangles for leaves. White triangles indicate HLA alleles detected in our cohort. The effect of the respective associations is color-coded from protective effect (blue) to detrimental (red). On the outer ring, HLA allele counts are depicted as green bars."),
  shiny::div(
    shinyWidgets::actionBttn("btnTreeClose", label = "Close", icon = shiny::icon("stop"), style = "jelly", color = "danger"),
    shiny::tags$a(
      shinyWidgets::actionBttn("btnTreeLink2", label = "Interactive", icon = shiny::icon("play"), style = "jelly", color = "primary"),
      href = bindTreeURL, target = "_blank"
    )
  ),
  shiny::hr(),
  shiny::tags$image(src = "./tree.png", height = "80%"),
  id = "treePushbar",
  from = "left",
  style = "background:#fff;padding:60px;top:0;right:0;width:100%;max-width:100%;height:100%;min-height:100vh"
)

## > Map Settings ----
mapSettingsPanel <- absolutePanel(
  id = "controls", class = "panel panel-default",
  fixed = TRUE, draggable = TRUE,
  top = ySett, left = xSett, right = "auto", bottom = "auto",
  width = 0, height = 0,
  dropdownButton(
    inputId = "btnSettings",
    tooltip = TRUE,
    label = "Settings",
    icon = icon("gear"),
    status = "primary",
    circle = TRUE,
    width = 275,
    margin = "10px",
    radioGroupButtons("settings", "SETTINGS",
      choices = c("MAP", "DOWNLOAD"),
      selected = "MAP"
    ),
    hr(),
    conditionalPanel(
      "input.settings == 'MAP'",
      radioGroupButtons("geo", "GEOGRAPHY",
        choices = c(Selection = "selected", Country = "country", Patients = "patients"),
        selected = "selected"
      ),
      radioGroupButtons("hla", "HUMAN LEUKOCYTE ANTIGEN",
        choices = c(`Simpson (1-D)` = "hla.simpson", `1/D` = "hla.invsimp", Shannon = "hla.shannon"),
        selected = FALSE
      ),
      radioGroupButtons("hiv", "HUMAN IMMUNODEFICIENCY VIRUS",
        choices = c(`Simpson (1-D)` = "hiv.simpson", `1/D` = "hiv.invsimp", Shannon = "hiv.shannon"),
        selected = FALSE
      ),
      radioGroupButtons("vlo", NULL,
        choices = c(`Viral load` = "mean_viral_load"),
        selected = FALSE
      ),
      shinyWidgets::materialSwitch("mapLegend", "View legend", value = TRUE, status = "info")
    ),
    conditionalPanel(
      "input.settings == 'GRAPHS'",
      radioGroupButtons("facet", "DATA FACET",
        choices = c(HIV = "hiv", 
        BINDING = "binding", 
        HLA = "hla"),
        selected = "hiv"
      ),
      conditionalPanel(
        "input.facet == 'hiv'",
        "HIV plot controls"
      ),
      conditionalPanel(
        "input.facet == 'binding'",
        "Binding affinity plot controls"
      ),
      conditionalPanel(
        "input.facet == 'hla'",
        "HLA plot controls"
      )
    ),
    # TODO insert link to files
    conditionalPanel("input.settings == 'DOWNLOAD'", shiny::div(
      shiny::p(shiny::h4("HLA functional clusters - HIV peptides"), 
      shinyWidgets::downloadBttn("data1", NULL, style = "simple", size = "xs"), 
      "HLA hierarchical nodes based on consensus clustering of predicted binding affinities to HIV peptides.  ./data/HLA_nodes_HIV_peptides.tsv"),
      shiny::p(shiny::h4("HLA functional clusters - Random peptides"), 
      shinyWidgets::downloadBttn("data2", NULL, style = "simple", size = "xs"), 
      "HLA hierarchical nodes based on consensus clustering of predicted binding affinities to random peptides from Uniprot  ./data/HLA_nodes_random_peptides.tsv")#,
      ## This matrix might be too big but it would be nice to provide it
      # shiny::p(shiny::h4("Predicted binding affinities - HIV peptides"), 
      # shinyWidgets::downloadBttn("data3", NULL, style = "simple", size = "xs"), 
      # "Predicted binding affinities of HLA alleles ./data/peptide_country_bindmatrix.rds ??? (not sure)")
    ))
  )
)
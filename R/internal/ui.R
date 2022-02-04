shiny::navbarPage(
  title = "Global HLA Binding Affinities to HIV Peptides",
  theme = shinythemes::shinytheme("simplex"),
  shiny::tabPanel("Map", id = "tabSetMap",
    #- Load dependencies
    shiny::tags$script(appDimensions, appResize, launchHelpOnStart),
    waiter::use_waiter(),
    waiter::use_steward(),
    waiter::waiter_preloader(html = loading_screen),
    cicerone::use_cicerone(),
    pushbar::pushbar_deps(),
    shinyjs::useShinyjs(),
    #- Main map div
    shiny::div(class = "outer",
               shiny::tags$head(shiny::includeCSS("styles.css")),
               
               mapdeck::mapdeckOutput(outputId = "myMap", width = "100%", height = "100%"),
               
               mapSettingsPanel, helpBtn, plotBtn, mapInfoPanel, plotPanel, helpPanel, 
               
               shiny::tags$div(id = "cite", 'Data compiled by Zucco et al., 2019.'),
    )     
  ),
  shiny::tabPanel("Functional HLA clustering", id = "tabSetFunc", treePanel),
  shiny::tabPanel("About", id = "tabSetAbout", shiny::includeMarkdown("./markdown/about.md"))
)
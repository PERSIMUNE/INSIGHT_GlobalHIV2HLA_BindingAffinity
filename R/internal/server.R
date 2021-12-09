pushbar::setup_pushbar(blur = TRUE, overlay = FALSE)

#> REACTIVES VALUES ----
#-----------------------

rv = shiny::reactiveValues()
rv$sessionStarted = 0
rv$country = sample(readRDS("./data/hla_stats.RDS")$country %>% unique(), 1)
rv$colorMapBy = "selected"
rv$showHelp = 0

##> STATIC VALUES ----
#---------------------------
sv = list()
sv$plotPanelOpen = FALSE
sv$helpPanelOpen = FALSE

#> HANDLE NAMED FUNCTIONS ----
#-----------------------------

handleDataLoaders(rv)        # 'data.R'
handlePlotters(rv)           # 'plots.R'
handleOutputs(output, rv)    # 'output.R'

#> OBSERVERS/REACTIVES ----
#--------------------------

#- Listen for changes in screen width/height
observeEvent(input$appWidth, {rv$appWidth = input$appWidth})
observeEvent(input$appHeight, {rv$appHeight = input$appHeight})

#- Listen for changes in map settings / data
shiny::observe({
  update_map("myMap", rv$country, my_sf(), rv$colorMapBy, input$mapLegend)
})

#- Listen for click on polygon map layer and update country selection.
shiny::observeEvent(input$myMap_polygon_click, {
  selection = rjson::fromJSON(input$myMap_polygon_click)$object$properties$tooltip
  if (selection == rv$country) rv$country = "World"
  else rv$country = selection
})

#- Listen for switches in map settings
shiny::observeEvent(input$geo, {rv$colorMapBy = input$geo; resetTheseRadioButtons(c("hla", "hiv", "vlo"))})
shiny::observeEvent(input$hla, {rv$colorMapBy = input$hla; resetTheseRadioButtons(c("geo", "hiv", "vlo"))})
shiny::observeEvent(input$hiv, {rv$colorMapBy = input$hiv; resetTheseRadioButtons(c("hla", "geo", "vlo"))})
shiny::observeEvent(input$vlo, {rv$colorMapBy = input$vlo; resetTheseRadioButtons(c("geo", "hla", "hiv"))})

resetTheseRadioButtons = function(these) {
  for (btn in these) shinyWidgets::updateRadioGroupButtons(session, btn, selected = FALSE)
}

#- Listen for pushbar events
shiny::observeEvent(input$btnShowPlots, {
  pushbar::pushbar_close()
  sv$helpPanelOpen <<- FALSE
  if (!sv$plotPanelOpen) {pushbar::pushbar_open(id = "plotPushbar"); sv$plotPanelOpen <<- TRUE }
  else                   {                                           sv$plotPanelOpen <<- FALSE}
})

shiny::observeEvent(input$btnShowHelp, {
  pushbar::pushbar_close()
  sv$plotPanelOpen <<- FALSE
  if (!sv$helpPanelOpen) {pushbar::pushbar_open(id = "helpPushbar"); sv$helpPanelOpen <<- TRUE }
  else                   {                                           sv$helpPanelOpen <<- FALSE}
})

shiny::observeEvent(input$btnTreeZoom, {
  pushbar::pushbar_close()
  sv$plotPanelOpen <<- FALSE
  pushbar::pushbar_open(id = "treePushbar")
})

shiny::observeEvent(input$btnTreeClose, {
  shinyjs::click("btnShowPlots")
})

#- Listen for preloader ending
shiny::observeEvent(input$sessionInitialized, {
  walkthrough$init()$start()
})

#- Listen for walkthrough steps
shiny::observeEvent(input$walkthrough_cicerone_next, {
  comingFrom = input$walkthrough_cicerone_next$highlighted
  if      (comingFrom == "info_panel") shinyjs::click("btnShowHelp")
  else if (comingFrom == "btnShowHelp") shinyjs::click("btnShowPlots")
  else if (comingFrom == "btnShowPlots") {
    shinyjs::click("btnShowPlots")
    shinyjs::click("btnSettings")
  }
  # else if (comingFrom == "plotID_HIV") {
  #   shinyjs::click("showHIV")
  #   shinyjs::click("showHLA")
  # }
  # else if (comingFrom == "plotID_HLA") {
  #   shinyjs::click("showHLA")
  #   shinyjs::click("showBIND")
  # }
  # else if (comingFrom == "showDetailedByGroup") {
  #   shinyjs::click("showHIV")
  #   shinyjs::click("showBIND")
  #   shinyjs::click("btnSettings")
  # }
})



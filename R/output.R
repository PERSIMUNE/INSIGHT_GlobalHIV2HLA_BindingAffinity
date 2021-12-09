handleOutputs = function(output, rv) {
  
  output$myMap = mapdeck::renderMapdeck({ map_base() })
  
  output$selectionSummary = shiny::renderUI({
    shiny::fluidRow(style = "overflow-y: 95px;",
      shiny::column(width=1),
      shiny::column(width=11,
        HTML(paste0("<b>Information pane</b>:<br />"
                    ,"Geography selected: ", rv$country, "<br/>"
                    ,"Available HIV samples: ", getSampleCount() ,"<br/>"
                    ,"Available patients genotyped: ", getN(),"<br/>"
                    ,"No. peptides resolved: ", getPeptideCount()#,"<br/>"
                    #,"Screen dimensions: ", rv$appWidth, " x ", rv$appHeight
        ))
      )
    )
  })
  
  reduceInteraction = function(plotlyPlot, strong = FALSE) {
    if (strong) plotlyPlot %>% plotly::config(displayModeBar = F, staticPlot = T)
    else plotlyPlot %>% plotly::config(displayModeBar = F)
  }
  
  output$plotHIV = renderPlotly({barplotepi() %>% reduceInteraction()})
  
  output$plotBIND = renderPlotly({bindersHIV() %>% reduceInteraction()})
  
  output$plotHLA = renderPlotly({hlafreqs() %>% reduceInteraction()})
  
  output$plotPROT_Pol = renderPlotly({makeBindersPlot(protFilter = "Pol") %>% reduceInteraction()})
  output$plotPROT_Gag = renderPlotly({makeBindersPlot(protFilter = "Gag") %>% reduceInteraction()})
  output$plotPROT_Vpu = renderPlotly({makeBindersPlot(protFilter = "Vpu") %>% reduceInteraction()})
  output$plotPROT_Asp = renderPlotly({makeBindersPlot(protFilter = "Asp") %>% reduceInteraction()})
  output$plotPROT_Env = renderPlotly({makeBindersPlot(protFilter = "Env") %>% reduceInteraction()})
  output$plotPROT_Tat = renderPlotly({makeBindersPlot(protFilter = "Tat") %>% reduceInteraction()})
  output$plotPROT_Rev = renderPlotly({makeBindersPlot(protFilter = "Rev") %>% reduceInteraction()})
  output$plotPROT_Nef = renderPlotly({makeBindersPlot(protFilter = "Nef") %>% reduceInteraction()})
  output$plotPROT_Vif = renderPlotly({makeBindersPlot(protFilter = "Vif") %>% reduceInteraction()})
  output$plotPROT_Vpr = renderPlotly({makeBindersPlot(protFilter = "Vpr") %>% reduceInteraction()})
  
  output
}
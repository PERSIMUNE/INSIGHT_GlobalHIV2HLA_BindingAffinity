handlePlotters = function(rv) {
  barplotepi <<- shiny::reactive({
    if (rv$country == "World") scope = "Global"
    else scope = paste0("Local (", rv$country, ")")
    (getSubtypeCountsByCountry() %>%
        ggplot2::ggplot(ggplot2::aes(x = subtype, y = patients))
      + ggplot2::geom_bar(stat="identity", fill = "#999999")
      + ggplot2::ggtitle(paste0(scope, " HIV subtypes sampled "))
      + ggplot2::ylab("Sample count")
      + ggplot2::theme_minimal()
      + ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 75), axis.title.x = ggplot2::element_blank())) %>%
        plotly::ggplotly(source = "hiv") %>% 
        plotly::layout(xaxis = list(fixedrange = TRUE), yaxis = list(fixedrange = TRUE))
  })
  
  bindersHIV <<- shiny::reactive({
    if (rv$country == "World") scope = "Global"
    else scope = paste0("Local (", rv$country, ")")
    (getHIVBindingSummaryProtein() %>%
        ggplot(aes(y = protein, fill = Binder))
      + ggplot2::geom_bar()
      + ggplot2::theme_minimal()
      + ggplot2::ylab("Proteins")
      + ggplot2::ggtitle(paste0(scope, " HLA binding in HIV"))
      + ggplot2::xlab("Number of peptides")
      + ggplot2::guides(fill = ggplot2::guide_legend(title="Binder activity"))
      + ggplot2::scale_fill_manual(values=c("#b2df8a", "#1f78b4", "#a6cee3"))
      + ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 25), axis.title.x = ggplot2::element_blank(), legend.title = element_blank())) %>%
        plotly::ggplotly(source = "bind") %>%
        plotly::layout(xaxis = list(fixedrange = TRUE), yaxis = list(fixedrange = TRUE), legend = list(orientation = "v", xanchor="right", yanchor="top"))
  })
  
  filterHLAFreqs = function(data, matchword) {
    if (matchword == "World") return (data)
    data %>% dplyr::filter(country == matchword)
  }
  
  hlafreqs <<- shiny::reactive({
    if (rv$country == "World") scope = "Global"
    else scope = paste0("Local (", rv$country, ")")
    betaWidth = length(getStats()$HLA %>% unique())
    (getStats() %>%
        separate(HLA, c("Locus", "Allele"), sep = "-", remove = FALSE) %>%
        filterHLAFreqs(rv$country) %>%
        ggplot(aes(x = HLA, y = n, fill = Locus))
      + ggplot2::geom_bar(stat = "identity", position = "dodge")
      + ggplot2::ggtitle(paste0(scope, " HLA imputation data"))
      + ggplot2::ylab("Carriers")
      + ggplot2::theme_minimal()
      + ggplot2::scale_fill_manual(values=c("#66c2a5", "#fc8d62", "#8da0cb"))
      + ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90), axis.title.x = ggplot2::element_blank(), legend.position = "none")) %>% 
      plotly::ggplotly(source = "hla") %>%
      plotly::layout(xaxis = list(fixedrange = TRUE), yaxis = list(fixedrange = TRUE))
  })
  
  makeBindersPlot <<- function(protFilter) {
    (getHIVBindingSummaryPosition() %>% dplyr::filter(Binder == "Endogenous", protein == protFilter) %>% 
       ggplot(aes(x = start, fill = Binder))
     + ggplot2::geom_bar()
     + ggplot2::ggtitle(protFilter)
     + ggplot2::ylab("Number of peptides bound")
     + ggplot2::xlab("Amino acid position in protein")
     + ggplot2::guides(fill=guide_legend(title="Binder to any HLA class I allele"))
     + ggplot2::theme_minimal()
     + ggplot2::scale_fill_manual(values=c("#b2df8a", "#1f78b4", "#a6cee3"))
     + ggplot2::theme(axis.text.x  = ggplot2::element_text(angle = 0),
                      panel.background = element_rect(fill = "#EDEDED", color = "#CCCCCC"),
                      panel.grid = element_line(color = "#CCCCCC", size = 0.75, linetype = 1),
                      #axis.title.x = ggplot2::element_blank(), axis.title.y = ggplot2::element_blank(),
                      legend.position = "none", panel.spacing = unit(1, "lines"))) %>% 
      ggplotly(source = paste0("hiv_",protFilter)) %>% 
      plotly::layout(xaxis = list(fixedrange = TRUE), yaxis = list(fixedrange = TRUE))
  }
}
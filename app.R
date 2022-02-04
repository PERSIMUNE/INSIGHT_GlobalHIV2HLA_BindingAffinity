use.credentials = FALSE

ui = shiny::shinyUI(
  source(file.path("R/internal","ui.R"), local = TRUE)
)$value %>% secure_ui(cred.require = use.credentials)

server = function(input, output, session) {
  auth = secure_server(session, cred.require = use.credentials)
  source(file.path("R/internal","server.R"), local = TRUE)
}

shinyApp(ui, server)
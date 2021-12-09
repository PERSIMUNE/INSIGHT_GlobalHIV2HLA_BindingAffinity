cred.background = "linear-gradient(rgba(0, 0, 255, 0.5), rgba(255, 255, 0, 0.5)), url('./capsid.png');"
cred.logo = shiny::img(src="./phi.wbcut.png", width=400)

secure_ui = function(ui, cred.require = TRUE) {
  if (!cred.require) return (ui)
  shinymanager::secure_app(ui, fab_position = "none", status = "default", tags_top = cred.logo, background = cred.background)
}

secure_server = function(session, cred.require = TRUE) {
  if (!cred.require) return (NULL)
  shinymanager::secure_server(
    check_credentials = shinymanager::check_credentials(data.frame(user = cred.user, password = cred.pass)),
    session = session
  )
}
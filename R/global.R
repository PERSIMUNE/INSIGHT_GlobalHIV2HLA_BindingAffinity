##> Global settings / options ----
#---------------------------------

mapdeck::set_token("pk.eyJ1IjoiY20zMTMiLCJhIjoiY2swOWM2anczMDZyOTNjcGVvc25wZDMwZCJ9.PvkS94DLQUviEjyz5U8E4Q")
bindTreeURL = "https://itol.embl.de/tree/1280729362561574949191"
options(shiny.port = 2000)

##> Global data ----
#-------------------

loading_screen = tagList(
  # Define contents of the loading screen
  waiter::spin_cube_grid(),
  h3("PERSIMUNE HEALTH INFORMATICS", style = "color:white;"),
  img(src = "./phi.wbcut.png", height = "400px")
)

##> JS Snippets ----
#-------------------

appDimensions =
  '$(document).on("shiny:connected", function(e) {
  var jsWidth = window.innerWidth;
  Shiny.onInputChange("appWidth",jsWidth);
  var jsHeight = window.innerHeight;
  Shiny.onInputChange("appHeight",jsHeight);
});'
appResize = 
  '$(window).resize(function(e) {
var jsWidth = window.innerWidth;
Shiny.onInputChange("appWidth",jsWidth);
var jsHeight = window.innerHeight;
Shiny.onInputChange("appHeight",jsHeight);
});
'
# launchHelpOnStart = '$(document).on("shiny:sessioninitialized", function(e) {
#   Shiny.setInputValue("btnShowHelp",1);
# });'
launchHelpOnStart = '$(document).on("shiny:sessioninitialized", function(e) {
  Shiny.setInputValue("sessionInitialized",1);
});'

##> Global helper functions ----
#-------------------------------

mySpinner = function(plt, type=7, color="#6A3677", size=0.5) {
  # Shorthand function to wrap UI with a loading spinner
  plt %>% shinycssloaders::withSpinner(type=type,color=color,size=size)
}

makeStateBtn = function(id, label, icon, color, top="auto", right="auto", bottom="auto", left="auto") {
  # Generate an absolutely positioned 'jelly' action button
  if (!is.null(icon)) icon = shiny::icon(icon)
  shiny::absolutePanel(
    id = "panel_trs0", class = "panel panel-default",
    fixed = TRUE, draggable = FALSE, width = 0, height = 0,
    top = top, left = left, right = right, bottom = bottom,
    shinyWidgets::actionBttn(id, label=label, style = "jelly", icon = icon, color=color)
  )
}

adjDim = function(dim, thresholds, weights, errMsg="") {
  # Helper to find whether dimension [dim] is above what threshold [thresholds <ordinal>] and to apply which weight [weights <ordinal>]
  index = Position(function(x) {dim >= x}, thresholds, right = TRUE)
  weight = weights[index]
  print (paste0('-->',errMsg))
  print (index)
  print (weight)
  print (dim * weight)
  round(dim * weight)
}

##> Global map functions ----
#----------------------------

draw_base_map = function() {
  # Instantiate the map
  mapdeck::mapdeck(
    style="mapbox://styles/mapbox/light-v10",
    zoom = 2.7667739695851616, width = 3121, height = 1630, location = c(15.48096230770054, 7.274204413626175),
    bearing = 0.5188981155850629, pitch = 36.24504876823693#, show_view_state = T
  )
}

update_map = function(mymap, selCountry, sf, colorby, showLegend) {
  # Update the map as user changes settings / interacts with it.
  
  m = mapdeck_update(map_id = mymap)
  
  if (is.null(showLegend)) return (m) #- required to not crash credentials
  
  sf %<>% mutate(stroke_color = "#FDFC01", stroke_width = 0, selected = "no")
  
  if (selCountry == "World") {
    sf$stroke_width = 25000
    sf$selected = "yes"
  }
  else {
    selectionFilter = sf$country == selCountry
    sf$stroke_width[selectionFilter] = 50000
    sf$selected[selectionFilter] = "yes"
  }
  
  if (showLegend) {showLegend = list(fill_colour = TRUE, stroke_colour = FALSE)}
  
  if (TRUE) {
    m %<>% 
      # clear any other layers besides this one
      clear_polygon( layer_id = "choropleth" ) %>%
      add_polygon(
        data = sf
        , layer_id = "choropleth"
        , fill_colour = colorby
        , fill_opacity = 200
        , auto_highlight = TRUE
        , tooltip = "name"
        , update_view = FALSE
        , stroke_colour = "stroke_color"
        , stroke_width = "stroke_width"
        , stroke_opacity = 1
        , legend = showLegend
      )
  } else { # 3d choropleth, not used but kept here to quickly implement if needed
    m %<>%
      clear_polygon( layer_id = "choropleth" ) %>%
      add_polygon(
        data = sf
        , layer_id = "choropleth"
        , fill_colour = colorby
        , fill_opacity = 200
        , auto_highlight = TRUE
        , elevation = colorby
        , tooltip = "name"
        , update_view = FALSE
        , legend = TRUE
        , legend_options = list(css = legend_height)
        , transitions = list(polygon = 250)
      )
  }
  m
}
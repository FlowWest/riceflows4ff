# map_tab_ui <- tabPanel(title= "Map")

shinyUI(
  tagList(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
      ),
    navbarPage(
      title = "riceflows4ff Dashboard",
      id = "tabs",
      collapsible = TRUE,
      tabPanel("Interactive Map",
        sidebarPanel(
          width = 3,
          tags$h2("Map Controls"),
          div(id = 'mapControls',
              radioButtons(
                "calculationButton",
                "Select rice field attribute to display:",
                c("Return Type" = "return",
                  "Distance" = "distance",
                  "Wet/Dry" = "wetdry",
                  "Invertebrate Mass" = "invmass"
                )
              ),
              conditionalPanel(id = "invmassControlPanel",
                condition = "input.calculationButton == 'invmass'",
                numericInput(
                  "inv_mass",
                  "Input the number of days to calculate the invertebrate mass production:",
                  1,
                  min = 1,
                  max = 100),
                actionButton('runButton' ,'Update Map')),
          ),
          div(id = 'filter_guidance', "Click a watershed, return point, or rice field to filter.", class="sidebar-message"),
          actionButton("resetButton", "Reset Map"),
          div(id = 'reset_guidance', "Click the map background to reset all filters.", style = "display: none;", class="sidebar-message"),
          div(id = 'loading_radio', "Loading data, please wait...", style = "display: none;", class="sidebar-message"),
        ),
        mainPanel(
          width = 9, # main width plus sidebar width should add to 12
          shinyjs::useShinyjs(),  # Initialize shinyjs
          shinycssloaders::withSpinner(leafletOutput("field_map"))
        ),
      ),
      tabPanel("Download Data",
               h2("Download Data"),
               div(class="download_item",
                   h3("Rice Field Geometries"),
                   p("Polygon geometries of rice fields based on statewide crop mapping."),
                   actionButton("info_fields", "More Info", onclick ="window.open('https://flowwest.github.io/riceflows4ff/reference/ff_fields.html', '_blank')"),
                   downloadButton("download_fields", "Rice Field Geometries (shp)", class="download_button"),
               ),
               div(class="download_item",
                   h3("Rice Field Flow Distances"),
                   p("Results of the FlowWest analysis of flow distances to the nearest fish-bearing stream."),
                   actionButton("info_distances", "More Info", onclick ="window.open('https://flowwest.github.io/riceflows4ff/reference/ff_distances.html', '_blank')"),
                   downloadButton("download_distances", "Rice Field Flow Distances (csv)", class="download_button"),
               ),
               div(class="download_item",
                   h3("Watersheds"),
                   p("Watershed polygons used to group rice fields and organize flow patterns"),
                   actionButton("info_watersheds", "More Info", onclick ="window.open('https://flowwest.github.io/riceflows4ff/reference/ff_watersheds.html', '_blank')"),
                   downloadButton("download_watersheds", "Watersheds (shp)", class="download_button"),
               ),
               div(class="download_item",
                   h3("Return Points"),
                   p("Point locations of outlets for return flow from rice field drainage networks into adjacent canals or streams"),
                   actionButton("info_returns", "More Info", onclick ="window.open('https://flowwest.github.io/riceflows4ff/reference/ff_returns.html', '_blank')"),
                   downloadButton("download_returns", "Return Points (shp)", class="download_button"),
               ),
               div(class="download_item",
                   h3("Salmonid Rearing Streams"),
                   p("Salmonid rearing streams used to calculate flow distances."),
                   actionButton("info_streams", "More Info", onclick ="window.open('https://flowwest.github.io/riceflows4ff/reference/ff_streams.html', '_blank')"),
                   downloadButton("download_streams", "Salmonid Rearing Streams (shp)", class="download_button"),
               ),
               div(class="download_item",
                   h3("Secondary Canals"),
                   p("Non-rearing streams and canals used to calculate the flow distances from indirect return points to their nearest fish-bearing stream"),
                   actionButton("info_canals", "More Info", onclick ="window.open('https://flowwest.github.io/riceflows4ff/reference/ff_canals.html', '_blank')"),
                   downloadButton("download_canals", "Secondary Canals (shp)", class="download_button"),
               ),
               div(class="download_item",
                   h3("Wet/Dry Sides"),
                   p("Polygons identifying which parts of the Sacramento Valley are behind levees (dry) or directly exposed to rivers or floodways (wet)"),
                   actionButton("info_wetdry", "More Info", onclick ="window.open('https://flowwest.github.io/riceflows4ff/reference/ff_wetdry.html', '_blank')"),
                   downloadButton("download_wetdry", "Wet/Dry Sides (shp)", class="download_button"),
               ),
               div(class="download_item",
                   h3("Project Boundary"),
                   p("Study area of the rice field drainage analysis."),
                   actionButton("info_aoi", "More Info", onclick ="window.open('https://flowwest.github.io/riceflows4ff/reference/ff_aoi.html', '_blank')"),
                   downloadButton("download_aoi", "Project Boundary (shp)", class="download_button"),
               ),
      )
    )
  )
)

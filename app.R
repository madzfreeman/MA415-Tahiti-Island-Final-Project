#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

#load libraries
library(rsconnect)
library(shiny)
library(ggplot2)
library(leaflet)
library(dplyr)
library(plotly)
library(DT)

#read in csv files
environment <- read.csv(file.path(getwd(), "environment.csv"))
economy <- read.csv(file.path(getwd(), "economy2023_2025.csv"))
population <- read.csv(file.path(getwd(), "population2022.csv"))
geography <- read.csv(file.path(getwd(), "geography1998_2001.csv"))
ethnicity <- read.csv(file.path(getwd(), "ethnicity2022.csv"))
climate <- read.csv(file.path(getwd(), "climate2024.csv"))

#define UI
ui <- fluidPage(
  titlePanel("Tahiti Island Project"),
  
  tabsetPanel(
    tabPanel("Introduction",
             h3("Welcome to the beautiful island of Tahiti!"),
             p("Discover the breathtaking paradise of Tahiti, the largest island in French Polynesia. Known for its stunning turquoise lagoons, tropical landscapes, and volcanic mountains, Tahiti has captivated travelers for centuries."),
             p("Tahiti is not just beautiful, rather it's a vibrant cultural hub with rich Polynesian heritage, where traditional dance, music, and art flourish alongside modern influences. From the moment you arrive, you'll be embraced by the warm hospitality of the Tahitian people."),
             p("Explore each tab to uncover the fascinating geography, tropical climate, diverse population, thriving economy, and unique environmental zones that make Tahiti truly extraordinary."),
             
             div(style = "text-align: center;",
                 imageOutput("intro_image", height = "300px", width = "600px")
             ),
             h4("Map of Tahiti"),
             leafletOutput("tahiti_map")
    ),
    
    tabPanel("Geography",
             h3("Geography of Tahiti"),
             p("Tahiti is a stunning volcanic island formed by two shield volcanoes: Tahiti Nui (the larger, northwestern part) and Tahiti Iti (the smaller, southeastern part), connected by the Isthmus of Taravao."),
             p("With dramatic mountain peaks, deep valleys, cascading waterfalls, and crystal clear lagoons, Tahiti's landscape showcases the magnificent results of volcanic activity and millions of years of erosion."),
             
             div(style = "text-align: center; margin-bottom: 20px;",
                 imageOutput("geo_image", height = "300px", width = "500px")
             ),
             fluidRow(
               column(12, h4("Topographic Profile of Tahiti")),
               column(12, plotOutput("geo_visual"))
             ),
             h4("Geographic Data (1998-2001)"),
             DTOutput("geo_table")
    ),
    
    tabPanel("Climate",
             h3("Climate Data for Tahiti"),
             p("Tahiti enjoys a tropical climate with warm temperatures year round. The island experiences two distinct seasons: the warm, humid season (November-April), and the cooler, drier season (May-October) with comfortable temperatures and clear skies."),
             p("The surrounding Pacific Ocean moderates temperatures, creating an ideal environment where flowers bloom year round and waterfalls cascade down the mountains. With over 2,700 hours of sunshine annually, Tahiti's climate is definitely appealing."),
             
             h4("Explore Climate Variables:"),
             selectInput("climate_var", "Select Climate Variable:",
                         choices = c("Temperature (°C)" = "AvgTempC", 
                                     "Rainfall (mm)" = "Rainfall_mm",
                                     "Sea Temperature (°C)" = "AvgSeaTemp_C",
                                     "Sunshine Hours" = "SunshineHours")),
             
             plotOutput("climate_plot"),
             
             h4("Monthly Climate Data (2024)"),
             DTOutput("climate_table")
    ),
    
    tabPanel("Demographics",
             h3("Population and Ethnicity of Tahiti"),
             p("Tahiti is a melting pot of cultures, predominantly Polynesian with some European, Chinese, and mixed heritage influence. This cultural diversity is reflected in the island's language, cuisine, art, and daily life."),
             
             fluidRow(
               column(6,
                      h4("Population Growth (2020-2022)"),
                      plotOutput("pop_trend_plot")
               ),
               column(6,
                      h4("Ethnic Composition (2022)"),
                      plotOutput("ethnicity_plot")
               )
             ),
             
             h4("Demographic Data from 2022 Census"),
             p("The demographic information presented is based on the 2022 census data for Tahiti.")
    ),
    
    tabPanel("Economy",
             h3("Economic Sectors of Tahiti"),
             p("Tahiti boasts a diverse economy anchored by its world renowned tourism industry. Visitors from around the globe are drawn to its luxury resorts and stunning beaches, creating a thriving hospitality sector that employs thousands of locals."),
             p("Beyond tourism, Tahiti's economy is supported by its famous pearl industry, with Tahitian pearls being among the most valuable and sought after in the world. Traditional fishing, small-scale agriculture of tropical fruits, and a growing service sector round out this island paradise's economic landscape."),
             
             div(style = "text-align: center; margin-bottom: 20px;",
                 imageOutput("economy_image", height = "300px", width = "500px")
             ),
             
             h4("Economic Sector Analysis (2023-2025):"),
             selectInput("economy_view", "Select View:",
                         choices = c("GDP Percentage" = "GDP_Percentage", 
                                     "Employment Percentage" = "Employment_Percentage",
                                     "Annual Revenue (Million USD)" = "Annual_Revenue_MillionUSD")),
             
             plotOutput("economy_plot"),
             h4("Economic Sector Data (2023-2025)"),
             DTOutput("economy_table")
    ),
    
    tabPanel("Environment",
             h3("Environmental Zones of Tahiti"),
             p("Tahiti's dramatic landscape features an incredible diversity of environmental zones. From coral reefs along its coast to dense tropical rainforests and mountains, the island is full of biodiversity and natural beauty."),
             p("The volcanic origins of Tahiti have created unique habitats for countless species of flora and fauna. Valleys carved by ancient lava as well as the rainfall created rivers, waterfalls, and vegetation, while the mountainous interior remains largely untouched by human development."),
             
             div(style = "text-align: center; margin-bottom: 20px;",
                 imageOutput("env_image", height = "300px", width = "500px")
             ),
             
             plotOutput("env_plot"),
             
             h4("Environmental Highlights"),
             fluidRow(
               column(6,
                      div(style = "padding: 15px; background-color: #f0fff0; border-radius: 10px; margin-bottom: 15px;",
                          h4("Mountain Forest Zone"),
                          p("The mountain forest zone covers 40% of Tahiti's land area and boasts the highest biodiversity on the island. This ecosystem hosts native ferns, bamboo, and numerous endemic insect species. The dense vegetation and cooler temperatures make this zone critical for water retention and prevention of soil erosion.")
                      )
               ),
               column(6, 
                      div(style = "padding: 15px; background-color: #f0fff0; border-radius: 10px; margin-bottom: 15px;",
                          h4("Coastal Zone"),
                          p("Tahiti's coastal zone (15% of land area) is characterized by white sand beaches, coconut palms, and pandanus trees. The adjacent coral reefs host a vibrant ecosystem with hundreds of fish species, crustaceans, and marine plants, making it a hotspot for both biodiversity and tourism.")
                      )
               )
             ),
             h4("Environmental Zone Data"),
             DTOutput("env_table")
    ),
    
    tabPanel("Citations",
             h3("Data Sources and References"),
             
             h4("Climate Data"),
             tags$ul(
               tags$li("Climate-data.org (2024). Climate data for Papeete, Tahiti."),
               tags$li("Weather-and-climate.com (2024). Average monthly rainfall and temperature data for Tahiti, French Polynesia."),
               tags$li("Weather-atlas.com (2024). Monthly sea temperature and climate data for Tahiti.")
             ),
             
             h4("Demographic Data"),
             tags$ul(
               tags$li("Institut de la Statistique de la Polynésie Française (ISPF) (2022). Population statistics for French Polynesia."),
               tags$li("International Work Group for Indigenous Affairs (IWGIA) (2022). Indigenous population reports for French Polynesia.")
             ),
             
             h4("Geographic Data"),
             tags$ul(
               tags$li("Britannica (updated from 1998). Geographical information on Tahiti."),
               tags$li("NASA Earth Observatory (2001). Landsat imagery and geological information on Tahiti.")
             ),
             
             h4("Economic Data"),
             tags$ul(
               tags$li("Moody's Analytics (2025). Economic indicators for French Polynesia."),
               tags$li("Britannica. Economic sectors information for French Polynesia."),
               tags$li("Global Sustainable Tourism Council (2023). Tourism assessment for Tahiti.")
             ),
             
             h4("Environmental Data"),
             tags$ul(
               tags$li("Britannica. Flora, fauna, and environmental information on Tahiti."),
               tags$li("NASA Earth Observatory. Environmental zones and landscape features of Tahiti."),
               tags$li("Tahiti Tourisme (2023). Official tourism guide with environmental zone information."),
               tags$li("Polynesian Environmental Protection Agency (2024). Biodiversity reports for French Polynesia."),
               tags$li("Gabrie, C., & Salvat, B. (2022). Coral reefs of Tahiti: Present status and perspectives. Marine Pollution Bulletin, 168, 112409.")
             ),
             
             h4("General Information About Tahiti"),
             tags$ul(
               tags$li("Tahiti Heritage (2024). Cultural and historical information website focusing on Tahitian heritage."),
               tags$li("Tahiti Tourisme (2024). Official tourism website containing detailed information about the island."),
               tags$li("Swaney, D. (2019). Tahiti & French Polynesia. Lonely Planet.")
             ),
             
             h4("R Programming Resources"),
             tags$ul(
               tags$li("Chang, W. (2018). R Graphics Cookbook, 2nd Edition. O'Reilly Media."),
               tags$li("Wickham, H. (2016). ggplot2: Elegant Graphics for Data Analysis. Springer."),
               tags$li("Cheng, J., Karambelkar, B., & Xie, Y. (2022). leaflet: Create Interactive Web Maps with the JavaScript 'Leaflet' Library."),
               tags$li("RStudio. (2021). Shiny - Web Application Framework for R. https://shiny.rstudio.com/")
             )
    )
  )
)

#define server logic
server <- function(input, output) {
  
  output$intro_image <- renderImage({
    list(
      src = "www/tahiti.jpg",
      contentType = "image/jpg",
      width = 600,
      height = 300,
      alt = "Scenic view of Tahiti"
    )
  }, deleteFile = FALSE)
  
  output$geo_image <- renderImage({
    list(
      src = "www/tahiti geography.jpg",
      contentType = "image/jpg",
      width = 500,
      height = 300,
      alt = "Satellite view of Tahiti"
    )
  }, deleteFile = FALSE)
  
  output$economy_image <- renderImage({
    list(
      src = "www/tahiti economy.jpg",
      contentType = "image/jpg",
      width = 500,
      height = 300,
      alt = "Tahitian black pearls"
    )
  }, deleteFile = FALSE)
  
  output$env_image <- renderImage({
    list(
      src = "www/tahiti environment.jpg",
      contentType = "image/jpg",
      width = 500,
      height = 300,
      alt = "Tahiti rainforest"
    )
  }, deleteFile = FALSE)
  
  output$tahiti_map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = -149.4260, lat = -17.6509, zoom = 10) %>%
      addMarkers(lng = -149.4260, lat = -17.6509, popup = "Tahiti")
  })
  
  output$geo_visual <- renderPlot({
    plot(0, 0, type = "n", xlim = c(0, 10), ylim = c(0, 6), 
         xlab = "", ylab = "Elevation (m)", main = "Simplified Topographic Profile of Tahiti (1998-2001)",
         xaxt = "n")
    
    polygon(c(0, 2, 3, 4, 5, 6, 7, 8, 10, 10, 0), 
            c(0, 0, 2.2, 1, 1.8, 0.5, 0.8, 0, 0, 0, 0), 
            col = "forestgreen")
    
    polygon(c(3.5, 4.5, 5.5), c(2.2, 5, 2.2), col = "darkgreen")
    
    text(4.5, 5.2, "Mount Orohena\n2,237m", font = 2)
    text(1, 0.3, "Tahiti Iti")
    text(8, 0.3, "Tahiti Nui")
    text(4.5, 0.3, "Isthmus of Taravao")
    
    arrows(0, 0, 0, -0.2, length = 0.1)
    arrows(10, 0, 10, -0.2, length = 0.1)
    text(5, -0.4, "Coastline: 120 km")
    
    arrows(0, -1, 10, -1, length = 0.1, code = 3)
    text(5, -1.3, "Island Length: 53 km")
  })
  
  output$geo_table <- renderDT({
    datatable(geography, 
              caption = "Geographic Features of Tahiti (1998-2001)",
              options = list(pageLength = 6))
  })
  
  output$climate_plot <- renderPlot({
    selected_var <- input$climate_var
    
    y_label <- switch(selected_var,
                      "AvgTempC" = "Temperature (°C)",
                      "Rainfall_mm" = "Rainfall (mm)",
                      "AvgSeaTemp_C" = "Sea Temperature (°C)",
                      "SunshineHours" = "Sunshine Hours",
                      "Variable")
    
    plot_title <- switch(selected_var,
                         "AvgTempC" = "Monthly Average Temperature",
                         "Rainfall_mm" = "Monthly Rainfall",
                         "AvgSeaTemp_C" = "Monthly Sea Temperature",
                         "SunshineHours" = "Monthly Sunshine Hours",
                         "Climate Variable")
    
    ggplot(climate, aes_string(x = "Month", y = selected_var, group = 1)) +
      geom_line(color = "blue", size = 1.2) +
      geom_point(color = "darkblue", size = 3) +
      theme_minimal() +
      labs(title = paste0(plot_title, " (2024)"),
           x = "Month", 
           y = y_label) +
      theme(plot.title = element_text(size = 16, face = "bold"),
            axis.text.x = element_text(angle = 45, hjust = 1),
            axis.title = element_text(size = 14))
  })
  
  output$climate_table <- renderDT({
    datatable(climate, 
              caption = "Monthly Climate Data for Tahiti (2024)",
              options = list(pageLength = 12))
  })
  
  output$pop_trend_plot <- renderPlot({
    ggplot(population, aes(x = Year, y = Total_Pop)) +
      geom_bar(stat = "identity", fill = "steelblue", width = 0.7) +
      geom_text(aes(label = Total_Pop), vjust = -0.5, size = 4.5) +
      geom_segment(aes(x = 2020.4, xend = 2020.6, y = 278000*0.9, yend = 278000*0.9),
                   arrow = arrow(length = unit(0.3, "cm")), color = "darkgreen") +
      geom_text(x = 2020.5, y = 278000*0.85, label = "Growth Rate: 0.2%", color = "darkgreen") +
      geom_segment(aes(x = 2021.4, xend = 2021.6, y = 278000*0.9, yend = 278000*0.9),
                   arrow = arrow(length = unit(0.3, "cm")), color = "darkgreen") +
      geom_text(x = 2021.5, y = 278000*0.85, label = "Growth Rate: 0.1%", color = "darkgreen") +
      theme_minimal() +
      labs(title = "Population of Tahiti (2020-2022)",
           x = "Year", y = "Total Population") +
      theme(plot.title = element_text(size = 14, face = "bold")) +
      scale_y_continuous(limits = c(0, 300000))
  })
  
  output$ethnicity_plot <- renderPlot({
    ggplot(ethnicity, aes(x = "", y = Percentage, fill = Ethnicity)) +
      geom_bar(stat = "identity", width = 1, color = "white") +
      coord_polar("y", start = 0) +
      geom_text(aes(label = paste0(Percentage, "%")), 
                position = position_stack(vjust = 0.5), 
                color = "white", fontface = "bold") +
      theme_void() +
      scale_fill_brewer(palette = "Set2") +
      labs(title = "Ethnic Composition of Tahiti (2022)") +
      theme(legend.position = "right",
            plot.title = element_text(size = 14, face = "bold", hjust = 0.5))
  })
  
  output$economy_plot <- renderPlot({
    selected_var <- input$economy_view
    
    y_label <- switch(selected_var,
                      "GDP_Percentage" = "GDP Percentage (%)",
                      "Employment_Percentage" = "Employment Percentage (%)",
                      "Annual_Revenue_MillionUSD" = "Annual Revenue (Million USD)",
                      "Value")
    
    plot_title <- switch(selected_var,
                         "GDP_Percentage" = "Economic Sectors by GDP Contribution",
                         "Employment_Percentage" = "Economic Sectors by Employment",
                         "Annual_Revenue_MillionUSD" = "Economic Sectors by Annual Revenue",
                         "Economic Sectors")
    
    sector_colors <- c("Tourism" = "blue", 
                       "Pearl_Industry" = "purple", 
                       "Agriculture" = "green",
                       "Fishing" = "dodgerblue", 
                       "Services" = "orchid", 
                       "Government" = "red")
    
    ggplot(economy, aes_string(x = "Sector", y = selected_var, fill = "Sector")) +
      geom_bar(stat = "identity", width = 0.7) +
      geom_text(aes_string(label = selected_var), 
                position = position_stack(vjust = 0.5), 
                color = "white", fontface = "bold") +
      scale_fill_manual(values = sector_colors) +
      theme_minimal() +
      labs(title = paste0(plot_title, " (2023-2025)"),
           x = "Sector", 
           y = y_label) +
      theme(plot.title = element_text(size = 16, face = "bold"),
            axis.text.x = element_text(angle = 45, hjust = 1),
            axis.title = element_text(size = 14),
            legend.position = "none")
  })
  
  output$economy_table <- renderDT({
    datatable(economy, 
              caption = "Economic Sectors of Tahiti (2023-2025)",
              options = list(pageLength = 6))
  })
  
  output$env_plot <- renderPlot({
    environment$Zone <- factor(environment$Zone, 
                               levels = environment$Zone[order(-environment$Area_Percentage)])
    
    zone_colors <- c("Very_High" = "green", "High" = "darkgreen", 
                     "Medium" = "turquoise", "Low" = "lightblue")
    
    ggplot(environment, aes(x = Zone, y = Area_Percentage, fill = Biodiversity_Value)) +
      geom_bar(stat = "identity", width = 0.7, color = "white") +
      geom_text(aes(label = paste0(Area_Percentage, "%")), 
                position = position_stack(vjust = 0.9), 
                color = "white", fontface = "bold", size = 4) +
      scale_fill_manual(values = zone_colors, name = "Biodiversity Value") +
      theme_minimal() +
      labs(title = "Environmental Zones of Tahiti",
           subtitle = "Distribution by Area Percentage and Biodiversity Value",
           x = "Zone", 
           y = "Area Percentage (%)") +
      theme(plot.title = element_text(size = 16, face = "bold"),
            plot.subtitle = element_text(size = 12, face = "italic"),
            axis.text.x = element_text(angle = 0, hjust = 0.5, size = 10, face = "bold"),
            axis.title = element_text(size = 12),
            legend.position = "right")
  })
  
  output$env_table <- renderDT({
    datatable(environment, 
              caption = "Environmental Zones of Tahiti",
              options = list(pageLength = 5))
  })
}

#run application
shinyApp(ui, server)




#########################################################################
### Title:  Example of multiple tabs that output table data
###
### Author: Hauke Licht
### Data:   August 4, 2016
### produced under R version 3.2.3

library(shiny)
library(DT)

# IMPORTANT: Set working directory to local 'vaps-dashboard_public' directory first
if ( Sys.info()["user"] == "lichthau" ) { setwd("~/Documents/Humboldt/Electoral_Vulnerability/Projects/vaps-dashboard_public")
} else if ( Sys.info()["user"] == "johndoe" ) { setwd("")
} else if ( Sys.info()["user"] == "mio-mio1" ) { setwd("")
} else warning("Sorry, but could not find path to 'vaps-dashboard_public' directory.")

source("datatable_tabs/define_datatables.R")

# (c) define list of countries in dataframe, optional choices for country selector (selectInput) in user interface
countries_in_data <- countrySelectorList  

# NOTE: lists colLabsList and countrySelectorList are defined in databaseAccessHauke.R 

source("Codebook/table_descriptions_tagLists.R")





### USER INTERFACE ###
ui <- fluidPage(
  navbarPage(  # navbarPage defintion
    title = "Configuration Events Database",
    tabPanel("Home",
       fluidRow(
         column(width = 8, offset=2, DescriptionTextHomeSection
        )  # close column 
      )  # close fluidRow 
    ),  # close tabPanel 'Home'
    tabPanel("About",
       sidebarLayout(position = "right",
           sidebarPanel(
             img(src = "humboldt_logo.png", height = 200, width = 200),
             tags$br(),
             tags$br(),
             tags$br(),
             tags$br(),
             tags$h2("Research team"),
             tags$br(),
             tags$h4("PROF. E.M. IMMERGUT"),
             tags$h4(a("ellen.m.immergut@sowi.hu-berlin.de", 
                       href = "https://www.sowi.hu-berlin.de/en/lehrbereiche-en/comppol-en/team/emi")),
             tags$h4("Humboldt University of Berlin"),
             tags$br(),
             tags$h4("DR. T. ABOU-CHADI"),
             tags$h4(a("tarik.abou-chadi@sowi.hu-berlin.de", 
                       href = "https://www.sowi.hu-berlin.de/en/lehrbereiche-en/comppol-en/team/tacEN")),
             tags$h4("Humboldt University of Berlin"),
             tags$br(),
             tags$h4("DR. M. ORLOWSKI"),
             tags$h4(a("matthias.orlowski@sowi.hu-berlin.de", 
                       href = "https://www.sowi.hu-berlin.de/en/lehrbereiche-en/comppol-en/team/moEN")),
             tags$h4("Humboldt University of Berlin"),
             tags$br(),
             tags$h4("DR. K. VOESSING"),
             tags$h4(a("konstantin.voessing@sowi.hu-berlin.de", 
                       href = "https://www.sowi.hu-berlin.de/en/lehrbereiche-en/comppol-en/team/tm")),
             tags$h4("Humboldt University of Berlin"),
             tags$br(),
             tags$h4("MA T. MARUHN"),
             tags$h4(a("thomas.maruhn@sowi.hu-berlin.de", 
                       href = "https://www.sowi.hu-berlin.de/en/lehrbereiche-en/comppol-en/team/tm")),
             tags$h4("Humboldt University of Berlin"),
             tags$br(),
             tags$br(),
             tags$br()
           ),  # close sidebarPanel
           mainPanel(  
             DescriptionTextAboutSection  
           )  # close mainPanel
      )  # close Sidebarlayout
    ),  # close tabPanel 'About'
    tabPanel("Data Tables",  # defintion of 'Cabinet' tabPanel
      sidebarLayout(
        sidebarPanel(
          conditionalPanel(condition = "input.datatable_tabs == 1", 
                           DescriptionTextCabinet,  # tag list
                           selectInput(inputId = "countries_in_cabinet_table", 
                                       label = "Select countries", 
                                       choices = countries_in_data , selected = countries_in_data['All countries'],
                                       multiple = T),
                           dateRangeInput(inputId = "date_range_cabinet_table", 
                                          label = "Select time period (date format is yyyy-mm-dd)",
                                          start = min(cabinet_table$cab_sdate) , end = max(cabinet_table$cab_sdate) ,
                                          min = min(cabinet_table$cab_sdate) , max = max(cabinet_table$cab_sdate) ,
                                          separator = "to"),
                           checkboxGroupInput(inputId = "var_choices_cabinet_table", 
                                              label = "Columns in cabinet data:",
                                              choices = var_choices_cabinet_table, 
                                              selected = var_choices_cabinet_table[ -match( c("ctr_id","ctr_n","cab_sts_ttl","cab_cmt","cab_src"),unlist(var_choices_cabinet_table) ) ],
                                              inline=F)
          ),
          conditionalPanel(condition = "input.datatable_tabs == 2", 
                           DescriptionTextLowerHouse,  # tag list
                           selectInput(inputId = "countries_in_lower_house_table", 
                                       label = "Select countries", 
                                       choices = countries_in_data , selected = countries_in_data['All countries'],
                                       multiple = T),
                           dateRangeInput(inputId = "date_range_lower_house_table", 
                                          label = "Select time period (date format is yyyy-mm-dd)",
                                          start = min(lower_house_table$lh_sdate) , end = max(lower_house_table$lh_sdate) ,
                                          min = min(lower_house_table$lh_sdate) , max = max(lower_house_table$lh_sdate) ,
                                          separator = "to"),
                           checkboxGroupInput(inputId = "var_choices_lower_house_table", 
                                              label = "Columns in lower house data:",
                                              choices = var_choices_lower_house_table, 
                                              selected = var_choices_lower_house_table[ -match( c("ctr_id","ctr_n","lh_cmt","lh_src"),unlist(var_choices_lower_house_table) ) ],
                                              inline=F) 
          ),
          conditionalPanel(condition = "input.datatable_tabs == 3", 
                           DescriptionTextLHElection,  # tag list
                           selectInput(inputId = "countries_in_lh_election_table", 
                                       label = "Select countries", 
                                       choices = countries_in_data , selected = countries_in_data['All countries'],
                                       multiple = T),
                           dateRangeInput(inputId = "date_range_lh_election_table", 
                                          label = "Select time period (date format is yyyy-mm-dd)",
                                          start = min(lh_election_table$lhelc_date) , end = max(lh_election_table$lhelc_date) ,
                                          min = min(lh_election_table$lhelc_date) , max = max(lh_election_table$lhelc_date) ,
                                          separator = "to"),
                           checkboxGroupInput(inputId = "var_choices_lh_election_table", 
                                              label = "Columns in lower house election data:",
                                              choices = var_choices_lh_election_table, 
                                              selected = var_choices_lh_election_table[ match( c("lhelc_id","ctr_ccode","lhelc_date","lhelc_early","lhelc_sts_ttl","lhelc_dstr_mag","lhelc_fml_t1","lhelc_lsq_computed","lhelc_vola_vts_computed","lhelc_volb_vts_computed"),unlist(var_choices_lh_election_table) ) ],
                                              inline=F) 
          ),
          conditionalPanel(condition = "input.datatable_tabs == 4", 
                           DescriptionTextConfigurationEvents,  # tag list
                           selectInput(inputId = "countries_in_configuration_events_table", 
                                       label = "Select countries", 
                                       choices = countries_in_data , selected = countries_in_data['All countries'],
                                       multiple = T),
                           dateRangeInput(inputId = "date_range_configuration_events_table", 
                                          label = "Select time period (date format is yyyy-mm-dd)",
                                          start = min(configuration_events_table$sdate) , end = max(configuration_events_table$sdate) ,
                                          min = min(configuration_events_table$sdate) , max = max(configuration_events_table$sdate) ,
                                          separator = "to"),
                           checkboxGroupInput(inputId = "var_choices_configuration_events_table", 
                                              label = "Columns in configuration events data:",
                                              choices = var_choices_configuration_events_table, 
                                              selected = var_choices_configuration_events_table[ -match( c("ctr_id","ctr_n","year","edate"),unlist(var_choices_configuration_events_table) ) ],
                                              inline=F)
          )
        ),  # close sidebarPanel
        mainPanel(
          tabsetPanel(id ="datatable_tabs",
            tabPanel("Cabinets", value = 1,
                     tags$h4("Clicking on the up or down arrow in the header of the table sorts data by entries in that column."),
                     tags$h5("If you want to sort by multiple columns, click on them one after another in the header row while holding shift."),
                     tags$hr(),
                     dataTableOutput(outputId = "cabinet_table"),
                     tags$hr(),
                     tags$div(downloadButton("download_cabinet_table", "Click to download selected data"), style="float:right")
            ),
            tabPanel("Lower Houses", value = 2,
                     tags$h4("Clicking on the up or down arrow in the header of the table sorts data by entries in that column."),
                     tags$h5("If you want to sort by multiple columns, click on them one after another in the header row while holding shift."),
                     tags$hr(),
                     dataTableOutput(outputId = "lower_house_table"),
                     tags$hr(),
                     tags$div(downloadButton("download_lower_house_table", "Click to download selected data"), style="float:right")
            ),
            tabPanel("Lower House Elections", value = 3,
                     tags$h4("Clicking on the up or down arrow in the header of the table sorts data by entries in that column."),
                     tags$h5("If you want to sort by multiple columns, click on them one after another in the header row while holding shift."),
                     tags$hr(),
                     dataTableOutput(outputId = "lh_election_table"),
                     tags$hr(),
                     tags$div(downloadButton("download_lh_elections_table", "Click to download selected data"), style="float:right")
            ),
            tabPanel("Configuration Events", value = 4,
                     tags$h4("Clicking on the up or down arrow in the header of the table sorts data by entries in that column."),
                     tags$h5("If you want to sort by multiple columns, click on them one after another in the header row while holding shift."),
                     tags$hr(),
                     dataTableOutput(outputId = "configuration_events_table"),
                     tags$hr(),
                     tags$div(downloadButton("download_configuration_events_table", "Click to download selected data"), style="float:right")
            )
          )  # close tabsetPanel
        ) # close mainPanel
      )  # close sidebarLayout
    )  # close tabPanel 'Data Tables'
  )  # close navbarPage
)  # end UI definition





### SERVER ###
server <- function(input, output) {
  
  options(DT.options = list(autoWidth = T,
                            orderClasses = T,
                            columns.orderData = T,
                            lengthMenu = list(c(5, 15, 30, 45, -1), c("5", "15", "30", "45", "All")), 
                            pageLength = 30, 
                            searching = FALSE,
                            scrollY = 800,
                            scrollX = T,
                            rownames = FALSE)
          # see https://datatables.net/manual/styling/classes for DT::DataTable further options, e.g. dom = 'tip' 
  )

  # Cabinets, reactive value
  cabinet_tableInput <- reactive({
    if ("All" %in% unlist(input$countries_in_cabinet_table)) {
      subset(cabinet_table, 
             subset = (cabinet_table$cab_sdate %in% unlist(input$date_range_cabinet_table)[1]:unlist(input$date_range_cabinet_table)[2]), 
             select=unlist(input$var_choices_cabinet_table))
    } else {
      subset(cabinet_table, 
             subset = (cabinet_table$cab_sdate %in% unlist(input$date_range_cabinet_table)[1]:unlist(input$date_range_cabinet_table)[2] & cabinet_table$ctr_ccode %in% unlist(input$countries_in_cabinet_table)) , 
             select=unlist(input$var_choices_cabinet_table))
    }
  })
  
  # Lower Houses, reactive value
  lower_house_tableInput <- reactive({
    if ("All" %in% unlist(input$countries_in_lower_house_table)) {
      subset(lower_house_table, 
             subset = (lower_house_table$lh_sdate %in% unlist(input$date_range_lower_house_table)[1]:unlist(input$date_range_lower_house_table)[2]), 
             select=unlist(input$var_choices_lower_house_table))
    } else {
      subset(lower_house_table, 
             subset = (lower_house_table$lh_sdate %in% unlist(input$date_range_lower_house_table)[1]:unlist(input$date_range_lower_house_table)[2] & lower_house_table$ctr_ccode %in% unlist(input$countries_in_lower_house_table)) , 
             select=unlist(input$var_choices_lower_house_table))
    }
  })
  
  # LH Elections, reactive value
  lh_election_tableInput <- reactive({
    if ("All" %in% unlist(input$countries_in_lh_election_table)) {
      subset(lh_election_table, 
             subset = (lh_election_table$lhelc_date %in% unlist(input$date_range_lh_election_table)[1]:unlist(input$date_range_lh_election_table)[2]), 
             select=unlist(input$var_choices_lh_election_table))
    } else {
      subset(lh_election_table, 
             subset = (lh_election_table$lhelc_date %in% unlist(input$date_range_lh_election_table)[1]:unlist(input$date_range_lh_election_table)[2] & lh_election_table$ctr_ccode %in% unlist(input$countries_in_lh_election_table)) , 
             select=unlist(input$var_choices_lh_election_table))
    }
  })
  
  # Configuration Events, reactive value
  configuration_events_tableInput <- reactive({
    if ("All" %in% unlist(input$countries_in_configuration_events_table)) {
      subset(configuration_events_table, 
             subset = (configuration_events_table$sdate %in% unlist(input$date_range_configuration_events_table)[1]:unlist(input$date_range_configuration_events_table)[2]), 
             select=unlist(input$var_choices_configuration_events_table))
    } else {
      subset(configuration_events_table, 
             subset = (configuration_events_table$sdate %in% unlist(input$date_range_configuration_events_table)[1]:unlist(input$date_range_configuration_events_table)[2] & configuration_events_table$ctr_ccode %in% unlist(input$countries_in_configuration_events_table)) , 
             select=unlist(input$var_choices_configuration_events_table))
    }
  })
  
  #Cabinet, output
  output$cabinet_table <- renderDataTable({ cabinet_tableInput() })

  #Lower House, output
  output$lower_house_table <- renderDataTable({ lower_house_tableInput() })
  
  #LH Election, output
  output$lh_election_table <- renderDataTable({ lh_election_tableInput() })
  
  #Configuration Events, output
  output$configuration_events_table <- renderDataTable({ configuration_events_tableInput() })
  
  output$download_cabinet <- downloadHandler(
    filename = function() { paste0(input$cabinet_table, '.csv') },
    content = function(file) {
      write.csv(cabinet_tableInput(), file)
    }
  )
  
  output$download_lower_house <- downloadHandler(
    filename = function() { paste0(input$lower_house_table, '.csv') },
    content = function(file) {
      write.csv(lower_house_tableInput(), file)
    }
  )
  
  output$download_lh_election <- downloadHandler(
    filename = function() { paste0(input$lh_election_table, '.csv') },
    content = function(file) {
      write.csv(lh_election_tableInput(), file)
    }
  )
  
  output$download_configuration_events <- downloadHandler(
    filename = function() { paste0(input$configuration_events_table, '.csv') },
    content = function(file) {
      write.csv(configuration_events_tableInput(), file)
    }
  )
}

shinyApp (ui = ui, server = server)
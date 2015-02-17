library(shiny)
library(forecast)



source("auction.R")

shinyUI(pageWithSidebar(
  headerPanel(span("NetBooster Enchere  estimation",style="color:pink")),
  
  sidebarPanel(
    
    selectInput("regle", label = strong("Choisissez le regle:"),choices=list("max. revenu","min. cost","max. clicks","max. impressions","max. conversions"),selected = "max. revenu"),
    br(),
    numericInput("niveau",label=strong("Niveau de group:"),
                 value=0.25,min=0,max=1),
    br(),
    selectInput("months", "Choissez le mois", 
                choices=list("Juillet","Aout","Septembre","Octobre","Novembre","Decembre","Data annuel"),selected = "Aout"),
    
    selectInput("type", "Choissez le type de correspondance", 
                choices=list("Exact","Expression","Large"),selected = "Exact"),
    selectInput("devise", "Choissez le devise", 
                choices=list("EUR","GBP"),selected = "EUR"),
    selectInput("appar", "Choissez le appareil", 
                choices=list("Mobiles dotÃ©s d'un navigateur Internet complet","Ordinateurs","Tablettes dotÃ©es d'un navigateur Internet complet"),selected = "Ordinateurs"),
    
    br(),
    br(),
    numericInput("position", 
                 label = h3("Changer le position"), 
                 value = 1,min=1,max=5)
    
    
    
    
  ),
  
  
  mainPanel(
    tabsetPanel(
      tabPanel("Group",dataTableOutput("look")),
      tabPanel("Est",dataTableOutput("lk"))
      
    )
    
    
    
    
    
    
  )
))

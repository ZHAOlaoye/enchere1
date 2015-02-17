library(shiny)
library(datasets)





shinyServer(function(input, output) {
  
  datasetInput <- reactive({
    
    switch(input$months, 
           "Janvier"=Jour(B1),
           "Fevrier"=Jour(B2),
           "Mars"=Jour(B3),
           "Avril"=Jour(B4),
           "Mai"=Jour(B5),
           "Juin"=Jour(B6),
           "Juillet"=Jour(B7),
           "Aout"=Jour(B8),
           "Septembre"=Jour(B9),
           "Octobre"=Jour(B10),
           "Novembre"=Jour(B11),
           "Decembre"=Jour(B12),
           "Data annuel"=Jour(B13)
    )
  })
  
  DatasetInput <- reactive({
    switch(input$regle,
           "max. revenu"="Rev",
           "min. cost"="cost",
           "max. clicks"="Clics",
           "max. impressions"="Impressions" ,
           "max. conversions"="Clics.convertis"
    )
  })
  
  
  
  output$look <- renderDataTable({
    
    tra=trans(datasetInput(),"Type.de.correspondance",input$type)
    tra=trans(tra,"Devise",input$devise)
    tra=trans(tra,"Appareil",input$appar)
    
    
    last=group(input$niveau,tra,DatasetInput())
    T=tra
    col=which(colnames(T)==DatasetInput())  
    T=T[order(T[,col],decreasing=TRUE),]
    return(T[1:last,])
    options=list(pageLenth=10)
    
  })
  

  
  
  

  
  output$lk <- renderDataTable({
    tra=trans(datasetInput(),"Type.de.correspondance",input$type)
    tra=trans(tra,"Devise",input$devise)
    tra=trans(tra,"Appareil",input$appar)
    
    
    last=group(input$niveau,tra,DatasetInput())
    T=tra
    col=which(colnames(T)==DatasetInput())  
    T=T[order(T[,col],decreasing=TRUE),]
    clic=round(sum(T[1:last,which(colnames(T)=="Clics")]),3)
    imp=round(sum(T[1:last,which(colnames(T)=="Impressions")]),3)
    pos=round(mean(T[1:last,which(colnames(T)=="Position.moy.")]),3)
    conv=round(sum(T[1:last,which(colnames(T)=="Clics.convertis")]),3)
    rev=round(sum(T[1:last,which(colnames(T)=="Rev")]),3)
    budg=round(sum(T[1:last,which(colnames(T)=="cost")]),3)

    
    mat=matrix(0,6,2)
    colnames(mat)=c("Var","Estimation")
    mat[,1]=c("clics","impressions","positions","convertion","revenu","budget")
    mat[,2]=c(clic,imp,pos,conv,rev,budg)
    return(mat)
  })
  
  
})

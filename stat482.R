install.packages("shiny")
library(shiny)

ui <- fluidPage(
  titlePanel("Cryptocurrency Tax Calculator"),
  sidebarLayout(
    sidebarPanel(
      numericInput("amount", "Amount of Cryptocurrency:", value = 1, min = 0),
      numericInput("buyPrice", "Purchase Price per Unit:", value = 0),
      numericInput("sellPrice", "Selling Price per Unit:", value = 0),
      dateInput("buyDate", "Purchase Date:"),
      dateInput("sellDate", "Selling Date:"),
      numericInput("taxRate", "Tax Rate (%):", value = 15, min = 0)
    ),
    mainPanel(
      h3("Tax Calculation"),
      verbatimTextOutput("result")
    )
  )
)

server <- function(input, output) {
  output$result <- renderText({
    amount <- input$amount
    buyPrice <- input$buyPrice
    sellPrice <- input$sellPrice
    gain <- (sellPrice - buyPrice) * amount
    tax <- gain * (input$taxRate / 100)
    paste("Total Tax Owed: $", round(tax, 2))
  })
}

shinyApp(ui = ui, server = server)


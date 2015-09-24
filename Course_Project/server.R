library(shiny)
library(dplyr)
library(data.table)

print("Starting reading data file")
college_data_earnings <- data.table(read.csv("data/earnings.csv",header=TRUE))
print("Finished reading data file")
mean_earnings_sorted <- arrange(college_data_earnings,desc(md_earn_wne_p6))

setnames(mean_earnings_sorted,"INSTNM","College Name")
setnames(mean_earnings_sorted,"md_earn_wne_p6","Median Earnings/Year")

mean_earnings_display_top25 <- mean_earnings_sorted[1:25,]

mean_earnings_display_top25 <- subset(mean_earnings_display_top25,select=c("College Name","Median Earnings/Year"))

nr <- nrow(mean_earnings_sorted)

mean_earnings_display_bottom25 <- mean_earnings_sorted[(nr-24):nr,]

mean_earnings_display_bottom25 <- subset(mean_earnings_display_bottom25,select=c("College Name","Median Earnings/Year"))

gt_25k_earnings_sorted <- arrange(college_data_earnings,desc(gt_25k_p6))

setnames(gt_25k_earnings_sorted,"INSTNM","College Name")
setnames(gt_25k_earnings_sorted,"gt_25k_p6","% earning more than $25K/year")

gt_25k_earnings_display_top25 <- gt_25k_earnings_sorted[1:25,]

gt_25k_earnings_display_top25 <- subset(gt_25k_earnings_display_top25,select=c("College Name","% earning more than $25K/year"))

gt_25k_earnings_display_bottom25 <- gt_25k_earnings_sorted[(nr-24):nr,]

gt_25k_earnings_display_bottom25 <- subset(gt_25k_earnings_display_bottom25,select=c("College Name","% earning more than $25K/year"))

debt_data <- summarise(college_data_earnings, 
                       median(LO_INC_DEBT_MDN), 
                       median(MD_INC_DEBT_MDN),
                       median(HI_INC_DEBT_MDN))

                                                      
shinyServer(
  function(input, output) {
    output$text1 <- renderText({ 
      paste(input$var)
    })
    output$school_table <- renderTable({ 
      var <- switch(input$var, 
                     "Top 20 colleges for earnings" = mean_earnings_display_top25,
                     "Bottom 20 Colleges for earnings" = mean_earnings_display_bottom25,
                     "% students earning > $25K among top 25 Colleges" = gt_25k_earnings_display_top25,
                     "% students earning > $25K among bottom 25 Colleges" = gt_25k_earnings_display_bottom25,
                     "Average Debt among Low, Medium and High Income families" = debt_data)
    })
  }
)
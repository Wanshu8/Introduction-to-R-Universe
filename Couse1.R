# load the nessassary packages
library(readxl)
data<-read_excel("Case study sample-Spanish flu.xlsx")

install.packages("writexl")
library(writexl)
library(tibble)
print(data[1,5])
print(data[1,1])

# Transpose the data
transposed_data<- as.data.frame(t(data))

colnames(transposed_data) <- transposed_data[1, ]
transposed_data <- transposed_data[-1, ]
transposed_data <- tibble::rownames_to_column(transposed_data, var = "Time")


# Specify the path for the new Excel file
output_path <- "/Users/wanshu.zhang/Downloads/transposed_data.xlsx"

# Write the transposed data to a new Excel file
write_xlsx(transposed_data, output_path)

# Load necessary libraries
library(stringr)
library(dplyr)
# Read the data from the Excel file
data <- read_excel("/Users/wanshu.zhang/Downloads/transposed_data.xlsx")

# Search the cells contain “Spanish flu”
positions <- which(apply(data, 1:2, function(cell) {
  length(agrep("Spanish flu", cell, ignore.case = TRUE)) > 0
}), arr.ind = TRUE)

# Extract the content of the cells at the identified positions
content <- apply(positions, 1, function(pos) {
  data[pos[1], pos[2]]
})

# print the content
print(content)

# Create a result data frame with row, column, and content
results <- data.frame(
  row = positions[, 1],
  col = positions[, 2],
  content = unlist(content)
)

# print the result
print(results)

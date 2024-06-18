# load the nessassary packages
library(readxl)

### Adrian comments, June 18th 2024
# there were no paths defined for your .xlsx sheet
# I had to associate an .Rproj to your project
# Please make sure that you remember the following:
# When you sharing a project with someone else, either via GitHub or via E-Mail,
# They need to have both the files (like the .xlsx sheet) but also the path to that file
# Without the .Rproj your code would not have worked because in the code the path to the file 
# is not specified
data<-read_excel("Case study sample-Spanish flu.xlsx")

### Adrian comments, June 18th 2024
# A tip: Describe what you are doing, and why you need a specific package
# Sometimes we might forget or your colleagues with whom you share the project
# might not know the package

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
### Adrian comments, June 18th 2024
# This is good that you are specifying a path this way, but see my comment from below
# Use relative paths via .Rproj
# Since this path is not available on my local machine, 
# The code at line 43 will not work. 
output_path <- "/Users/wanshu.zhang/Downloads/transposed_data.xlsx"


# Write the transposed data to a new Excel file
write_xlsx(transposed_data, output_path)

# Load necessary libraries
library(stringr)
library(dplyr)
# Read the data from the Excel file

### Adrian comments, June 18th 2024
# See also my comment above
# This is the path to the .xlsx file on YOUR local machine
# Which means that if I was to run this code it would return an error
# To solve this issue, you either need to remind me or your collaborators to 
# update the path OR 
# you work with relative paths, for example, via .Rproj
# data <- read_excel("/Users/wanshu.zhang/Downloads/transposed_data.xlsx")
data <- read_excel("transposed_data.xlsx")

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

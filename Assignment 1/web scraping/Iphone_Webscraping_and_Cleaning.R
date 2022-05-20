library(robotstxt)
library(rvest)

url <- "https://www.amazon.in/s?k=iphone&i=electronics&crid=35KHGXAMKPXTD&sprefix=%2Celectronics%2C305&ref=nb_sb_ss_recent_1_0_recent"
path_check <- paths_allowed(url)

my_html <- read_html(url)

Name <-  my_html %>% html_nodes(".a-size-medium.a-text-normal") %>% html_text()
Price <- my_html %>% html_nodes("#search .a-price-whole") %>% html_text()
Times_Rated <- my_html %>% html_nodes(".s-link-style .s-underline-text") %>% html_text()
Rating <- my_html %>% html_nodes(".aok-align-bottom") %>% html_text()


Raw_iphone_det_amz <- data.frame(Name,Rating,Times_Rated,Price)

View(iphone_det_amz)

write.csv(Raw_iphone_det_amz,"Raw_iphone_det_amz.csv")

Raw_iphone_det_amz$Rating <- as.numeric(Raw_iphone_det_amz$Rating)
Raw_iphone_det_amz$Times_Rated <- as.integer(Raw_iphone_det_amz$Times_Rated)
Raw_iphone_det_amz$Price <- as.numeric(Raw_iphone_det_amz$Price)
Raw_iphone_det_amz$Name <-as.character(Raw_iphone_det_amz$Name)

#Cleaning data
library(dplyr)

Raw_iphone_det_amz$Rating <- gsub(" out of 5 stars","",Raw_iphone_det_amz$Rating)
Raw_iphone_det_amz$Times_Rated <- gsub("[,]","",Raw_iphone_det_amz$Times_Rated)
Raw_iphone_det_amz$Price <- gsub("[,]","",Raw_iphone_det_amz$Price)
Raw_iphone_det_amz$Name <- gsub("[()]","",Raw_iphone_det_amz$Name )
Raw_iphone_det_amz$Name <- gsub("Product","",Raw_iphone_det_amz$Name )
Raw_iphone_det_amz$Name <- gsub(" 3rd Generation","",Raw_iphone_det_amz$Name )
Raw_iphone_det_amz$Name <- gsub("[-]","",Raw_iphone_det_amz$Name )
Raw_iphone_det_amz$Name <- gsub("128 GB","128GB",Raw_iphone_det_amz$Name)
Raw_iphone_det_amz$Name <- gsub("64 GB","64GB",Raw_iphone_det_amz$Name)

View(Raw_iphone_det_amz)


library(tidyr)

Raw_iphone_det_amz <- Raw_iphone_det_amz[-c(23),]
View(Raw_iphone_det_amz)

Raw_iphone_det_amz <- subset(Raw_iphone_det_amz, select = -(...1))

library(tidyverse)

Raw_iphone_det_amz <- separate(Raw_iphone_det_amz,col = Name,into = c("Company","Brand","Model","Storage","Color"))
View(Raw_iphone_det_amz)

library(stringr)

Name <- str_c(str_c(Raw_iphone_det_amz$Company," ",Raw_iphone_det_amz$Brand)," ",Raw_iphone_det_amz$Model)
View(Name)


Raw_iphone_det_amz <- data.frame(Name,Raw_iphone_det_amz$Storage,Raw_iphone_det_amz$Color,Raw_iphone_det_amz$Rating,Raw_iphone_det_amz$Times_Rated,Raw_iphone_det_amz$Price)

View(Raw_iphone_det_amz)
head(Raw_iphone_det_amz)

colnames(Raw_iphone_det_amz)[colnames(Raw_iphone_det_amz) %in% c("Raw_iphone_det_amz.Storage","Raw_iphone_det_amz.Color","Raw_iphone_det_amz.Rating","Raw_iphone_det_amz.Times_Rated","Raw_iphone_det_amz.Price")] <- c("Int_Storage_GB","Color","Rating","Num_People_Rated","Price")

View(Raw_iphone_det_amz)

write.csv(Raw_iphone_det_amz,"Cleaned_iphonesdata.csv")

# Recleaning 

Cleaned_iphonesdata <- subset(Cleaned_iphonesdata, select = -(...1))
Cleaned_iphonesdata <- subset(Cleaned_iphonesdata, select = -(...2))
View(Cleaned_iphonesdata)
Cleaned_iphonesdata$Int_Storage_GB <- gsub("GB","",Cleaned_iphonesdata$Int_Storage_GB)

View(Cleaned_iphonesdata)

write.csv(Cleaned_iphonesdata,"Cleaned_iphonesdata.csv")

read.csv("Cleaned_iphonesdata.csv")

View(Cleaned_iphonesdata)

Cleaned_iphonesdata$Int_Storage_GB <- as.integer(Cleaned_iphonesdata$Int_Storage_GB)
Cleaned_iphonesdata$Name <- as.character(Cleaned_iphonesdata$Name)
Cleaned_iphonesdata$Color <- as.character(Cleaned_iphonesdata$Color)
Cleaned_iphonesdata$Rating <- as.numeric(Cleaned_iphonesdata$Rating)
Cleaned_iphonesdata$Num_People_Rated <- as.integer(Cleaned_iphonesdata$Num_People_Rated)
Cleaned_iphonesdata$Price <- as.numeric(Cleaned_iphonesdata$Price)

View(Cleaned_iphonesdata)

write.csv(Cleaned_iphonesdata,"Cleaned_iphonesdata.csv")

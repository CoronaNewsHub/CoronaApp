####=================================== Functions:
get.rss_format <- function(input){
  output <- list()
  output$meta <- input$meta
  output$entries <- as.data.frame(matrix(unlist(input$entries), ncol = length(input$entries)))
  colnames(output$entries) <- names(input$entries)
  return(output)
}

convertToXML <- function(df,name){
  xml <- xmlTree(name)
  for (i in 1:nrow(df)) {
    xml$addNode("item", close=FALSE)
    for (j in names(df)) {
      xml$addNode(j, df[i, j])
    }
    xml$closeTag()
  }
  return(xml)
}

get.path <- function(list_categories) {
  require("here")
  library(here)
  path <- here::here(list_categories)
  return(path)
}
####=================================== R packages:
if(!require("tidyRSS")){
  install.packages("tidyRSS")
  library("tidyRSS")
}

if(!require("XML")){
  install.packages("XML")
  library("XML")
}

if(!require("rvest")){
  install.packages("rvest")
  library("rvest")
}


####=================================== Code:
#setwd(get.path("xml_files"))
# rivm news
rivm_rss <- get.rss_format(tidyfeed("https://www.rivm.nl/nieuws/rss.xml", list = TRUE))
rivm_rss_english <-rivm_rss$entries[grep("node", rivm_rss$entries$item_link),] # English news
rivm_xml <- convertToXML(rivm_rss_english, "rivm_item") 
saveXML(rivm_xml$value(), "rivm.xml")

# nos new
nos_rss_general <- get.rss_format(tidyfeed("http://feeds.nos.nl/nosnieuwsalgemeen", list = TRUE)) # general
nos_general_xml <- convertToXML(nos_rss_general$entries, "nos_rss_general") 
saveXML(nos_general_xml$value(), "nos_general.xml")

nos_rss_domestic <- get.rss_format(tidyfeed("http://feeds.nos.nl/nosnieuwsbinnenland", list = TRUE)) # domestic
nos_domestic_xml <- convertToXML(nos_rss_domestic$entries, "nos_rss_domestic") 
saveXML(nos_domestic_xml$value(), "nos_domestic.xml")

nos_rss_abroad <- get.rss_format(tidyfeed("http://feeds.nos.nl/nosnieuwsbuitenland", list = TRUE)) # abroad
nos_abroad_xml <- convertToXML(nos_rss_abroad$entries, "nos_rss_abroad") 
saveXML(nos_general_xml$value(), "nos_abroad.xml")

                                
# goverment.nl new - no rss feed - we extract the links from latest news and create the data frame
total_links <- html_attr(html_nodes(read_html("https://www.government.nl/latest"), "a"), "href")
item_link <- paste0("https://www.government.nl", total_links[grep("/latest/news/2020/", total_links)])
data <-data.frame(item_link)
item_title<- sapply(data$item_link, 
       function(url){url %>% as.character() %>% read_html() %>% 
           html_nodes('h1') %>% html_text()})
gover_new <- data.frame(cbind(item_title, item_link))

gover_new_xml <- convertToXML(gover_new, "gover_new") 
saveXML(gover_new_xml$value(), "gover_new.xml")


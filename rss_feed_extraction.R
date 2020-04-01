####=================================== Functions:
get.rss_format <- function(input){
  output <- list()
  output$meta <- input$meta
  output$entries <- as.data.frame(matrix(unlist(input$entries), ncol = length(input$entries)))
  colnames(output$entries) <- names(input$entries)
  return(output)
}

save.html_files <- function(data, data_name) {
  doc_body <- NULL
  for(i in 1:nrow(data)) {
    doc_temp <- tags$html(
      h1(data$item_title[i]),
      p(data$item_description[i]),
      a(href=data$item_link[i], target="_blank", "More information")
    )
    doc_temp$name <- NULL
    doc_body <-c(doc_body,doc_temp)
  }
  doc_body$name <- NULL
  doc<-tags$html(tags$head(tags$title(data_name)),
                 tags$body(doc_body))
  save_html(doc, paste0(data_name, ".html"))
}

get.gover_new <- function(item_link) {
  data <-data.frame(item_link)
  item_title<- sapply(data$item_link, 
                      function(url){url %>% as.character() %>% read_html() %>% 
                          html_nodes('h1') %>% html_text()})
  gover_new <- data.frame(cbind(item_title, item_link))
  return(gover_new)
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

if(!require("htmltools")){
  install.packages("htmltools")
  library("htmltools")
}


if(!require("rvest")){
  install.packages("rvest")
  library("rvest")
}


####=================================== Code:
#setwd(get.path("html_files"))
setwd(get.path("www"))
# rivm news
rivm_rss <- get.rss_format(tidyfeed("https://www.rivm.nl/nieuws/rss.xml", list = TRUE))
rivm_rss_english <-rivm_rss$entries[grep("node", rivm_rss$entries$item_link),] # English news
save.html_files(rivm_rss_english, "rivm")


# nos new
#nos_rss_general <- get.rss_format(tidyfeed("http://feeds.nos.nl/nosnieuwsalgemeen", list = TRUE)) # general
#save.html_files(nos_rss_general$entries, "nos_general")


#nos_rss_domestic <- get.rss_format(tidyfeed("http://feeds.nos.nl/nosnieuwsbinnenland", list = TRUE)) # domestic
#save.html_files(nos_rss_domestic$entries, "nos_domestic")

#nos_rss_abroad <- get.rss_format(tidyfeed("http://feeds.nos.nl/nosnieuwsbuitenland", list = TRUE)) # abroad
#save.html_files(nos_rss_abroad$entries, "nos_abroad")


# goverment.nl new - no rss feed - we extract the links from latest news and create the data frame
total_links <- html_attr(html_nodes(read_html("https://www.government.nl/latest"), "a"), "href")
item_link <- paste0("https://www.government.nl", total_links[grep("/latest/news/2020/", total_links)])
gover_new <- get.gover_new(item_link)
save.html_files(gover_new, "government")


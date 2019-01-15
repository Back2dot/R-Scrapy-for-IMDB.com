install.packages("rvest", repos = "http://cran.r-project.org")
install.packages("xm12", repos = "http://cran.r-project.org")
library('rvest')

# Initiation of variables you want to fetch #
p <- 1:40                                                   # Number of pages
n <- 1:250                                                  # Number of movies on one page
rank_data <- vector()
title_data <- vector()
year_data <- vector()
description_data <- vector()
runtime_data <- vector()
genre_data <- vector()
rating_data <- vector()
votes_data <- vector()                        
gross_data <- vector()
directors_data <- vector()
actors_data <- vector()

for (i in p){
    url <- paste('http://www.imdb.com/search/title?title_type=feature&release_date=1980-01-01,2017-12-31&num_votes=690,&count=250&sort=boxoffice_gross_us,desc','&page=',i,'&ref_=adv_nxt',sep='')
    webpage <- read_html(url)

    rank_data_html <- html_nodes(webpage,'.text-primary')
    rank_data <- c(rank_data,html_text(rank_data_html))
    rank_data <- as.numeric(rank_data)

    title_data_html <- html_nodes(webpage,'.lister-item-header a')
    title_data <- c(title_data,html_text(title_data_html))

    year_data_html <- html_nodes(webpage,'.unbold')
    year_data <- c(year_data,html_text(year_data_html))
    
    # Delete series numbers in year_data
    for (m in (n+250*(i-1))){
        year_data <- year_data[-m]
    }
    
    # Delete useless symbols in year_data
    for (m in (n+250*(i-1))){
        if (nchar(year_data[m]) == 6){
            year_data[m] <- sub('^.','',year_data[m])
            year_data[m] <- sub('.$','',year_data[m])
        }else if (nchar(year_data[m]) == 10){
            year_data[m] <- sub('^.....','',year_data[m])
            year_data[m] <- sub('.$','',year_data[m])
        }else if (nchar(year_data[m]) == 11){
            year_data[m] <- sub('^......','',year_data[m])
            year_data[m] <- sub('.$','',year_data[m])
        }else if (nchar(year_data[m]) == 12){
            year_data[m] <- sub('^.......','',year_data[m])
            year_data[m] <- sub('.$','',year_data[m])
        }else if (nchar(year_data[m]) == 13){
            year_data[m] <- sub('^........','',year_data[m])
            year_data[m] <- sub('.$','',year_data[m])
        }
    }
    year_data <- as.numeric(year_data)

    description_data_html <- html_nodes(webpage,'.ratings-bar+ .text-muted')
    description_data <- c(description_data,html_text(description_data_html))
    description_data <- gsub("\n","",description_data)        

    runtime_data_html <- html_nodes(webpage,'.text-muted .runtime')
    runtime_data <- c(runtime_data,html_text(runtime_data_html))
    runtime_data <- gsub(" min","",runtime_data)
    runtime_data <- as.numeric(runtime_data)

    genre_data_html <- html_nodes(webpage,'.genre')
    genre_data <- c(genre_data,html_text(genre_data_html))
    genre_data <- gsub("\n","",genre_data)
    genre_data <- as.factor(genre_data)

    rating_data_html <- html_nodes(webpage,'.ratings-imdb-rating strong')
    rating_data <- c(rating_data,html_text(rating_data_html))
    rating_data <- as.numeric(rating_data)

    votes_data_html <- html_nodes(webpage,'.sort-num_votes-visible span:nth-child(2)')
    votes_data <- c(votes_data,html_text(votes_data_html))
    votes_data <- gsub(",", "", votes_data)
    votes_data <- as.numeric(votes_data)

    directors_data_html <- html_nodes(webpage,'.text-muted+ p a:nth-child(1)')
    directors_data <- c(directors_data,html_text(directors_data_html))
    directors_data<-as.factor(directors_data)

    actors_data_html <- html_nodes(webpage,'.lister-item-content .ghost+ a')
    actors_data <- c(actors_data,html_text(actors_data_html))
    actors_data <- as.factor(actors_data)

    gross_data_html <- html_nodes(webpage,'.ghost~ .text-muted+ span')
    gross_data <- c(gross_data,html_text(gross_data_html))
}

movies_df <- data.frame(
    Rank <- rank_data, 
    Title <- title_data,
    Year <- year_data,
    Description <- description_data, 
    Runtime <- runtime_data,
    Genre <- genre_data, 
    Rating <- rating_data,
    Votes <- votes_data,                           
    Gross_Earning <- gross_data,
    Director <- directors_data, 
    Actor <- actors_data
)






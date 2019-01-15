!!READ BEFORE USING THE SCRAPY CODES!!

The code is an automative program in order to fetch movie details from imdb.com.
Just change values of variables and features in codes to meet your own requests.

Some comments on R codes functions:
1. html_modes
This is a function to extract all target information on the website, with the specific requirements provided.
For example:
website <- "https://www.blablabla"
html_nodes(webpage,'.text-primary')

These two lines are to get all information on that website with the CSS limitation 'text-primary'.

USE 'SelectorGadget' to get the specific CSS limitations of what you want.
'SelectorGadget' is a Chrome tool which is Easy and powerful to select CSS.

2. as.numeric()
To tranform all numbers into real values from characters.

This is a personnal project. If there are any problems, feel free to modify and give suggestions. 

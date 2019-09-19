library(tidyverse) # tells R that we want to use the tidyverse library

read_csv("data/gapminder.csv") #tells R that we want to read the gapminder.csv file in data folder and prints to console

gapminder <- read_csv("data/gapminder.csv") # store gapminder data in a variable

nrow(gapminder) #returns the number of rows in the data set

ncol(gapminder) #returns the number of cols in the data set

colnames(gapminder) #returns the names of cols in the data set

glimpse(gapminder) #returns a data summary the return on this actually gives the info from nrow,ncol and colnames

select(gapminder,year,country,pop) #returns just the cols of interest

select(gapminder,3,1,5) #returns cols of interest by number

select(gapminder,3:5) #returns cols using a vector in this case 3,4 & 5

select(gapminder,-lifeExp, -pop) #removes cols by adding - prior to col name

select(gapminder,year:lifeExp) #returns cols in vector between names

select(gapminder, -(year:lifeExp)) #returns cols removed in vector between names

just_population <- select(gapminder,year,country,pop)# assigned the selected col to jsut_population variable

select(gapminder,starts_with("co")) #returns cols that are names starting with "co" using the start_with function

select(gapminder,contains("e")) #returns cols that have names that contain "e" using the contains function

select(gapminder,ends_with("p")) #returns cols that have names that end with "p" using the ends with function

select(gapminder,population=pop,country) #returns a col and renames using =

rename(gapminder,population=pop) #used to rename a col but keep all other col in a dataframe, if you rename a col then assign a new variable so keep this permenant

filter(gapminder,country == "Australia") #select rows where country is Australia

filter(gapminder,year>=1997) #select rows where the year is greater than 1997

filter(gapminder,lifeExp >= 80) #select rows where the life expectancy is greater thqan or equal to than 80

filter(gapminder,continent == "Europe") #select rows where contintent is Europe

filter(gapminder,lifeExp >=80,continent=="Europe") #selects rows where the life expectancy is greater than 80 and the continent is Europe


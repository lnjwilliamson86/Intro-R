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

#filter and select at the same time

#step-by-step
select(gapminder,country,year,pop) #selects cols required

challenge1 <- select(gapminder,country,year,pop) #assigns selected cols to new frame

challenge1 <- filter(challenge1,country == "Australia") # filters selected cols for Au data only and assigns to challenge1

#nested
challenge1 <-select(filter(gapminder,country =="Australia"),country,year,pop) #nested filter and select. The filter is evaluated first then the select function

challenge1 <-filter(select(gapminder,country,year,pop),country =="Australia") #nested select in filter function. the select is evaluated first the the filter function. 

#pipes
select(gapminder,year,pop)
gapminder%>% select (year,pop) #this gives you the same data as the above function but using a pipe instead of using gapminder in the function

filter(gapminder, country == "Australia", year >= 1997)
challenge2 <-gapminder%>% 
  filter(country =="Australia",year >= 1997) # this returns the same result as the above function but has piped the gapminder data in rather than include it in the fuction

select(filter(gapminder,country =="Australia"),country,year,pop)
challenge3<-gapminder%>%
  filter(country=="Australia")%>%
  select(country,year,pop) # these three rows 71-73 do the same as row 70 but uses the pipe operator to pipe in the output of the previous row to the next row. Also assigns to challenge3

#mutate

withgdp <- mutate(gapminder,gdp = gdpPercap * pop) #returns a new col called gdp byt multiplying col gdpPercap * pop

with_pop_millions <- mutate(gapminder, pop_millions= pop/1e6)# returns a new col called pop_millions 

mutate(gapminder,log_of_pop = log(pop)) #returns a new col that contains the log of the pop col.

str_sub("A long bit of text",start=1,end=5) #returns only the firt 5 characters in the string

mutate(gapminder,country_abbr = str_sub(country,start=1,end=3)) #returns a new col where we get only the first three characters in the country col

str_length("some words") #returns the number of letters in the words in this case 10

mutate(gapminder,country_length =str_length(country)) #returns a new col with the number of letters in each country name

mutate(gapminder,gdp=gdpPercap*pop, log_of_pop= log(pop)) #returns two new cols. separate by commas

mutate(
  gapminder,
  gdp = gdpPercap*pop,
  log_of_pop = log(pop),
)# rows 94-98 is a more readable way of expressing the code on row 92. 

mutate(
  gapminder,
  gdp = gdpPercap*pop,
  log_of_gdp = log(gdp),
)  # you can also do further calc on cols created in a single mutate function

mutate(
  gapminder,
  life_exp_days = lifeExp * 365,
  gdp_billions = gdpPercap*pop/1e9,
) #Creates cols in the gapminder data showing the life expectancy in days and one for GDP in billions of dollars

#summarise
summarise(gapminder, mean_life_exp = mean(lifeExp)) #returns the mean of the lifeExp this has produced a new dataframe

summarise(
  gapminder, 
  mean_life_exp =mean(lifeExp),
  sd_life_exp =sd(lifeExp),
  biggest_gdp = max(gdpPercap)
  )# returns the mean and sd of life exp and max of gdp per cap in a new dataframe

summarise(
  gapminder,
  mean_pop = mean(pop),
  median_pop = median(pop)
)#returns the mean and median pop in a new dataframe. 

summarise_if(gapminder,is.numeric,mean)# returns new data frame for mean of  numeric cols 

group_by(gapminder,country) #groups a data set by a col in this example 142 different counrty groups are created in this data set. 
by_country <- group_by(gapminder,country) #groupings don't give a new dataframe but adds groups as a piece of information about the data frame

summarise(gapminder,mean_pop=mean(pop),median_pop=median(pop))

summarise(by_country,mean_pop=mean(pop),median_pop=median(pop)) #returns a new dataframe that gives mean pop for each grouping

by_continent<- group_by(gapminder,continent) #returns dataframe grouped by continent and assigns to by_continent

summarise(by_continent,mean_pop=mean(pop), median_pop= median(pop)) #returns mean and median for by_continent

summarise(group_by(gapminder,continent),mean_pop=mean(pop),median_pop=median(pop)) #nested function for rows 137 and 139. Returns mean pop and median pop grouped by continent

gapminder %>%
  group_by(continent) %>%
  summarise(mean_pop= mean(pop),median_pop= median(pop)) #piped function for 137-139 returns mean pop and median pop by continent

#arrange
arrange(gapminder,gdpPercap) #sorts data by acscending gdpPercap

arrange(gapminder,desc(gdpPercap)) #uses helper function desc to organise in descending order by gdpPercap

#Calculate the average life expectancy per country. Which has the shortest average life expectancy and which has the longest average life expectancy?
mean_lifeExp_by_country <- gapminder %>% #get gapminder data and asgin a variable
  group_by(country)%>% #group by country
  summarise(mean_life_exp = mean(lifeExp))%>% #mean life exp per group
  arrange(mean_life_exp) #order results ascending
arrange(mean_lifeExp_by_country,desc(mean_life_exp)) #order data descending

mean_lifeExp_by_country <- gapminder %>% #get gapminder data and asgin a variable
  group_by(country)%>% #group by country
  summarise(mean_life_exp = mean(lifeExp))%>% #mean life exp per group
  filter(mean_life_exp==min(mean_life_exp)|mean_life_exp == max(mean_life_exp)) #returns just the min and max mean life exp

summarise(gapminder,num_rows = n ())# returns the number of rows in the gapminder dataframe

counts <- summarise(by_country,num_rows = n())#returns the number of rows for each country assigned counts so view function can be used in the console to open the data set
view(summarise(by_country,num_rows = n())) # alternative to row 166
summarise(by_country,num_rows = n())%>% # another alternative to 166
  view

#read in excel files
library(readxl) # when reading in excel files need to use the readxl library beucase it is not in the core tidyverse

gapminder_excel <- read_excel("data/gapminder.xlsx")#reads excel file and assigns 

read_excel("data/gapminder.xlsx",range ="A1:E4") # to read only a range from an excel file from the first sheet

read_excel("data/gapminder.xlsx",sheet = "gapminder") # to read only a particualr sheet in an excel workbook

#write data out
write_csv(gapminder_excel,"results/gapminder_output.csv") #writes out a csv file 
write_tsv(gapminder_excel,"results/gapminder-output.tsv") #writes out a tsv file

#jsut Australian data from gapminder
gapminder%>% #call gapminder dataframe then
  filter(country=="Australia")%>% #filter by country then
  write_csv("results/australia_only.csv") #write to csv

#see construct an analysis challenge
gapminder%>% #read gapminder
  filter(year==1972)%>% #filter to only 1972
  arrange(desc(pop))%>% #sort by popualtion size in desc order
  slice(6) #filter the 6th highest population row

#create a filtered data frame for 1987
life_exp_1987<- gapminder%>% #readgapminder
  filter(year==1987)%>% #filter data to include 1987
  arrange(desc(lifeExp))%>% #sort by life exp in desc order
  slice(1:10) #slice the top 10 life expectancies
life_exp_1987

#create a filtered data frame for 2007
life_exp_2007 <- gapminder %>% #readgapminder
  filter(year==2007) %>% #filter data to include 2007
  arrange(desc(lifeExp)) %>% #sort by life exp in desc order
  slice(1:10) #slice the top 10 life exp 
life_exp_2007
#combine 1987 & 2007 data frames 
#compare the data frames to see which countires are in both

#class disscussion
gapminder%>% #start with gapminder
  filter(year==1987|year ==2007) %>% #just work woth data from 1987 and 2007
  group_by(year) %>%  #year
  arrange(desc(lifeExp)) %>% #sort data by life expectancy (by year)
  top_n(10) %>% #get just the top ten (by year)
  group_by(country) %>%  #country
  summarise(country_life_exp=n()) %>%  #count the number of times a country appears (if appers 2 times then these are in both lists)
  filter(country_life_exp ==2)%>% #filter on countries with a count of 2
  write_csv("results/top10_life_exp_1987_and_2007") #write results to csv
 
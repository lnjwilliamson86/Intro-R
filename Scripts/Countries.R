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
  slice(1:100)%>% #get just the top ten (by year)
  group_by(country) %>%  #country
  summarise(country_life_exp=n()) %>%  #count the number of times a country appears (if appers 2 times then these are in both lists)
  filter(country_life_exp ==2)%>% #filter on countries with a count of 2
  write_csv("results/top10_life_exp_1987_and_2007") #write results to 


library(tidyverse) # calls library

#class challenge day 5
gapminder <- read_csv("data/gapminder.csv") # store gapminder data in a variable
gapminder%>% # calls gapminder
  filter(year==1957)%>% # filter to year 1957
  group_by(continent)%>% #groups by continent
  summarise(max_gdpPercap = max(gdpPercap)) #return maximum gdp per continent

#combining data
gapminder_2012 <- read_csv(file="data/gapminder_2012.csv") # read in gapminder_2012 dataset and assign to a variable

combined_gapminder <-bind_rows(gapminder,gapminder_2012) # joins gapminder and gapminder_2012 and assigns to combined_gapminder

rename_2012 <- rename(gapminder_2012,population=pop) # rename pop to popualtion 
mismatched_names <- bind_rows(gapminder, rename_2012) #bind gapminder and renamed with population col
mismatched_names # this results in a col added called population (as well as the pop col) this will have missing data for all years prior to 2012. the pop col will contain data from other years. 

#joins lesson
example_vector <- c(1,4,2,7) #shows a numeric vector 
example_vector

string_vector <- c('hello','this','is','a','vector') #assigns a string vector
string_vector

example_vector[3] # vectors have order (which is not neccesarily numberical or alphabetical) and should only have a single type of data in them
broken_vector<- c('hello', 2)
broken_vector # this should not work but r has converted the 2 into a string

df1<-tibble(sample=c(1,2,3),measure1=c(4.2,5.3,6.1)) #create a dataframe and assign to df1
df1

df2<-tibble(sample=c(1,3,4),measure2=c(7.8,6.4,9.0)) #create a dataframe and assign to df2
df2

inner_join(df1,df2) #conduct an inner join output is a 2x3 dataframe joins occur by cols with the same name
full_join(df1,df2) #conduct a full join output is a 4x3 dataframe
left_join(df1,df2) #conduct a left join output is a 3x3 dataframe

#make join using col with different names example
df3<- tibble(ID=c(1,2,4),measure3=c(4.7,34,2.6))
df3

full_join(df1,df3) # this will not work because there is no common col name this is fixed using "by" see row 267
full_join(df1,df3, by=c("sample"="ID")) 
full_join(df1,df2,by=c("sample")) # this shows explicity what 
full_join(df1,df3, by=c("sample"="ID","measure1"="measure3")) # the syntax is a little strange but is important because if data mismatches occur then rows are appended but is useful when there are mulitple cols between dataframes are shared

gapminder_sr<-read_csv("data/gapminder_sex_ratios.csv")
gapminder_sr
gapminder

inner_join(gapminder,gapminder_sr) #join occurs by country & year The output from full_join has the most rows, because it is keeping all the rows from both dataframes. inner_join is only including those rows that match. and has the least rows. The left_join output will depend on which data frame was provided first and has the same number of rows as that data frame.
full_join(gapminder,gapminder_sr)
left_join(gapminder,gapminder_sr)

#reshaping data
cows<- tibble(ID=c(1,2,3), #create the cows dataframe and assign cows
              weight1=c(203,227,193),
              weight2=c(365,344,329))
cows
cows_tidy<-gather(cows,rep,weight,-ID) #gather rows into columns and assign variable you can rearrange these to improve the readability of the data for example arrange by ID.  
cows_tidy%>%
  arrange(ID)

spread(cows_tidy,rep,weight)# this spreads the cows_tidy tibble and makes it look the same as the cows tibble. This would also be considered untidy data

#gather
table4a # calls table 4 a data
tidy_table4a<-gather(table4a,year,value,-country)%>% #uses gather function to rearrange the table to give 6x3 tidy data frame from 3x 3 untidy data frame
  arrange(country) #arranges table by country
tidy_table4a

#spread
spread(tidy_table4a,year,value) #uses spread function to spread cols to rows i.e. an untidy format. 

#spread
table2 #cols country, year, type and count
spread(table2,type,count)#spreads table2 by type and count
spread(table2,year,count)#spreads table2 by year and count

#separate
cows_with_breed <- cows %>% mutate(ID=c("1_A","2_A","3_B"))# edit cows table ID vector to add data to separate and assign. 
cows_with_breed
separate(cows_with_breed,col=ID, into=c("id","breed")) # returns the ID col separated in 2 cols, id and breed. 
separate(cows_with_breed,col=ID, into=c("id","breed"),sep= "_")# uses sep to specify which character should be used to separate by
separate(cows_with_breed,ID, c("id","breed"),"_") # will also work as it is in the correct syntax (expected position) for the function

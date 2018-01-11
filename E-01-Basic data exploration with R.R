#solution of exercise 01

#step-1-storing mtcars in new variable
    mtcars
    newmtcars <- mtcars
    newmtcars
    
    testm2=mtcars
    testm2 # so = also works
    
    #finding type and class
    class(newmtcars)
    typeof(newmtcars)
    
 #step-2-using R to calculate mean median and max for all columns
    #mean for all column
    mean(mtcars$mpg) # for single column
    colMeans(mtcars) #for all column 
    apply(mtcars, 2, mean); #also ok
    
    #median for all column
    median(mtcars$mpg)
    apply(mtcars, 2, median); #for all column
    
    #max for all column
    max(mtcars$mpg)
    apply(mtcars,2,max) #1 for row, 2 for column and max or min
    
    #note- we can see all these using summary(mtcars) at a time
    names(summary(mtcars))

#step-3-Visualize the miles per gallon1 (mpg) as well as plot its density (Two plots required, just a density plot is not sufficient!).
    
    #visualizing miles per galon
    plot(mtcars$mpg) #x-number of curs, y-mpg
    plot(sort(mtcars$mpg),xlab="Number of cars",ylab = "miles per gallon") #x-number of curs, y-mpg, more accurate
    #plot its density 
    dplot <- density(mtcars$mpg) # returns the density data 
    plot(dplot) # plots the results, x-mpg 

#step-4-Extend cars with a new column that contains the fuel consumption measured in l/100km.

    miletokm <- 1.609344
    galontol <- 3.785411784
    mpgconverter <- (100*galontol)/(miletokm*1)
    mpgconverter
    
    #new column added to copy of mtcars variable carsn 
    carsn <-mtcars
    carsn["lby100"] <- (100*galontol)/(miletokm*carsn$mpg)
    View(carsn)
    #removing column
    #carsn %>% select(-lby100) #removed column lby100 from x



#step-5-Visualize the relationship between the miles per gallon and l/100km.

    #tabcols contains only mpg and lby100 columns 
    
    #professor draw the plot where mpg and lby100 was in the same plot
    plot(carsn$mpg,carsn$lby100)
    
    #myone
    tabcols <-mtcars[1]
    tabcols["lby100"] <- (100*galontol)/(miletokm*carsn$mpg)
    tabcols["row"] <- rownames(carsn)
    tabcols
    
    
    library(ggplot2)
    library(gridExtra)
    x <-ggplot(tabcols, aes(x=row, y=mpg)) + 
      geom_bar(stat="identity") + 
      coord_flip()
    
    y <-ggplot(tabcols, aes(x=row, y=lby100)) + 
      geom_bar(stat="identity") + 
      coord_flip()
    
    grid.arrange(x, y, ncol=2)
    
    
    #hist(carsn$mpg)
    #hist(carsn$lby100) # histogram is not a plot 
    
    #remove.packages(c("ggplot2", "data.table"))
    #install.packages('Rcpp', dependencies = TRUE)
    #install.packages('ggplot2', dependencies = TRUE)
    #install.packages('data.table', dependencies = TRUE)
    #install.packages("colorspace")
    library( ggplot2 )
    
    #carsn$mpg, carsn$lby100
    ggplot(carsn, aes(x=factor(mpg)))+ geom_bar(fill = "red")
    ggplot(carsn, aes(x=factor(lby100)))+ geom_bar(fill = "green")
    
   






#------------------------------------other related learnings-----------------------------
#source: http://varianceexplained.org/RData/code/code_lesson3/
data("mtcars")
View(mtcars)
head(mtcars)
help(mtcars)
#we can access one of these columns using the dollar sign: for example:
mtcars$mpg
mean(mtcars$mpg)
median(mtcars$mpg)
sort(mtcars$mpg)
max(mtcars$mpg)
#finding specific type: for example mpg which are manual
manual <-mtcars[mtcars$am==1,]
manual
View(manual) #V must be capital letter 
rownames(mtcars)


#new column addition
#https://lembra.wordpress.com/2010/03/12/adding-new-column-to-a-data-frame-in-r/
carsn["L/100"] <- NA # this creates a column with just header but no values
carsn["L/100"] <- (100*galontol)/(miletokm*carsn$mpg)

#have to install ggplot2 before using only once 
remove.packages(c("ggplot2", "data.table"))
install.packages('Rcpp', dependencies = TRUE)
install.packages('ggplot2', dependencies = TRUE)
install.packages('data.table', dependencies = TRUE)
install.packages("colorspace")


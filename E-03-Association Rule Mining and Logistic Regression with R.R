#-------------------------Association Rule Mining with R-------------------------#
#1. Load the libraries arules and arulesViz. You may have to install them. Hint: library
    #and install.packages are the commands for loading and installing.

    #https://www.r-bloggers.com/association-rule-learning-and-the-apriori-algorithm/
    #install.packages("arules")
    #install.packages("arulesViz")
    
    library("arules")
    
    
    associationData <- read.transactions("http://user.informatik.uni-goettingen.de/~sherbold/AssociationRules.csv",rm.duplicates = FALSE,format="basket",sep=" ")
    associationData
    
    #summary(associationData2)
    
    #https://www.youtube.com/watch?v=b5hgDPa7a2k
    #a=10000*98 #rows or transaction*column or item 
    #b=0.1000643 #density can be found from summary 
    #c=a*b #so total item must be equal to most frequent items  ( 4948  +  3699   + 3308  +  3035  +  2831  + 80242 )
    
    inspect(associationData[1:3])#show 1st to 3rd data
    itemFrequency(associationData[,1])#show 1st item frequency, c*0.1718 = 16847.23 
    itemFrequency(associationData[,1:6])
    itemFrequencyPlot(associationData,support=0.45)
    itemFrequencyPlot(associationData,topN=5)
    #so support is how a item is used in total transaction. the more it availave in transactions its support 
    #is increaisng
    
    #confidence-> suppose someone buys item A and B, then how likely that he will also buy C. 
    results <- apriori(associationData)
    results <- apriori(associationData,parameter = list(support=0.007,confidence=0.25,minlen=2))
    summary(results)
    results <- apriori(associationData,parameter = list(support=0.07,confidence=0.4,minlen=2))
    summary(results)
    inspect(results[1:2])
    # lift is how much more likely an item is to be purchased relative to its general purchse rate given that you know anotehr item has been purchased 
    #higher lift is always good
    
    #the 1st and 3rd quartiles give a sense of the spread of the data, especially when compared to the minimum, maximum, and median
    
    #Here is how fivenum() calculates the 1st and 3rd quartiles.
    #Sort your data from smallest to largest
    #Find the median.  If your data set has an odd number of data, then the median is the datum such that the number of data above the median is the same as the number of data below the median.  If your data set has an even number, n, of data, the median is the average of the (n/2)th and (n/2 + 1)th largest data.
    #Find the set, L, of data below the median.  The 1st quartile is the median of L.
    #Find the set, U, of data above the median.  The 3rd quartile is the median of U.
    #summary() uses the quantile() function to calculate the 25% and 75% quantiles as the 1st and 3rd quartiles.  Thus, let's discuss how quantile() calculates quantiles.  
    #more at
    #https://chemicalstatistician.wordpress.com/2013/08/12/exploratory-data-analysis-the-5-number-summary-two-different-methods-in-r-2/
    
    
    inspect(sort(results,by="lift")[1:4]) #by may support,confidence
    
    #Visualizing rules
    #https://www.youtube.com/watch?v=91CmrpD-4Fw
    
    library("arulesViz")
    
    plot(results)
    plot(results,interactive=TRUE)#nice one :) 
     
    
    plot(results,method="grouped")
    #below code needs about 7-10 minutes to give output in this dataset of 11709 rules
    #plot(results,method = "grap", control = list(type="items"))
    
    #reduced rules and it takes only few seconds
    plot(results[1:16],method = "grap", control = list(type="items"))
    
    







#-------------------------Logistic Regression with R-------------------------#
    
    cuse <-read.table("http://data.princeton.edu/wws509/datasets/cuse.dat",header=TRUE)
    cuse
    plot(cuse)
    summary(cuse)
    #glm-generalized linear model 
    trainedModel = glm(formula=(cbind(using, notUsing) ~ age + education + wantsMore),data=cuse,family = binomial(logit))
    trainedModel
    summary(trainedModel)
    #explanation: https://www.youtube.com/watch?v=nubin7hq4-s
    
    
    
    
    #deviance should be as low as posiible, more the deviance the worst the fitting of model  is
    #null deviance- without explanatory valriables
    #residual deviance-after includeing the explanatory varialbles 
    #AIC-stands for Akaike information criterion.How good the quality of my model
    #is in comparision with other model, 
    #Let we have model A,B and C.
    #lowest value of AIC is the best optimal model
    
    
    
    
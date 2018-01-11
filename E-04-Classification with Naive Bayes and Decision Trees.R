

#1.-------------------------------------------------------------------------------------
#Load the libraries e1071 and party. You may have to install them.

#install.packages("e1071")
#install.packages("party")

library(e1071)
library(party)


#2.------------------------------------------------------------------------------------- 
#Create a training set and a test set from the iris data set. The training set shall
#contain 100 data points and the test set shall contain 50 data points. The training set
#and the test set shall be disjunctive.

#------------------------
#Random 100 and 50 values
#train<-iris[sample(150,100),]
#test<-iris[sample(150,50),]

#ind <- sample(2,nrow(iris), replace=TRUE, prob= c(0.7 , 0.3))
#td1 <- iris[ind==1,]
#td2 <- iris[ind==2,]
#nrow(td1)
#nrow(td2)


#fixed 100 and 50 values
#train = iris [1:100,] # this will put the first 100 rows into the training set
#test  = iris [101:150,] # this will put the remaining 50 rows into the test set
#View(train)
#View(test)

#The best tutorial so far 
#
#http://www.gettinggeneticsdone.com/2011/02/split-data-frame-into-testing-and.html
#


# splitdf function will return a list of training and testing sets
splitdf <- function(dataframe, seed=NULL) {
  if (!is.null(seed)) set.seed(seed)
  index <- 1:nrow(dataframe)
  trainindex <- sample(index, trunc(100))
  trainset <- dataframe[trainindex, ]
  testset <- dataframe[-trainindex, ]
  list(trainset=trainset,testset=testset)
}

#apply the function
splits <- splitdf(iris, seed=808)

#it returns a list - two data frames called trainset and testset
#str(splits)

# there are 105 observations in train data frame
#lapply(splits,nrow)

#view the first few columns in each data frame
#lapply(splits,head)

# save the training and testing sets as data frames
training <- splits$trainset
testing <- splits$testset

nrow(training)
nrow(testing)


#3.------------------------------------------------------------------------------------- 
#Train a naive bayes classifier for the species of the iris using Sepal.Length, Sepal.Width,
#Petal.Length, and Petal.Width with the training data (Hint: naiveBayes).

#https://www.youtube.com/watch?v=-utyqQOF9IU&t=79s (see 10:02 minutes)
#https://rpubs.com/dvorakt/144238

#classifier <- naiveBayes(iris$Species ~ iris$Sepal.Length + iris$Sepal.Width + iris$Petal.Length + iris$Petal.Width ,data=training)
#classifier
#table(predict(classifier,testing[,-5]),testing[,5])

model <- naiveBayes(Species ~ ., data = training)
model
table(predict(model, testing[,-5]), testing[,5])


View(testing)
#shows actual number of various data
table(testing$Species) 
data.frame(table(testing$Species))

#Note that setosa irises ( Petal.Width) tend to have smaller petals.width (mean value = .254...) and there is less 
#variation in petal width (standard deviation is only 0.1092....).


#from 

#http://ugrad.stat.ubc.ca/R/library/e1071/html/predict.naiveBayes.html
#data(iris)
#pairs(iris[1:4], main = "Iris Data (red=setosa,green=versicolor,blue=virginica)", pch = 21, bg = c("red", "green3", "blue")[unclass(iris$Species)])

#m <- naiveBayes(Species ~ ., data = iris)
## alternatively:
#m <- naiveBayes(iris[,-5], iris[,5])
#m
#table(predict(m, iris[,-5]), iris[,5])



#4.------------------------------------------------------------------------------------- 
#Train a decision tree with the command ctree for the species of the iris using
#Sepal.Length, Sepal.Width, Petal.Length, and Petal.Width with the training data.


#http://www.exegetic.biz/blog/2013/05/package-party-conditional-inference-trees/
#https://www.r-bloggers.com/package-party-conditional-inference-trees/

irisCtree <- ctree(Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, data=training)
print(irisCtree)


#5.------------------------------------------------------------------------------------- 
#Plot the decision tree

plot(irisCtree)

#6.------------------------------------------------------------------------------------- 
#Evaluate the results of both classifiers on both the training and the test data using the
#predict function.


table(testing$Species, predict(irisCtree, newdata = testing),dnn = c("Actual species", "Predicted species"))




#TREE
#The structure of the tree is essentially the same. Only the representation of the nodes 
#differs because, whereas ozone was a continuous numerical variable, iris species is a 
#categorical variable. The nodes are thus represented as bar plots. Node 2 is predominantly 
#setosa, node 5 is mostly versicolor and node 7 is almost all viriginica. Node 6 is half 
#versicolor and half virginica and corresponds to a category with long, narrow petals. 
#It is interesting to note that the model depends only on the dimensions of the petals 
#and not on those of the sepals.
#We can assess the quality of the model by constructing a confusion matrix. This shows 
#that the model performs perfectly for setosa irises. For versicolor it make 1 mistake 
#and and also for virginica he made one mistake


#for confusion matrix: 
#read-> http://www.dataschool.io/simple-guide-to-confusion-matrix-terminology/
#read-> https://en.wikipedia.org/wiki/Confusion_matrix














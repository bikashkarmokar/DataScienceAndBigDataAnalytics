#--------------------------Statistical Tests and Clustering---------------------------#
#source: http://statistics.ats.ucla.edu/stat/r/modules/prob_dist.htm

#1. Create three data samples with normally distributed data:
#  . S1: 100 values, µ = 0.0, ?? = 1.0
#  . S2: 100 values, µ = 1.5, ?? = 1.0
#  . S3: 10 values, µ = 1.5, ?? = 1.0


##  S1 data samples, S1: 100 values, µ = 0.0, ?? = 1.0
#Even though we would like to think of our samples as random, it is in fact almost 
#impossible to generate random numbers on a computer. So, we will admit that we are really 
#drawing a pseudo-random sample. In order to be able to reproduce the results on this
#page we will set the seed for our pseudo-random number generator to the value of 124 using 
#the set.seed function. (For more information on the random number generator used in R please 
#refer to the help pages for the Random.Seed function which has a very detailed explanation.)


#set.seed(124)

#It is often very useful to be able to generate a sample from a specific distribution. 
#To generate a sample of size 100 from a standard normal distribution (with mean 0 and 
#standard deviation 1) we use the rnorm function. We only have to supply the n (sample size) 
#argument since mean 0 and standard deviation 1 are the default values for the mean and stdev 
#arguments.

      set.seed(124)
      s1 <- rnorm(100) #used default mean 0 and sd 1
      s1[1:10] #shows first 10 numbers 
      mean(s1)
      sd(s1)


##  S2 data samples, S2: 100 values, µ = 1.5, ?? = 1.0  
      
      set.seed(124)
      s2 <-rnorm(100,1.5,1)#size,mean,standard deviation
      s2[1:10] #shows first 10 numbers 
      mean(s2)
      sd(s2)
      
      
##  S3 data samples, S3: 10 values, µ = 1.5, ?? = 1.0
      
      set.seed(124)
      s3 <-rnorm(10,1.5,1)#size,mean,standard deviation
      s3[1:10] #shows first 10 numbers 
      mean(s3)
      sd(s3)

      
      
#-------------------------------------------------------------------------------------------------
#2. Plot the densities of S1, S2, and S3 separately.
      
      #densities of s1
      dplots1 <- density(s1) # returns the density data 
      plot(dplots1) # plots the results, s1
      
      
      #densities of s2
      dplots2 <- density(s2) # returns the density data 
      plot(dplots2) # plots the results, s2
      
      
      #densities of s3
      dplots3 <- density(s3) # returns the density data 
      plot(dplots3) # plots the results, s3
      
#-------------------------------------------------------------------------------------------------      
#3. Plot the densities of S1 and S2, as well as S1 and S3 together.
      
      #densities of s1 and s2
      
      d1 <- density(s1) 
      d2 <- density(s2) 
      plot(range(d1$x, d2$x), range(d1$y, d2$y), type = "n", xlab = "x", ylab = "Density") 
      lines(d1, col = "red") 
      lines(d2, col = "blue") 
      
      
      #densities of s1 and s3
      
      d1 <- density(s1) 
      d3 <- density(s3) 
      plot(range(d1$x, d3$x), range(d1$y, d3$y), type = "n", xlab = "x", ylab = "Density") 
      lines(d1, col = "red") 
      lines(d3, col = "blue") 
      
      
      #densities of s1, s2 and s3
      d1 <- density(s1)
      d2 <- density(s2) 
      d3 <- density(s3) 
      plot(range(d1$x,d2$x, d3$x), range(d1$y,d2$y, d3$y), type = "n", xlab = "x", ylab = "Density") 
      lines(d1, col = "red") 
      lines(d2, col = "black") 
      lines(d3, col = "blue") 
      
      #also works
      #library(lattice) 
      #densityplot(~ s1 + s2, auto.key = TRUE) 
      
      
#-------------------------------------------------------------------------------------------------  
#4. Interpret the above density plots. What do they indicate?
      
      #--have to explain the graph
      
#-------------------------------------------------------------------------------------------------    
#5. Perform a t-test between S1 and S2, as well as between S1 and S3. How significant is the 
    #difference between the samples?
      
      
      #One of the most common tests in statistics is the t-test, used to determine whether the 
      #means of two groups are equal to each other. The assumption for the test is that both 
      #groups are sampled from normal distributions with equal variances.
      #http://statistics.berkeley.edu/computing/r-t-tests
      
      #s1 vs s2
      t.test(s1,s2)
      
      #s1 vs s3
      t.test(s1,s3)
      
      
      #Explanation: Since the p-value 9.817e-05 is less than 0.05 (or 5 percent), (.05-9.817e-05=0.04990183) 
      #it can be concluded that there is some difference between the means. 
      #To say that there is a difference is taking a 9.81700e-05 = 0.009817 percent percent risk of being wrong. 
      
      #High P values: your data are likely with a true null.
      #Low P values: your data are unlikely with a true null.
      #0.05      At least 23% (and typically close to 50%)
      #0.01      At least 7% (and typically close to 15%)
      
      
      #95% confidence interval for the mean
      #If repeated samples were taken and the 95% confidence interval was computed for each sample, 
      #95% of the intervals would contain the population mean.
      
      
      #degrees-of-freedom (df)
      #In statistics, the number of degrees of freedom is the number of values in the final 
      #calculation of a statistic that are free to vary. The number of independent ways 
      #by which a dynamic system can move, without violating any constraint imposed on it, 
      #is called number of degrees of freedom.
      
      #http://www.itl.nist.gov/div898/handbook/eda/section3/eda353.htm
      

      
      
      
#-------------------------------------------------------------------------------------------------            
#6. Apply the kmeans algorithm to the columns Petal.Width and Petal.Length of the iris data set
      # . Three times for k = 2
      # . Three times for k = 3
      # . Three times for k = 4
      
      #install.packages("dplyr")
      
      #the iris data
      iris
      
      irisCluster <- iris[, 3:4]
      irisCluster # only petal.length and petal.width
      
      2 -> k
      irisClusterMeans2 <- kmeans(irisCluster,k,nstart = 20) #nstart=if centers is a number, how many random sets should be chosen?
      irisClusterMeans2
      
                if(FALSE)#used as multiple line comment :) 
                {
                  
                }
                    for(i in 1:3){
                      2->k
                      print(irisClusterMeans2 <- kmeans(irisCluster,k,nstart = 20))
                      print(irisClusterMeans2)
                    }   
      
      

      3 -> k
      irisClusterMeans3 <- kmeans(irisCluster,k,nstart = 20) #nstart = 20. This means that R will try 20 different random starting assignments and then select the one with the lowest within cluster variation.
      irisClusterMeans3
              
          for(i in 1:3){
            3->k
            print(irisClusterMeans3 <- kmeans(irisCluster,k,nstart = 20))
            print(irisClusterMeans3)
          }    
      
      library(ggplot2)
      ggplot(irisCluster,aes(x=Petal.Width,y=Petal.Length,col=factor(irisClusterMeans3$cluster)))+geom_point()+labs(color="cluster")
      
      4 -> k
      irisClusterMeans4 <- kmeans(irisCluster,k,nstart = 20) 
      irisClusterMeans4
            

      
      for(i in 1:3){
        4->k
        print(irisClusterMeans4 <- kmeans(irisCluster,k,nstart = 20))
        print(irisClusterMeans4)
      }          
      
      
#-------------------------------------------------------------------------------------------------           
#7. Visualize the results of each clustering (Hint: look at the R documentation to see how
      #to do that). Do the clusters remain the same? Are the results as you would expect
      #them to be?
      
      #install.packages("fpc")
      library(cluster)
      library(fpc)
      
      # Kmeans clustre analysis
      
      plotcluster(irisCluster, irisClusterMeans2$cluster)
      plotcluster(irisCluster, irisClusterMeans3$cluster)
      plotcluster(irisCluster, irisClusterMeans4$cluster)
      
      clusplot(irisCluster, irisClusterMeans4$cluster, color=TRUE, shade=TRUE, labels=2, lines=0)
      
      #below code also show the same
      library(ggplot2)
      ggplot(irisCluster,aes(x=Petal.Width,y=Petal.Length,col=factor(irisClusterMeans3$cluster)))+geom_point()+labs(color="cluster")
      
      
      
      #comparing clusters with the species: 3 types
      table(irisClusterMeans4$cluster, iris$Species)
  
      
      
      
      
      
      
      
      
      
      
      
#others-- learning       
#-------------------------------------------------------------------------------------------------           
            
      #After a little bit of exploration, I found that Petal.Length and Petal.Width were similar among the same species but varied considerably between different species, as demonstrated below:
      #https://www.r-bloggers.com/k-means-clustering-in-r/
      #library(ggplot2)
      #ggplot(iris, aes(Petal.Length, Petal.Width, color = Species)) + geom_point()
      
      
      
      #to show the column 
      #names(iris)
      #x=iris[,-5] #removed column Species from x
      #x
      
      #library(ggplot2)
      #theme_set(theme_bw(base_size=12)) # set default ggplot2 theme
      #library(dplyr)
      
      #x=iris
      #x %>% select(-Species) #removed column Species from x
      #kc <- kmeans(x,3)
 
      
  
      
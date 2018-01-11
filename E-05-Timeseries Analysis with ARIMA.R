#Sources
#http://a-little-book-of-r-for-time-series.readthedocs.io/en/latest/src/timeseries.html




#install.packages('forecast', dependencies = TRUE)

#1.---------------------------------------------------------------------------------------------
#Load the library forecast. You may have to install it.

library(forecast)


#2.---------------------------------------------------------------------------------------------
#Load the data with scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")

nybirths <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")
nybirths



#3.---------------------------------------------------------------------------------------------
#The data is monthly and starts in the year 1946. Create an appropriate time series object.

#we have loaded a dataset of number of births per month in New York city, from January 1946 to December 1958.
#we can see that using below statement 
#we can specify the number of times that data was collected per year by using the 
#frequency parameter in the ts( ) function. For monthly data, we set frequency = 12. 

nybirthsByMonths <- ts(nybirths, frequency = 12, start = c(1946, 1))
nybirthsByMonths



#4.---------------------------------------------------------------------------------------------
#Decompose the data into the trend, the seasonal influences and the random influences. Plot the results of the decomposition.
#the time series of the number of births per month in New York city is seasonal with a peak every summer and trough every winter, and can probably be described using an additive model since the seasonal and random fluctuations seem to be roughly constant in size over time:

nybirthsByMonthsDecompose <- decompose(nybirthsByMonths)

nybirthsByMonthsDecompose$trend
nybirthsByMonthsDecompose$seasonal
nybirthsByMonthsDecompose$random

#The estimated seasonal factors are given for the months January-December, 
#and are the same for each year. The largest seasonal factor is for July (about 1.46), 
#and the lowest is for February (about -2.08), indicating that there seems to be a peak 
#in births in July and a less births in February each year.

plot(nybirthsByMonthsDecompose)
#We see that the estimated trend component shows a small decrease from about 
#24 in 1947 to about 22 in 1948, followed by a steady increase from then on 
#to about 27 in 1959.



#5.---------------------------------------------------------------------------------------------
#Calculate an adjusted time series without the seasonal efects.

nybirthsByMonthsDecomposeAdjusted <- ( nybirthsByMonths- nybirthsByMonthsDecompose$seasonal )

nybirthsByMonthsDecomposeAdjusted

#To seasonally adjust the time series of the number of births per month in 
#New York city, we can estimate the seasonal component using "decompose()", 
#and then subtract the seasonal component from the original time series:
plot(nybirthsByMonths)
plot(nybirthsByMonthsDecomposeAdjusted)
#You can see that the seasonal variation has been removed from the seasonally adjusted time series. The seasonally adjusted time series now just contains the trend component and an irregular component.

#6.---------------------------------------------------------------------------------------------
#Use the adjusted time series to
# train an ARIMA model with the parameters p = q = d = 1.
# train an ARIMA model with automatically guessed parameters for p; q and d (Hint: auto.arima).


#theory:
#ARIMA models are defined only for stationary time series. Therefore, 
#if the raw data are non-stationary, you will need to difference the series until 
#you obtain stationarity. Once you know the order of differencing you can use it 
#as the d parameter in an ARIMA(p, d, q) model.

#stationary or non stationary see below link
#https://www.analyticsvidhya.com/blog/2015/12/complete-tutorial-time-series-modeling/

plot(nybirthsByMonths)

nybirthsByMonthsdiff1 <- diff(nybirthsByMonths, differences = 1)

plot(nybirthsByMonthsdiff1)


nybirthsByMonthsdiff2 <- diff(nybirthsByMonths, differences = 2)

plot(nybirthsByMonthsdiff2)


nybirthsByMonthsdiff3 <- diff(nybirthsByMonths, differences = 3)

plot(nybirthsByMonthsdiff3)

#for finding p, q
# have to find acf and pacf using diff result with lag

#acf(issuesbymonthDecomposeAdjusted)
#pacf(issuesbymonthDecomposeAdjusted)


#a
nybirthsByMonthsDecomposeAdjustedArima111 <- arima(nybirthsByMonthsDecomposeAdjusted, order = c(1,1,1))
nybirthsByMonthsDecomposeAdjustedArima111



#b
AutoArima <- auto.arima(nybirthsByMonthsDecomposeAdjusted)
AutoArima



#7.---------------------------------------------------------------------------------------------
#Forecast the next 12 months using both trained models and plot the results (Hint: forecast.Arima).



#a
nybirthsByMonthsDecomposeAdjustedArima111Forcast <- forecast.Arima(nybirthsByMonthsDecomposeAdjustedArima111, h=12)
nybirthsByMonthsDecomposeAdjustedArima111Forcast
plot(nybirthsByMonthsDecomposeAdjustedArima111Forcast)



nybirthsByMonthsDecomposeAdjustedArimaAutoForcast <- forecast.Arima(AutoArima, h=12)
nybirthsByMonthsDecomposeAdjustedArimaAutoForcast
plot(nybirthsByMonthsDecomposeAdjustedArimaAutoForcast)




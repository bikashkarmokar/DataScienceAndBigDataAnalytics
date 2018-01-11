
if(!require(mongolite)) install.packages("mongolite")
library(mongolite)

# URL f o r conne c t ing to the remote MongoDB hos ted at the GWDG
# You must i n s e r t your DB c r e d e n t i a l s he r e

#MONGO_URL = "mongodb://group10:psE8579Z@141.5.113.177:27017/smartshark_test"

# URL f o r conne c t ing to a l o c a l MongoDB.
MONGOURL = "mongodb://localhost:27017/smartshark_test"

con_people = mongo(collection="people", url=MONGO_URL)


# f e t c h a l l data from the peopl e c o l l e c t i o n int o a data frame
people = con_people$find()

people

# per form query on DB to f e t c h only peopl e with username "zookeeper us e r "
people = con_people$find ('{"username":"zookeeper-user"}')
people


# determine the l a t e s t commit o f a p r o j e c t
con_commit = mongo(collection="commit",url=MONGO_URL)

commits = con_commit$find( fields='{"_id":1,"committer_date":1}' )
commits = con_commit$find()
head(commits$message,11)

print(paste("latestcommit:",max(commits$committer_date)))

latest_commit_id = commits[which.max(commits$committer_date),1] 
latest_commit_id



# f i n d a l l code e n t i t y inf o rma t i on in l a t e s t commit
con_codeentitystate = mongo( collection="codeentitystate",url=MONGO_URL)

query_str = paste('{"commit_id":{"$oid":"',latest_commit_id,'"}}',sep ="")

code_entities = con_codeentitystate$find(query_str)
code_entities

#mine----------------------------------------------------------------------------------------------------------------



con_event = mongo(collection="event", url=MONGO_URL)


# f e t c h a l l data from the peopl e c o l l e c t i o n int o a data frame
event = con_event$find()

event

# per form query on DB to f e t c h only peopl e with username "zookeeper us e r "
eventbyid = con_event$find ('{"username":"zookeeper-user"}')
eventbyid

#-------------message
con_message = mongo(collection="message", url=MONGO_URL)


# f e t c h a l l data from the peopl e c o l l e c t i o n int o a data frame
message = con_message$find() # about 67337 records are thre, so be careful while executing

View(message)
names(message)
head(message$body,11)

head(message$subject,11)

message$subject
unique(message$subject)


#-------------tag
con_tag = mongo(collection="tag", url=MONGO_URL)


# f e t c h a l l data from the peopl e c o l l e c t i o n int o a data frame
tag = con_tag$find() # about 67337 records are thre, so be careful while executing

View(tag)
names(tag)
head(tag$message,11)

#have to see
#https://cran.r-project.org/web/packages/mongolite/vignettes/intro.html
#https://rstudio-pubs-static.s3.amazonaws.com/31867_8236987cf0a8444e962ccd2aec46d9c3.html#word-frequency
#https://docs.mongodb.com/manual/reference/sql-comparison/




# for testing

s1 <- 0
s2 <- 1
str<-paste(s1,s2,sep = "")
str

for(y in 2008:2016)
{
  for(m in 1:12)
  {
    #year
    s1<-paste(y,'-',sep = "")
    #month
    if(m<10)
    {
      a<-0
      s2<-paste(a,m,sep="")
      
    }else{
      s2 <- m
    }
    #concat
    str<-paste(s1,s2,sep = "")
    
    print(str)
  }
}


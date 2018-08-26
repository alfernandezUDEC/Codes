###############################################
#### CREATED BY ALFONSO FERNANDEZ IN 2015 #####
#### This is a code to generate a plot to #####
#### show satellite images used in a paper#####
#### as a timeline. I thought this is     #####
####  than a long table.                  #####
#### Still a clumsy code as some loops can#####
#### be merged                            #####
###############################################

# Delete all variables
rm(lis=ls())

# need a library to load the special fonts
library(extrafont)
loadfonts()
# If you want to output to .ps files instead of .pdf, use:
# loadfonts(device="postscript") ## Uncomment this when needed

# Import table with dates
# I used landast 7 so I had to show the two kind of available images
s_on=read.table('SLC_on.csv',sep=',') 
s_off=read.table('SLC_off.csv',sep=',')

# The years of the images
years_use=seq(2001,2008)

#dates for lines
dates_y=seq(as.Date('2000-01-01'),as.Date('2000-12-31'),by='day') 
x_lim=c(as.Date('2000-01-01'),as.Date('2000-12-31'))
months_p=seq(as.Date('2000-01-01'),as.Date('2000-12-31'),by='month')
months_n=c('JAN','FEB','MAR','APR','MAY','JUN','JUL','AGO','SEP','OCT','NOV','DEC')
#plot(as.Date(as.character(s_on$V1),format='%m/%d/%y'),s_on$V2,pch=19,cex=3,col='gray60')

# Create the figure as tiff
tiff('Landist2.tif',width=9,height=7,units='in',res=500,family="Calibri")
par(family="Calibri")
plot(as.Date(as.character(s_on$V1),format='%m/%d/%y'),s_on$V2,pch=21,cex=2,col='black',
     bg='white',ylim=c(2000.7,2008),ylab='Year',xlab='',cex.lab=1,cex.axis=1,xlim=x_lim,xaxt='n',yaxt='n')


# Loop to get the lines for each year
for (i in years_use) {
     lines(dates_y,rep(i,length(dates_y)))
}

# A second loop to get the months on the lines
for (i in c(months_p,as.Date('2001-01-01'))) {
    lines(rep(i,length(c(2000,years_use))),c(2000,years_use),lty=3,col='gray75',lwd=0.7)
}

# Add the image date as point - SLC ON
points(as.Date(as.character(s_on$V1),format='%m/%d/%y'),s_on$V2,pch=21,cex=2,col='black',bg='white')

# Add the image date as point - SLC OFF
points(as.Date(as.character(s_off$V1),format='%m/%d/%y'),s_off$V2,pch=20,cex=3,col='gray60')

# Plot axes 
axis(1,months_p,labels=months_n,family="Calibri")
axis(2,years_use,labels=as.character(years_use),family="Calibri")

# Add the number of the day below the dot representing the image on the plot SLC ON
for (n in seq(1,length(s_on$V2))) {
    day_n=unlist(strsplit(as.character(s_on$V1[n]),'/'))[2]
    text(as.Date(as.character(s_on$V1[n]),format='%m/%d/%y'),s_on$V2[n]-0.3,day_n,family="Calibri")
}

# Add the number of the day below the dot representing the image on the plot SLC OFF
for (n in seq(1,length(s_off$V2))) {
    day_n=unlist(strsplit(as.character(s_off$V1[n]),'/'))[2]
    text(as.Date(as.character(s_off$V1[n]),format='%m/%d/%y'),s_off$V2[n]-0.3,day_n,family="Calibri")
}

# Release the plotting devise to get the figure
dev.off()

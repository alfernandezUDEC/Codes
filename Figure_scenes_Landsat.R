#Landsat plot
#rm(lis=ls())

#load the fonts
#library(extrafont)
#loadfonts()
# If you want to output to .ps files instead of .pdf, use:
# loadfonts(device="postscript")

#Import table with dates
s_on=read.table('SLC_on.csv',sep=',')
s_off=read.table('SLC_off.csv',sep=',')

years_use=seq(2001,2008)
#dates for lines
dates_y=seq(as.Date('2000-01-01'),as.Date('2000-12-31'),by='day') 
x_lim=c(as.Date('2000-01-01'),as.Date('2000-12-31'))
months_p=seq(as.Date('2000-01-01'),as.Date('2000-12-31'),by='month')
months_n=c('JAN','FEB','MAR','APR','MAY','JUN','JUL','AGO','SEP','OCT','NOV','DEC')
#plot(as.Date(as.character(s_on$V1),format='%m/%d/%y'),s_on$V2,pch=19,cex=3,col='gray60')

tiff('Landist2.tif',width=9,height=7,units='in',res=500,family="Calibri")
par(family="Calibri")
plot(as.Date(as.character(s_on$V1),format='%m/%d/%y'),s_on$V2,pch=21,cex=2,col='black',bg='white',ylim=c(2000.7,2008),ylab='Year',xlab='',cex.lab=1,cex.axis=1,xlim=x_lim,xaxt='n',yaxt='n')



for (i in years_use) {

lines(dates_y,rep(i,length(dates_y)))

}

for (i in c(months_p,as.Date('2001-01-01'))) {
lines(rep(i,length(c(2000,years_use))),c(2000,years_use),lty=3,col='gray75',lwd=0.7)
}

points(as.Date(as.character(s_on$V1),format='%m/%d/%y'),s_on$V2,pch=21,cex=2,col='black',bg='white')
 
points(as.Date(as.character(s_off$V1),format='%m/%d/%y'),s_off$V2,pch=20,cex=3,col='gray60')

axis(1,months_p,labels=months_n,family="Calibri")
axis(2,years_use,labels=as.character(years_use),family="Calibri")

for (n in seq(1,length(s_on$V2))) {

day_n=unlist(strsplit(as.character(s_on$V1[n]),'/'))[2]

text(as.Date(as.character(s_on$V1[n]),format='%m/%d/%y'),s_on$V2[n]-0.3,day_n,family="Calibri")

}

for (n in seq(1,length(s_off$V2))) {

day_n=unlist(strsplit(as.character(s_off$V1[n]),'/'))[2]

text(as.Date(as.character(s_off$V1[n]),format='%m/%d/%y'),s_off$V2[n]-0.3,day_n,family="Calibri")

}
dev.off()
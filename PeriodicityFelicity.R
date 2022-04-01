my_data <- read.delim("/Users/rohanojha/Downloads/PeriodicityProject/3C279.txt", sep=",", header=FALSE)
y<-my_data[1]
x<-my_data[2]
y<-y-(sum(y)/lengths(y))

x2<- data.frame(x, y)
par(mfrow=c(3,1))
plot(x2, cex=0.5, xlab="Year", ylab="Brightness", ylim=rev(range(y)))
periodogram<-lsp(y[,1], times=x[,1], from=0.1, to=150, plot=FALSE, type="period")

predictedPeriod<-periodogram$peak.at[1]
print(c("Predicted Period", periodogram$peak.at[1]))
print(c("Significant Value Threshold", periodogram$sig.level))
print(c("Power of Predicted Period", periodogram$peak))
print(c("Probability max occurred by chance", periodogram$p.value))

thisA<-0
thisB<-0
thisC<-0
thisError<-0
minA<--4
minB<--3.2
minC<--3
maxA<-4
maxB<-3.2
maxC<-3
byA<-1
byB<-0.8
byC<-0.5
boolVar=TRUE
count=0
while(boolVar) {
	count=count+1
	a<-seq(minA,maxA,by=byA)
	b<-seq(minB,maxB,by=byB)
	c<-seq(minC,maxC,by=byC)
	aList<-c()
	bList<-c()
	cList<-c()
	resultCalcList<-c()
	resultList<-c()
	for (valA in a){
		for (valB in b){
			for (valC in c){
				aList<-c(aList, valA)
				bList<-c(bList, valB)
				cList<-c(cList, valC)
				resultCalcList<-c()
				for (val in x){
					resultCalcList<-c(resultCalcList, valA*sin((2*pi*val/predictedPeriod)+valB)+valC)
				}
				resultList<-c(resultList, mean('^'((resultCalcList-y)$V1,2)))
			}
		}
	}
	if((thisA-aList[match(min(resultList), resultList)]<0.001)&(thisB-bList[match(min(resultList), resultList)]<0.001)&(thisC-cList[match(min(resultList), resultList)]<0.001)&(count>3)){
		boolVar=FALSE
	}
	thisA<-aList[match(min(resultList), resultList)]
	thisB<-bList[match(min(resultList), resultList)]
	thisC<-cList[match(min(resultList), resultList)]
	thisError<-min(resultList)
	minA=thisA-2*byA
	maxA=thisA+2*byA
	minB=thisB-2*byB
	maxB=thisB+2*byB
	minC=thisC-2*byC
	maxC=thisC+2*byC
	byA=byA/2
	byB=byB/2
	byC=byC/2
}
print(c("Amplitude", thisA))
print(c("Phase", thisB))
print(c("Offset", thisC))
print(c("Error", thisError))

regressionY<-y[,1]
regressionX<-x[,1]

regressionWave<-nls(regressionY~(amplitude*sin((2*pi*regressionX/predictedPeriod)+phase)+offset), start=list(amplitude=thisA, phase=thisB, offset=thisC))
print(summary(regressionWave))
amplitude=coefficients(regressionWave)[[1]]
phase=coefficients(regressionWave)[[2]]
offset=coefficients(regressionWave)[[3]]

x<-seq(1870,2010,by=0.2)
y<-amplitude*sin((2*pi*x/predictedPeriod)+phase)+offset
x2<- data.frame(x, y)
lines(x2)

predictedValues<-amplitude*sin((2*pi*regressionX/predictedPeriod)+phase)+offset
plot(data.frame(regressionX, predictedValues-regressionY), cex=0.5, xlab="Year", ylab="Residual")
lines(data.frame(x,0))

periodogram<-lsp(regressionY, times=regressionX, from=0.1, to=150, plot=TRUE, type="period")

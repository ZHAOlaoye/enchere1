
group=function(niv,mois,names){
  T=mois
  col=which(colnames(T)==names)  
  T=T[order(T[,col],decreasing=TRUE),]
  som=0
  limit=niv*sum(T[,col])
  for (i in 1:length(T[,col])) {
    som=som+T[i,col];
    first=i;
    if(som >= limit) 
      break;
    
  }
  first
}


trans=function(mois,names,names1) {
  col=which(colnames(mois)==names)
  J=mois[which(mois[,col]==names1),]
  J
}



B7<-read.csv2("1407.csv",sep="\t")
B8<-read.csv2("1408.csv",sep="\t")
B9<-read.csv2("1409.csv",sep="\t")
B10<-read.csv2("1410.csv",sep="\t")
B11<-read.csv2("1411.csv",sep="\t")
B12<-read.csv2("1412.csv",sep="\t")
B13<-read.csv2("1501.csv",sep="\t")



Jour=function(B){

test<-as.character(B[,3])
test1=matrix(0,length(test),3)
for (i in 1:length(test)) (
  for (j in 1:3)  (
    test1[i,j]=unlist(strsplit(test[i],"/"))[j]                       
  )        
)
date1=paste(test1[,2],test1[,3],sep="-")
B[,3]=date1


B=B[which(B[,12]!=0|B[,14]!=0|B[,10]!=0|B[,16]!=0|B[,17]!=0|B[,11]!=0),c(2,3,4,5,6,9,10,11,12,13,14,15,16,17)]

colnames(B)[9]="cost"
colnames(B)[14]="Rev"

Jour1=aggregate(B[,c(7,8,9,10,11,13,14)],by=list(Keyword=B[,4],Date=B[,2],Campaign=B[,3],Appareil=B[,1],Group=B[,5],Devise=B[,12],Type.de.correspondance=B[,6]),FUN=sum,na.rm=TRUE)
Jour1[,11]=aggregate(B[,10],by=list(Keyword=B[,4],Date=B[,2],Campaign=B[,3],Appareil=B[,1],Group=B[,5],Devise=B[,11],Type.de.correspondance=B[,6]),FUN=mean,na.rm=TRUE)[,8]
Jour1[,12]=aggregate(B[,11],by=list(Keyword=B[,4],Date=B[,2],Campaign=B[,3],Appareil=B[,1],Group=B[,5],Devise=B[,11],Type.de.correspondance=B[,6]),FUN=mean,na.rm=TRUE)[,8]

Jour1
}




















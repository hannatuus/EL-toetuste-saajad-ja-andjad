names(toetus)<-tolower(names(toetus))
#Vaiketahtedeks
toetus$projekti_toetus<-as.numeric(toetus$projekti_toetus)
#Factor <- numeric

summa_antud<-toetus%>%
  group_by(toetuse_andja)%>%
  summarise(summa_antud = sum(projekti_toetus, na.rm=TRUE))

summa_saadud<-toetus%>%
  group_by(toetuse_saaja_registri_kood)%>%
  summarise(summa_saadud = sum(projekti_toetus, na.rm=TRUE))

summa_antud<-summa_antud[order(summa_antud$summa_antud, decreasing=TRUE),]
summa_saadud<-summa_saadud[order(summa_saadud$summa_saadud, decreasing=TRUE),]
#Jarjestab saadud summad kahanevalt

summa_antud_long<- melt(summa_antud, id.vars=c("toetuse_andja"))
summa_saadud_long<- melt(summa_saadud, id.vars=c("toetuse_saaja_registri_kood"))
#Convertib data formaadi laiast pikaks

summa_antud_long<- summa_antud_long[order(summa_antud_long$value, decreasing=T),]
summa_saadud_long<- summa_saadud_long[order(summa_saadud_long$value, decreasing=T),]
#Jarjestab summad kahanevalt

summa_antud_long$value_miljonites<- summa_antud_long$value/1000000
# Kogusumma iga toetuseandja kohta miljonites
summa_saadud_long$value_tuhandetes<-summa_saadud_long$value / 10000
# Kogusumma iga toetusesaaja kohta tuhandetess

kumme_suurimat_toetuse_saajat <- summa_saadud_long[1:10,]
#Valib 10 suurimat toetusesaajat

ggplot(data=summa_antud_long,aes(x= reorder(toetuse_andja, -value), y=value/1000000))+ 
  geom_bar(stat="identity")+ xlab("Toetuse andja")+ ylab("Toetuste kogusumma (miljonites)")+
  ggtitle("Kogusumma iga toetuseandja kohta")+  
  theme(axis.text.x=element_text(angle=90), complete=FALSE)
#Barplot "Kogusumma iga toetuseandja kohta", pooratud axis text x-teljel

ggplot(data=kumme_suurimat_toetuse_saajat, aes(x= reorder (toetuse_saaja_registri_kood,-value/1000), y=value/10000)) + 
  geom_bar(stat="identity")+ xlab("Toetuse saaja registrikood") +
  ylab("Toetuste kogusumma (tuhandetes)") + ggtitle("Kümme suurimat toetusesaajat")+
  theme(axis.text.x=element_text(angle=90), complete=FALSE)
#Barplot 10 suurima toetusesaaja kogusmma kohta, pooratud axis x-teljel
url<-"http://register.fin.ee/register/index.php?&asuttyyp=&regname=&tunnus=aruanded&regkoodfrom=&regkoodto=&aadr=&korgkood=&action=searchnow&out=&slimit=3000&report=72&page="
omavalitsuste_register<-c()
data<-c()
n<-173 #number of pages scraped

for(page in 1:n){
  leht<-read_html(paste0(url, page))
  omavalitsuste_register[page]=paste0(url, page)
 text<-leht %>% 
  html_nodes(".table_system td") %>%
  html_text()
 data<-c(data,text)
  print(page)
  
sequ<-which(grepl("@", data))
interval<-abs(sequ[1]-sequ[2]) #11
  
integers<-c(0:2767) #number of articles (16*173)

registrikood_a<-data[1+interval*integers]
#picks out all of the register codes without the headings
#match(c("\n\nAsutuse registrikood\n"),y) = 1
registrikood_b<-registrikood_a[registrikood_a !="\n\nAsutuse registrikood\n"]
registrikood<-gsub("\n|\\s+$|^\\s+","",registrikood_b)
#removes noise 

nimi_a<-data[2+interval*integers]
#match(c("\n\nAsutuse tÃ¤isnimi\n"),y) = 2
nimi_b<-nimi_a[nimi_a !="\n\nAsutuse täisnimi\n"]
nimi<-gsub("\n|\\s+$|^\\s+","",nimi_b)


asukoht_a<-data[3+interval*integers] 
asukoht_b<-asukoht_a[asukoht_a !="\n\nMaakond, linn/vald, küla\n"]
asukoht_c<-gsub("\n|\\s+$|^\\s+","",asukoht_b)
asukoht_d<-gsub(".*,","", asukoht_c) #removes everything before comma (incl comma)
maakond<-gsub("^\\s+","",asukoht_d) #removes whitespace from the beginning of the string

lopetamise_kuupaev_a<-data[match(c("\n\nLõpet.kp\n"),data)+interval*integers]
lopetamise_kuupaev_b<-lopetamise_kuupaev_a[lopetamise_kuupaev_a !="\n\nLõpet.kp\n"]
lopetamise_kuupaev<-gsub("\n|\\s+$|^\\s+","",lopetamise_kuupaev_b)

email_a<-data[match(c("\n\nE-mail\n"),data)+interval*integers]
email_b<-email_a[email_a !="\n\nE-mail\n"]
email<-gsub("\n|\\s+$|^\\s+","",email_b)
}

aruanne<-data.frame(registrikood, nimi, maakond, lopetamise_kuupaev, email)
write.table(aruanne,"fail.csv",sep =";",row.names=F)


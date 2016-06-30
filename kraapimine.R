url<-"http://register.fin.ee/register/index.php?&asuttyyp=&regname=&tunnus=aruanded&regkoodfrom=&regkoodto=&aadr=&korgkood=&action=searchnow&out=&slimit=3000&report=72&page="
x<-c()
y<-c()


for(page in 1:2){
  leht<-read_html(paste0(url, page))
  x[page]=paste0(url, page)
 text<-leht %>% 
  html_nodes(".table_system td") %>%
  html_text()
 y<-c(y,text)
  print(page)
}

a<-which(grepl("@", y))
i<-abs(a[1]-a[2])

z<-c(0:as.integer(length(text)/i)) #integers

registrikood_a<-y[match(c("\n\nAsutuse registrikood\n"),y)+i*z]
#picks out all of the register codes including headings
registrikood_b<-registrikood_a[registrikood_a !="\n\nAsutuse registrikood\n"] 
#removes headings from the data
registrikood<-gsub("\n|\\s+$|^\\s+","",registrikood_b)
#removes noise

nimi_a<-y[match(c("\n\nAsutuse täisnimi\n"),y)+i*z]
nimi_b<-nimi_a[nimi_a !="\n\nAsutuse täisnimi\n"]
nimi<-gsub("\n|\\s+$|^\\s+","",nimi_b)

asukoht_a<-y[3+i*z] #!!!!!!!
asukoht_b<-asukoht_a[asukoht_a !="\n\nMaakond, linn/vald, küla\n"]
asukoht_c<-gsub("\n|\\s+$|^\\s+","",asukoht_b)
asukoht_d<-gsub(".*,","", asukoht_c) #removes everything before comma (incl comma)
maakond<-gsub("^\\s+","",asukoht_d) #removes whitespace from the beginning of the string

lopetamise_kuupaev_a<-y[match(c("\n\nLõpet.kp\n"),y)+i*z]
lopetamise_kuupaev_b<-lopetamise_kuupaev_a[lopetamise_kuupaev_a != "\n\nLõpet.kp\n"]
lopetamise_kuupaev<-gsub("\n|\\s+$|^\\s+","",lopetamise_kuupaev_b)

email_a<-y[match(c("\n\nE-mail\n"),y)+i*z]
email_b<-email_a[email_a !="\n\nE-mail\n"]
email<-gsub("\n|\\s+$|^\\s+","",email_b)

aruanne<-data.frame(registrikood, nimi, asukoht, lopetamise_kuupaev, email)

># write.table(aruanne,"fail.csv",sep =";",row.names=F)


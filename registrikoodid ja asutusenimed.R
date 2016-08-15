#library("devtools")
#install_github("RRisto/riigiteenused")
#install.packages(stringr)
#library("stringr")
#andmedLai=andmedSisse()
#andmedPikk=andmedPikaks(andmedLai)

#install.packages("stringdist")
#library("stringdist")

nimi_riigiteenused <- tolower(andmedLai$allasutus) #removes upper case
nimi_riigiteenused <- gsub("\n|\\s+$|^\\s+","",nimi_riigiteenused) #removes noise

aruanne$nimi <- tolower(aruanne$nimi)

unikaalne <- unique(nimi_riigiteenused)
regkood_ja_asutusenimi <- merge(as.data.frame(unikaalne), aruanne, by.x = "unikaalne", by.y = "nimi", all.x = TRUE)

na <- subset(regkood_ja_asutusenimi, is.na(registrikood))

i<-1
#for (i in c(1:length(na$unikaalne))) {
  similarity <- as.data.frame(stringsim(as.character(na$unikaalne[i]), aruanne$nimi,method = 'lcs'))
#} #valib pikima uhisosa jargi, mis sobib, kuna enamasti seisneb erinevus isikunimede 
#luhendamises voi nende lisamises/valja jatmises asutuse nimest

colnames(similarity) <- c("similarity_f")

vaste <- which.max(similarity$similarity_f)
test <- data.frame(na$unikaalne, vaste, max(similarity))

#summary(similarity)
#hist(similarity$similarity_f)
#similarity_large <- subset(similarity, similarity$similarity_f>0.45)
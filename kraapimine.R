url<- "http://register.fin.ee/register/index.php?&asuttyyp=&regname=&tunnus=aruanded&regkoodfrom=&regkoodto=&aadr=&korgkood=&action=searchnow&out=&slimit=999&report=68&page="
paste0(url,"1")

for(page in 1:67){
  print(paste0(url, 1:67))
}
  

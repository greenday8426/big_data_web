list.files()
list.files(recursive=T)
list.files(all.files=T)
setwd("c:\\easy_r")
scan1<-scan('scan_1.txt')
scan_1
scan2<-scan('scan_2.txt')
scan_2
scan2<-scan('scan_2.txt',what="")
scan2
scan3<-scan('scan_3.txt',what="")
scan3
fruit2<-read.table('fruits_2.txt')
fruit2
fruit2<-read.table('fruits_2.txt',skip=2)
fruit2
fruit2<-read.table('fruits_2.txt',nrows=2)
fruit2
install read_excel()


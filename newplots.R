setwd("/home/sepehr/projects/mpec")

library(xlsx)

# for the case of K in [50,150] --> sheetIndex=6
# for the case of k in [25,120] --> sheetindex = 9

lmpec=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=1,colIndex=2,rowIndex=(2:12)))
lpc=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=2,colIndex=2,rowIndex=(1:11)))
lmp=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=3,colIndex=2,rowIndex=(1:11)))

zmpec=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=1,colIndex=3,rowIndex=(2:12)))
zpc=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=2,colIndex=3,rowIndex=(1:11)))
zmp=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=3,colIndex=3,rowIndex=(1:11)))

x=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=1,colIndex=1,rowIndex=(2:12)))

price_mpec=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=1,colIndex=5,rowIndex=(2:12)))
price_pc=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=2,colIndex=5,rowIndex=(1:11)))
price_mp=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=3,colIndex=5,rowIndex=(1:11)))

aveprice_mpec=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=1,colIndex=14,rowIndex=(2:12)))
aveprice_pc=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=2,colIndex=18,rowIndex=(1:11)))
aveprice_mp=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=3,colIndex=18,rowIndex=(1:11)))


pbenefit_mpec=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=1,colIndex=11,rowIndex=(2:12)))
pbenefit_pc=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=2,colIndex=15,rowIndex=(1:11)))
pbenefit_mp=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=3,colIndex=15,rowIndex=(1:11)))

producersurplus_mpec=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=1,colIndex=10,rowIndex=(2:12)))
producersurplus_pc=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=2,colIndex=14,rowIndex=(1:11)))
producersurplus_mp=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=3,colIndex=14,rowIndex=(1:11)))

iso_mpec=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=1,colIndex=12,rowIndex=(2:12)))
iso_pc=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=2,colIndex=13,rowIndex=(1:11)))
iso_mp=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=3,colIndex=13,rowIndex=(1:11)))

cs_mpec=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=1,colIndex=9,rowIndex=(2:12)))
cs_pc=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=2,colIndex=12,rowIndex=(1:11)))
cs_mp=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=3,colIndex=12,rowIndex=(1:11)))

sw_mpec=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=1,colIndex=24,rowIndex=(2:12)))
sw_pc=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=2,colIndex=20,rowIndex=(1:11)))
sw_mp=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=3,colIndex=20,rowIndex=(1:11)))

sw_star_mpec=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=1,colIndex=29,rowIndex=(2:12)))
sw_star_pc=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=2,colIndex=24,rowIndex=(1:11)))
sw_star_mp=unlist(read.xlsx("mpec_results.xlsx",sheetIndex=3,colIndex=22,rowIndex=(1:11)))



plot(x,zpc, type="b", col="blue",lty=1,lwd=2.5, xlab = "Prosumer's Zero Marginal Cost Renewable Output (MW)", ylab = "Prosumer Sales (+)/Purchase (-) (MW)",font=2, font.lab=2)
lines(x,zmp, type="b", pch=22, lty=6,lwd=2, col="red")
lines(x,zmpec, type="b", pch=5, lty=2,lwd=2, col="orange")
abline(col="black",h=0,lty=3)
legend(100,-40, legend = c("PC","Cournot", "Stackelberg"),col=c("blue","red","orange"),bty = "n",lwd=c(2.5,2.5,2.5), lty=c(1,6,3) , cex=0.89)

plot(x,price_pc, type="b", col="blue",lty=1,lwd=2.5, xlab = "Prosumer's Zero Marginal Cost Renewable Output (MW)", ylab = "Price at Prsoumer Node ($/MWh)",font=2, font.lab=2)
lines(x,price_mp, type="b", pch=22, lty=6,lwd=2, col="red")
lines(x,price_mpec, type="b", pch=5, lty=3,lwd=2, col="orange")
abline(col="brown",v=106)
legend(106.22,45.5, legend = c("PC","Cournot", "Stackelberg"),col=c("blue","red","orange"),bty = "n",lwd=c(2.5,2.5,2.5), lty=c(1,6,3) , cex=0.89)

plot(x,aveprice_pc, type="b", col="blue",lty=1,lwd=2.5, xlab = "Prosumer's Zero Marginal Cost Renewable Output (MW)", ylab = "Average Market Price ($/MWh)",font=2, font.lab=2)
lines(x,aveprice_mp, type="b", pch=22, lty=6,lwd=2, col="red")
lines(x,aveprice_mpec, type="b", pch=5, lty=6,lwd=2, col="orange")
abline(col="brown",v=106)
legend(106.22,35.50, legend = c("PC","Cournot", "Stackelberg"),col=c("blue","red","orange"),bty = "n",lwd=c(2.5,2.5,2.5), lty=c(1,6,3) , cex=0.89)

plot(x,pbenefit_pc, type="b", col="blue",lty=1,lwd=2.5, xlab = "Prosumer's Zero Marginal Cost Renewable Output (MW)", ylab = "Prosumer Benefits (K$)",font=2, font.lab=2)
lines(x,pbenefit_mp, type="b", pch=22, lty=6,lwd=2, col="red")
lines(x,pbenefit_mpec, type="b", pch=5, lty=6,lwd=2, col="orange")
abline(col="brown",v=106)
legend(106.22, 11, legend = c("PC","Cournot", "Stackelberg"),col=c("blue","red","orange"),bty = "n",lwd=c(2.5,2.5,2.5), lty=c(1,6,3) , cex=0.89)

plot(x,producersurplus_pc, type="b", col="blue",lty=1,lwd=2.5, xlab = "Prosumer's Zero Marginal Cost Renewable Output (MW)", ylab = "Producer Surplus (K$)",font=2, font.lab=2)
lines(x,producersurplus_mp, type="b", pch=22, lty=6,lwd=2, col="red")
lines(x,producersurplus_mpec, type="b", pch=5, lty=6,lwd=2, col="orange")
abline(col="brown",v=106)
legend(106.22, 41, legend = c("PC","Cournot", "Stackelberg"),col=c("blue","red","orange"),bty = "n",lwd=c(2.5,2.5,2.5), lty=c(1,6,3) , cex=0.89)

plot(x,iso_pc, type="b", col="blue",lty=1,lwd=2.5, xlab = "Prosumer's Zero Marginal Cost Renewable Output (MW)", ylab = "ISO Revenue (K$)",font=2, font.lab=2)
lines(x,iso_mp, type="b", pch=22, lty=6,lwd=2, col="red")
lines(x,iso_mpec, type="b", pch=5, lty=6,lwd=2, col="orange")
abline(col="brown",v=106)
legend(106.22, 10, legend = c("PC","Cournot", "Stackelberg"),col=c("blue","red","orange"),bty = "n",lwd=c(2.5,2.5,2.5), lty=c(1,6,3) , cex=0.89)

plot(x,cs_pc, type="b", col="blue",lty=1,lwd=2.5, xlab = "Prosumer's Zero Marginal Cost Renewable Output (MW)", ylab = "Consumer Surplus (K$)",font=2, font.lab=2)
lines(x,cs_mp, type="b", pch=22, lty=6,lwd=2, col="red")
lines(x,cs_mpec, type="b", pch=5, lty=6,lwd=2, col="orange")
abline(col="brown",v=106)
legend(106.22, 256.2, legend = c("PC","Cournot", "Stackelberg"),col=c("blue","red","orange"),bty = "n",lwd=c(2.5,2.5,2.5), lty=c(1,6,3) , cex=0.89)

plot(x,sw_pc, type="b", col="blue",lty=1,lwd=2.5, xlab = "Prosumer's Zero Marginal Cost Renewable Output (MW)", ylab = "Social Surplus (K$)",font=2, font.lab=2)
lines(x,sw_mp, type="b", pch=22, lty=6,lwd=2, col="red")
lines(x,sw_mpec, type="b", pch=5, lty=6,lwd=2, col="orange")
abline(col="brown",v=106)
legend(106.22, 306, legend = c("PC","Cournot", "Stackelberg"),col=c("blue","red","orange"),bty = "n",lwd=c(2.5,2.5,2.5), lty=c(1,6,3) , cex=0.89)


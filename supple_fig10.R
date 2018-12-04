#!/usr/bin/R

# nlsLM
library(ggplot2)
library(minpack.lm)
scar.rates <- read.csv("./supple_fig4_input_rep23_new.csv",stringsAsFactors = F)
fit.function <- function(x,l, a) { a *exp(l*x)  }
fit.all <- nlsLM( Scar ~ fit.function(Timepoint,l, a),
                data = scar.rates, 
                start = list(l=-0.4, a = 90))
fit.all.parameters <- as.list(summary(fit.all)[10][[1]][,1])


ggplot(scar.rates) +
  geom_point(aes(x = Timepoint, y = Scar, colour=factor(replicat), shape=factor(replicat), size=2)) +
  stat_function(fun = fit.function, args=fit.all.parameters, color="black") + scale_y_continuous(limits = c(0, 100)) +
  labs(y = "Percentage wildtype", x = "Time (h)") +
  theme(text = element_text(size = 12),
        axis.text = element_text(size = 10))
  
  
  
                xlim = c(0, extend.time.to)) +
  scale_x_continuous(limits = c(0, extend.time.to))+
  scale_y_continuous(limits = c(0, 100)) +
  labs(y = "Percentage wildtype", x = "Time (h)") +
  theme(text = element_text(size = 8),
        axis.text = element_text(size = 6))
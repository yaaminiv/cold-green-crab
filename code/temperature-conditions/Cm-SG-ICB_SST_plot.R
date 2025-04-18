#!/usr/bin/env Rscript

library(data.table)
library(ggplot2)

site_cols = c("#d01c8b", "#b8e186", "#4dac26")

data = fread("Cm-SG-ICB_2021-2024.csv")

dat = data[,.(mean=mean(Mean), min = min(Mean), max = max(Mean)), by = .(Site, Month)]

dat$Month = as.character(dat$Month)
dat$Month = ordered(dat$Month, levels = c("1","2","3","4","5","6","7","8","9","10","11","12"), labels = c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"))

dat$Site = ordered(dat$Site, levels = c("WA", "MA", "ME"), labels = c("Willapa Bay, WA", "Buzzards Bay, MA", "Harpswell Sound, ME"))

SST_plot = ggplot(dat, aes(x=Month, y=mean, group = Site)) +
 geom_path(aes(color = Site), linewidth = 2) +
 geom_ribbon(aes(x = Month, ymin = min, ymax = max, fill = Site), alpha = 0.5) +
 theme_bw() +
 scale_color_manual(values = site_cols) +
 scale_fill_manual(values = site_cols) +
 theme(axis.title.y = element_text(size=20, angle = 90), axis.text.y  = element_text(size=16), axis.text.x  = element_text(size=14)) +
 theme(axis.title.x = element_text(size=20)) +
 theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
# theme(legend.position="none") +
 ylab("Temperature (°C)")

print(SST_plot)


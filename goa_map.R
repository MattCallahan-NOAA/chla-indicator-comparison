#script to make a map of the gulf of alaska
library(tidyverse)
library(sf)
library(AKmarineareas)
library(marmap)

#get bathymetry
r.ak <- getNOAA.bathy(lon1=-170,lon2=-147,lat1=49,lat2=60, resolution=10)
#converting to a raster, works better with ggplot and for subsetting
#depths positive
r.ak2 <- marmap::as.raster( r.ak)*-1


#convert to contour
depth_c<-rasterToContour(r.ak2, levels=c(200))%>%
  st_as_sf()

ak<-AK_basemap()
nmfs<-AK_marine_area()%>% filter(NMFS_REP_AREA %in% c(610,620,630))

#plot
png("goa_depth_map.png")
ggplot()+
  geom_sf(data=nmfs, fill=NA)+
  #geom_sf(data=depth_c, aes(color=level))+
  geom_sf(data=depth_c, color="dark blue")+
  geom_sf(data=ak)+
  coord_sf(xlim=c(-175,-145),ylim=c(48,61))+
  #scale_color_manual(values=c("light blue",  "dark blue", "blue"))+
  ggtitle("NMFS 610-630 with 200m depth contour (blue)")+
  theme_bw()
dev.off()

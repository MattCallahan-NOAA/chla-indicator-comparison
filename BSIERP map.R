require(AKmarineareas)
require(tidyverse)
require(sf)

adfg<-AK_marine_area(area="ADFG Stat Area", prj="prj")
bsierp<-AK_marine_area(area="BSIERP Region", prj="prj")%>%
  filter(BSIERP_Region_Name%in% c("AK peninsula", "South middle shelf", "Pribilofs", "Central middle shelf"))
AK<-AK_basemap()%>%
  st_transform(crs=3338)

test<-st_bbox(bsierp)

ggplot()+
  geom_sf(data=AK)+
  geom_sf(data=bsierp, color="red", fill=NA, size=2)+
  geom_sf(data=adfg, fill=NA)+
  geom_sf_label(data=bsierp, color="red", aes(label=BSIERP_Region_Name))+
  coord_sf(xlim=c(test[1],test[3]), ylim=c(test[2], test[4]))+
  xlab("Longitude")+ylab("Latitude")+
  theme_bw()

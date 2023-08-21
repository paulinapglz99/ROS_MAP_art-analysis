#Explorando base de datos bibliografica ROS y MAP

#Librerias

pacman::p_load("vroom",
       "dplyr",
       "ggplot2", 
       "patchwork")

#cargando datos

ROS <- vroom("ROS1300.csv")
MAP <- vroom("MAP.csv")

#Conteo 

conteo_anio_ROS <- ROS %>%  
  count(Publication_Year)

conteo_anio_MAP <- MAP %>%  
  count(Publication_Year)

#grafico sencillo para ambos

plot_art_xanio_ROS <- conteo_anio_ROS %>% 
  ggplot(mapping = (aes (x = Publication_Year,
                                   y = n))) + 
  geom_point(aes(size = 5)) +
  scale_x_continuous(breaks = seq(1992, 2023, by = 1)) + 
  scale_y_continuous() +
  labs( title = "Artículos ROS",
        x = "Año de publicación", 
        y = "Número de artículos") +
  theme_bw()


plot_art_xanio_MAP <- conteo_anio_MAP %>% 
  ggplot(mapping = (aes (x = Publication_Year,
                         y = n))) + 
  geom_point(aes(size = 5)) +
  scale_x_continuous(breaks = seq(2003, 2023, by = 1)) + 
  scale_y_continuous() +
  labs( title = "Artículos MAP",
        x = "Año de publicación", 
        y = "Número de artículos") +
  theme_bw()

#Vis

plots <- plot_art_xanio_ROS / plot_art_xanio_MAP

plots

#Analisis de omics

#quiero analizar que filas contienen una palabra de una librería de palabras en la columna de  automatic_tags

term_library <- c('omic | equence | RNA | transcript | enotype |
               gene | PCR | allele | DNA | Array | array | ifferential | xpression |
               nucleic | SNP | ucleotide')

ROS_omics <- ROS %>% 
  filter(grepl(term_library, automatic_tags))


MAP_omics <- MAP %>% 
  filter(grepl(term_library, automatic_tags))

###esta parte aun no la figuro, siguiente comit

ROSMAP_omics <- merge(x = ROS_omics, 
                      y = MAP_omics,
                     all = T) %>% 
  group_by(Title, Publication_Year, DOI, extra, link) %>% 
  summarise() %>% 
  arrange(Publication_Year)

#saving new datasets 

write.csv(ROSMAP_omics,
            file= "D:\\palin\\Documents\\UNAM_POSGRADO\\ROSMAP\\ROSMAP_omics.csv",
          row.names= T, 
          quote = F)

#saving plots

ggsave( filename = "arts_ROS_MAP.png",     
        plot = plots,                   
        device = "png",                           
        width = 18, height = 7, units = "in",     
        dpi = 300 ) 


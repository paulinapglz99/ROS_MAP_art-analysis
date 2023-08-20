#Explorando base de datos bibliografica ROS y MAP

#Librerias

library("pacman")
p_load("vroom",
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

#saving plot

ggsave( filename = "arts_ROS_MAP.png",     
        plot = last_plot(),                   
        device = "png",                           
        width = 18, height = 7, units = "in",     
        dpi = 300 ) 


#Analisis de omics


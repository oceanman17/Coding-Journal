Data Visualization Final Exam
================
Kelin Pan
October 8, 2018

R Markdown
----------

################################################################################ 

Title: BAN 6035: Data Visualization Final Exam
==============================================

Date: "October 8, 2018"
=======================

################################################################################ 

YOUR NAME: Kelin Pan
====================

################################################################################ 

INSTRUCTIONS
============

The script to load the packages and import the data are given below.
====================================================================

Follow the instructions to make the charts below.
=================================================

################################################################################ 

``` r
knitr::opts_chunk$set(echo=T)
library(tidyverse)
```

    ## -- Attaching packages ----------------------------------------------------------- tidyverse 1.2.1 --

    ## v ggplot2 3.0.0     v purrr   0.2.5
    ## v tibble  1.4.2     v dplyr   0.7.6
    ## v tidyr   0.8.1     v stringr 1.3.1
    ## v readr   1.1.1     v forcats 0.3.0

    ## -- Conflicts -------------------------------------------------------------- tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(readxl)
listingsAll <- read.csv("dc_listings_exam2018_v2.csv")
```

################################################################################ 

1. Bar Chart (8pts)
===================

Make a clustered (side-by-side) bar chart to show the average price for each
============================================================================

property type and room type. See Q1\_bar.png for the screenshot.
================================================================

- Filter the Property type by "Apartment", "Condominium", "House", "Townhouse"
==============================================================================

- Filter the price &lt;= 1000
=============================

- Use the RColor Brewer palette "Blues".
========================================

- Use size 8 font for the caption and size 10 for the subtitle
==============================================================

- Remove the gridlines for the x-axis
=====================================

- Use theme\_minimal()
======================

``` r
listingsAll%>%
  filter(property_type%in%c("Apartment","Condominium","House","Townhouse"))%>%
  filter(price<=1000)%>%
  group_by(property_type,room_type)%>%
  summarise(avg_price=mean(price,na.rm=T))%>%
  ggplot(aes(x=property_type,y=avg_price))+
  geom_bar(aes(fill=room_type),stat="identity",position="dodge")+
  scale_fill_brewer(palette="Blues")+
  theme_minimal()+
  labs(x = "Property Type", y="Average Price",
       title="Average Price by Property Type and Room Type",
       subtitle="Restricted to Apartments, Houses, Townhouses and Condos listed at <= $1,000.",
       caption="Source: Inside Airbnb",
       fill="Room Type") +
  theme(legend.position = "bottom",
        axis.ticks = element_blank(),
        plot.title = element_text(size=18, hjust=0.5), # Centered Title
        panel.border = element_blank(),
        panel.grid.minor.y = element_line(color="grey80"),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(color="grey85"),
        panel.grid.major.x = element_blank(),
        axis.title = element_text(face="bold"),
        plot.subtitle = element_text(size=10,face="italic",hjust=0.3),
        plot.caption=element_text(size=8))
```

![](data_visualization_for_Airbnb_data_files/figure-markdown_github/unnamed-chunk-2-1.png)

################################################################################ 

2. Scatterplot (8pts)
=====================

Make a scatterplot of price and the accomodates variable to see the
===================================================================

relationship between price and maximum guests. See Q2\_scatterplot.png for the screenshot.
==========================================================================================

- Filter the Property type by "Apartment", "Condominium", "House", "Townhouse"
==============================================================================

- Color the points by the room type
===================================

- Use the following colors for the room types: "royalblue", "grey60", "mediumpurple.
====================================================================================

- Use size 8 font for the caption and size 10 for the subtitle
==============================================================

- Use alpha = 0.5 for the transparency
======================================

- Change the labels on the y-axis to be the character "$1,000", "$2,000", etc.
==============================================================================

- Change the breaks on the x-axis
=================================

- Use theme\_minimal()
======================

``` r
listingsAll%>%
  filter(property_type%in%c("Apartment","Condominium","House","Townhouse"))%>%
  ggplot(aes(x=accommodates,y=price))+
  geom_point(aes(color=room_type),alpha=0.5)+
  scale_color_manual(breaks=c("Entire home/apt","Private room","Shared room"),
                     values=c("royalblue", "grey60", "mediumpurple"))+
  scale_y_continuous(breaks=seq(0,6000,by=1000)
                     ,labels=c("0","$1000","$2000","$3000","$4000","$5000","$6000"))+
  scale_x_continuous(breaks=seq(0,16,by=1))+
  theme_minimal()+
  labs(x = "Acommodates", y="Price",
       title="Price vs. Maximum Accomodations",
       subtitle="Restricted to Apartments, Houses, Townhouses and Condos",
       caption="Source: Inside Airbnb",
       color="Room Type") +
  theme(legend.position = "bottom",
        axis.ticks = element_blank(),
        plot.title = element_text(size=18, hjust=0.5), # Centered Title
        panel.border = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(color="grey95"),
        panel.grid.major.x = element_blank(),
        axis.title = element_text(face="bold"),
        plot.subtitle = element_text(size=10,face="italic",hjust=0.3),
        plot.caption=element_text(size=8))
```

![](data_visualization_for_Airbnb_data_files/figure-markdown_github/unnamed-chunk-3-1.png)

################################################################################ 

3. Distributions (8pts)
=======================

Compare the distribution of prices for each property type using boxplots.
=========================================================================

There should be a different box for each value of property type, and the points
===============================================================================

should be on the plot as well. See Q3\_boxplot.png for the screenshot.
======================================================================

- Filter the Property type by "Apartment", "Condominium", "House", "Townhouse"
==============================================================================

- Filter the price &lt;= 1000
=============================

- Use the colors "lightsteelblue" and "steelblue" for the boxplot colors and the points respectively
====================================================================================================

- Make the boxplot transparency 0.5, no outliers
================================================

- Make the point transparency 0.05
==================================

- Use size 8 font for the caption and size 10 for the subtitle
==============================================================

``` r
  listingsAll%>%
  filter(property_type%in%c("Apartment","Condominium","House","Townhouse"))%>%
  filter(price<=1000)%>%
  ggplot()+
  coord_flip()+
  geom_boxplot(aes(x=property_type,y=price),fill="lightsteelblue",alpha=0.5,outlier.shape=NA)+
  geom_jitter(aes(x=property_type,y=price),color="steelblue",alpha=0.05)+
  theme_bw()+
  theme(legend.position = "bottom",
        axis.ticks = element_blank(),
        plot.title = element_text(size=18, hjust=0.5), 
        panel.border = element_blank(),
        panel.grid.minor.y = element_line(color="grey80"),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(color="grey85"),
        panel.grid.major.x = element_blank(),
        axis.title = element_text(face="bold"),
        plot.subtitle = element_text(size=10,face="italic",hjust=0.6),
        plot.caption=element_text(size=8))+
  labs(x = "Property Type", y="Price",
       title="Distribution of Price by Property Type",
       subtitle="Restricted to Apartments, Houses, Townhouses and Condos listed at <= $1,000.",
       caption="Source: Inside Airbnb")
```

![](data_visualization_for_Airbnb_data_files/figure-markdown_github/unnamed-chunk-4-1.png)

################################################################################ 

4. Heatmap (8pts)
=================

Compare the number of listings of each property type and room type
==================================================================

using a heatmap. See Q4\_heatmap.png for the screenshot.
========================================================

- Use the colors "white" and "royalblue" as the low and high values
===================================================================

- Use size 8 font for the caption and size 10 for the subtitle
==============================================================

- Place the legend on the right-hand side
=========================================

- Reorder the y-axis by the total number of listings
====================================================

- Remove NAs
============

``` r
listingsAll%>%
  group_by(property_type,room_type)%>%
  count()%>%
  #na.omit()%>%
  complete(room_type,property_type, fill = list(n = 0))%>%
  ggplot(aes(x=room_type,y=property_type))+
  geom_tile(aes(fill=n),color="white")+
  scale_fill_continuous("Listing",
                        low="white", high="royalblue")+ 
  theme_minimal()+
  labs(x = "Acommodates", y="Price",
       title="Number of Airbnb Listing by Type",
       caption="Source: Inside Airbnb",
       fill="Listings") +
  theme(
        axis.ticks = element_blank(),
        plot.title = element_text(size=18, hjust=0.5), # Centered Title
        panel.border = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(color="grey95"),
        panel.grid.major.x = element_blank(),
        axis.title = element_text(face="bold"),
        plot.subtitle = element_text(size=10,face="italic",hjust=0.3),
        plot.caption=element_text(size=8))
```

![](data_visualization_for_Airbnb_data_files/figure-markdown_github/unnamed-chunk-5-1.png)

################################################################################ 

5. Insight (8pts)
=================

The following question asks you to come up with one insight on specific
=======================================================================

elements of the Airbnb data. This chart will be graded according to the following dimensions:
=============================================================================================

- Is the chart technically correct? - 4 pts
===========================================

- Does it contain data errors?
==============================

- Does it contain the appropriate elements?
===========================================

- Is your conclusion sound? - 2pt
=================================

- Is the graph attractive? - 1pt
================================

- How sophisticated is your graph? - 1pt
========================================

################################################################################ 

Prompt:
=======

I am considering listing a 1-bed, 1-bath property on Airbnb, and I
==================================================================

want to know what elements of the listing are associated with high
==================================================================

reviews. Tell me something useful about the relationship between
================================================================

review score and price, cleaning\_fee, guests, extra people,
============================================================

max accommodations, room type, bed type and/or neighborhood.
============================================================

``` r
listingsAll%>%
  ggplot(aes(x=room_type,y=review_scores_rating))+
  geom_boxplot(fill="lightsteelblue",alpha=0.5,outlier.shape=NA)+
  theme_bw()+
  theme(legend.position = "bottom",
        axis.ticks = element_blank(),
        plot.title = element_text(size=18, hjust=0.5), 
        panel.border = element_blank(),
        panel.grid.minor.y = element_line(color="grey80"),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(color="grey85"),
        panel.grid.major.x = element_blank(),
        axis.title = element_text(face="bold"),
        plot.subtitle = element_text(size=10,face="italic",hjust=0.6),
        plot.caption=element_text(size=8))+
  labs(x = "Room Type", y="Review Score Rating",
       title="Distribution of Review Score Rating by Room Type",
       caption="Source: Inside Airbnb")
```

    ## Warning: Removed 2207 rows containing non-finite values (stat_boxplot).

![](data_visualization_for_Airbnb_data_files/figure-markdown_github/unnamed-chunk-6-1.png) \# shared room's review is lower than the other two

################################################################################ 

EXAM END
========

################################################################################

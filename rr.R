---
title: "Basic Plotting in R"
author: "Daryl DeFord"
output:
  html_document:
    df_print: paged
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Introduction
This R script provides some basic examples of plotting in R. We will start by loading in our packages and some data to work with. For each of the classes of plots below, the section will provide a brief description of its basic properties and then construct some examples using the base R plotting functions and ggplot2. For all of these examples there are *many* more parameters that can be adjusted, including colors, symbols, labels, etc. We will continue to explore these variants throughout the semester but for now are mostly interested in examining the basic syntax of the plotting functions and libraries.

```{r loaddata}
library("tidyverse")
HWAS <- read.csv("Height_Weight_Age_Sex.csv")
head(HWAS)s
HWAS$mf = factor(HWAS$male)
head(HWAS)
ecd <- economics
head(ecd)
```



## Scatterplots

Scatterplots are used to look at the relationship between two continuous variables in a dataset. Each row is represented by a point with coordinates (x,y) where the x values is the first column referenced and the y value is the second column referenced. In the examples below, the height and weight of individuals in the HWAS dataset are plotted against each other. 

```{r base_scatter_1}

plot(HWAS$height ~ HWAS$weight, xlab="Weight (kg)", ylab="Height (cm)",main= "Height vs. Weight")

```
The ggplot2 version requires a little more syntax but will give us much more flexibility later on: 

``` {r gg_scatter1}

ggplot(data = HWAS, mapping = aes(x=weight, y=height)) + geom_point()

```
``` {r gg_scatter2}

ggplot(data = HWAS, mapping = aes(x=weight, y=height, size = age, color = male)) +
 geom_point()


ggplot(data = HWAS, mapping = aes(x=weight, y=height,  color = mf, shape = mf)) + geom_point(size=3) 


ggplot(data = HWAS, mapping = aes(x=weight, y=height,  color = mf, shape = mf)) + geom_point(size=3) + geom_smooth(data = HWAS, mapping = aes(x=weight, y=height))



```

For the base R plot function, this is a default plot for numeric types. If more then two columns are provided, a scatter matrix is created, making an individual scatterplot for all pairwise comparisons. If only a single column is provided, the values are plotted on the y-axis, with the order along the x-axis just being the ordering of the rows in the dataframe. 
```{r base_scatter2}

plot(HWAS)

plot(economics$pop,ylab="Population",xlab="DataFrame Index",col="orange")

```
## Line Plots

Line plots are similar to scatterplots in construction, except the points are connected by lines. While the construction is similar, this implies an ordering in the rows of the dataframe (i.e. which points get connected to which), so requires some additional structure. This is most commonly used when the x variable is representing something like time or when there is a natural ordering. Usually we think of this as displaying the values of the y-axis points at the values of the x-axis points. 

These example plots show the unemployment rate over time from the economics dataset. 

``` {r base_line1}

plot(ecd$unemploy,type="l",ylab="Unemployment Rate",xlab="Month",col="green")
```

``` {r ggline1}
ggplot(ecd, aes(x=seq(574),y=unemploy,color="pink")) +
  geom_line()+
  xlab("Month")+ylab("Unemployment Rate")+
  ggtitle("Unemployment Rate over Time")
```
## Histograms
A histogram is a collection of rectangles whose heights represent the number of data points that falls into a bin. The location of the base of the rectangle defines the width and position of the bin and the height above that base is the number of data points that lie in that region. This is a particularly important type of plot for showing the distribution of values in a single continuous column. 

The examples below show the distributions of heights and weights in the whole HWAS dataset. 

```{r basehist}

hist(HWAS$weight, main = "Weight Distribution")

```
```{r basedensity}

plot(density(ecd$pop))

```



```{r gghist1}
ggplot(HWAS, aes(x=height)) + 
  geom_histogram()
```


```{r gghist2}
ggplot(HWAS[HWAS$age>20,], aes(x=height)) + 
  geom_histogram(aes(y = ..density..), binwidth=4) + 
  geom_density(color="green",fill="pink",alpha=.4,size=2)
```
## Box Plots

Box plots show summaries of distributions of data (specifically, the Tukey 5 number summary we will discuss next week), usually separated over a categorical variable to compare subsets of a full dataset. 

``` {r basebox}

boxplot(HWAS$weight ~ HWAS$mf)

boxplot(HWAS$height ~ HWAS$mf)


```

``` {r ggbox}

ggplot(data = HWAS, mapping = aes(x=mf, y=height)) + geom_boxplot()  

ggplot(data = HWAS, mapping = aes(x=mf, y=height)) + geom_boxplot() + geom_jitter()


```
## Bar Charts

Bar charts present the values associated to categorically grouped data, where the height of the bar (or length if it is horizontal) represents the magnitude of the value. A common use case for us will be using these plots to represent counts of categorical occurrences in our datasets, like in the examples below, but bar plots can also be used to represent continuous values associated to groups. 

``` {r basebar}

barplot(table(HWAS$male))

```


``` {r ggbar}

ggplot(data = HWAS) + 
  geom_bar(mapping = aes(x = mf))

```

``` {r ggplotbar2}
library(tidyverse)
new_df = data.frame(
  names = c("Skye","Izzy","Nermal"),
  ages = c(11,15,4)
)

barplot(new_df$ages,names=new_df$names)

ggplot(data = new_df, mapping = aes(x=names,y=ages)) + 
  geom_col()

ggplot(data = new_df, mapping = aes(x=names,y=ages)) + 
  geom_col() +
   theme_classic()

ggplot(data = new_df, mapping = aes(x=reorder(names,ages),y=ages)) + 
  geom_col()


```




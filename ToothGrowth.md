---
title: "Exploring The ToothGrowth Dataset"
author: "Georges Bodiong"
date: "Sunday, February 22, 2015"
output: html_document
---

This document is the second part of the Coursera Statistical Inference Course project. It is an analysis of the ToothGrowth dataset in R. The ToothGrowth dataset explains the relation between the growth of teeth of guinea pigs at each of three dose levels of Vitamin C (0.5, 1 and 2 mg) with each of two delivery methods(orange juice and ascorbic acid).

### Let's start by loading the data and performing some basic exploratory data analysis
```{r}
library(psych)
library(ggplot2)
library(gridExtra)
library(datasets)
data(ToothGrowth)
attach(ToothGrowth)

supp_plot<-ggplot(aes(x = supp, y = len), data = ToothGrowth) + geom_boxplot(aes(fill = supp))

dose_plot<-ggplot(aes(x = factor(dose), y =len), data = ToothGrowth) + 
        geom_boxplot(aes(fill = factor(dose)))

grid.arrange(supp_plot, dose_plot, ncol = 2)
```
### Summary of data

```{r}
require(graphics)
coplot(len ~ dose | supp, data = ToothGrowth, panel = panel.smooth,
       xlab = "ToothGrowth data: length vs dose, given type of supplement")
```
```{r}
head(ToothGrowth, 5)

summary(ToothGrowth)
```
```{r}
dose<-as.factor(dose)
describe(len)
```
```{r}
table(supp,dose)
```
```{r}
round(with(ToothGrowth, sapply(split(len, supp), mean)), 3)
```
```{r}
aggregate(len, list(dose), mean)
```
```{r}
aggregate(len, list(supp, dose), mean)
```
```{r}
aggregate(len, list(supp, dose), sd)
```

### Confidence intervals and hypothesis test to compare tooth growth by supp and dose

```{r}
# T Test by supplemant type
t.test(len ~ supp, data = ToothGrowth)
```
```{r}
# T test by dose level 
Tooth.dose0.5_1.0 <- subset(ToothGrowth, dose %in% c(0.5, 1.0))
Tooth.dose0.5_2.0 <- subset(ToothGrowth, dose %in% c(0.5, 2.0))
Tooth.dose1.0_2.0 <- subset(ToothGrowth, dose %in% c(1.0, 2.0))

t.test(len ~ dose, data = Tooth.dose0.5_1.0)
```
```{r}
t.test(len ~ dose, data = Tooth.dose0.5_2.0)
```
```{r}
t.test(len ~ dose, data = Tooth.dose1.0_2.0)
```
```{r}
# T test for supplement by dose level
Tooth.dose0.5 <- subset(ToothGrowth, dose == 0.5)
Tooth.dose1.0 <- subset(ToothGrowth, dose == 1.0)
Tooth.dose2.0 <- subset(ToothGrowth, dose == 2.0)

t.test(len ~ supp, data = Tooth.dose0.5)
```
```{r}
t.test(len ~ supp, data = Tooth.dose1.0)
```
```{r}
t.test(len ~ supp, data = Tooth.dose2.0)
```

For dose 0.5, the p-value of OJ in comparison to VC is 0.0064. Since it is less than 0.05 (strong presumption against null hypothesis), it means that there is a difference between both methods.

For dose 1.0, the p-value of OJ in comparison to VC is 0.001. Since it is less than 0.05 (strong presumption against null hypothesis), it means that there is a difference between both methods.

For dose 2.0, the p-value of OJ in comparison to VC is 0.064. Since it is greater than 0.05 (low presumption against null hypothesis), it means that there is a no that much of a difference between both methods.

### conclusions and underlying assumptions.

From the values, we can assume that there is an increase in tooth growth depending on the doses. There seems to be no other factor affecting the growth pattern. The delivery methods are independent of the dose size.



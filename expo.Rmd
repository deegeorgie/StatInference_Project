---
title: "Statistical Inference course project"
author: "Georges Bodiong"
date: "Saturday, February 21, 2015"
output:
  word_document: default
  html_document:
    highlight: espresso
    theme: journal
---

## Overview

This is the project for the Coursera Statistical Inference class. We will use simulation to explore inference and do some basic inferential data analysis. There are two parts:

+ A simulation exercise

+ Basic inferential analysis

## Simulations

```{r}
#set lambda to 0.2
lambda = 0.2

# 40 samples
n = 40

# A thousand simulations
sims <- 1000

# Set seed for reproducibility
set.seed(820)

# Simulate 
sim_expo <- replicate(sims, rexp(n, lambda))

# Calculate mean of exponentials
means_expo <- apply(sim_expo, 2, mean)

head(means_expo)
```

Calculate simulation mean to show where the simulation is centered at and compare it to theoretical center.

```{r, echo=TRUE}
dist_mean <- mean(means_expo)
dist_mean
```

```{r}
theo_mean <- 1/lambda
theo_mean
```
```{r}
# Let's visualise it...
hist(means_expo, xlab = "mean", main = "Exponential Function Simulations")
abline(v = dist_mean, col = "blue")
abline(v = theo_mean, col = "red")
```

The analytical mean here is `r dist_mean` and the theoretical mean `r theo_mean`. The two averages are very close.

## Variability
```{r}
# standard deviation of distribution
stand_dev <- sd(means_expo)
stand_dev
```
```{r}
# standard deviation from analytical expression
theo_sd <- (1/lambda)/sqrt(n)
theo_sd
```
```{r}
# variance of distribution
dist_var <- stand_dev^2
dist_var
```
```{r}
#variance from analytical expression
theo_var <- ((1/lambda) * (1/sqrt(n)))^2
theo_var
```

The standard deviation of the distribution is `r stand_dev` and the theoretical standard deviation is `r theo_sd`. The theoretical variance is `r theo_var` while the actual variance of the distribution is `r dist_var`.

## Is the distribution approximately normal?
```{r}
xfit <- seq(min(means_expo), max(means_expo), length=100)
yfit <- dnorm (xfit, mean=1/lambda, sd=(1/lambda/sqrt(n)))
hist(means_expo, breaks=n, prob=T, col="green", xlab="means", main="density of means", ylab="density")
lines(xfit, yfit, pch=22, col="black", lty=5)
```

Let's compare distribution of averages of 40 exponentials to normal distribution

```{r}
qqnorm(means_expo)
qqline(means_expo, col=2)
```

It is obvious that the distribution is close to normal.

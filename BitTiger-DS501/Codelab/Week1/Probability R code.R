mu = 30
sigma = 2
a = 0
b = 32

par(mfrow=c(3,1))

# simulate samples 
x = rnorm(10000, mu, sigma)
hist(x, prob=TRUE,breaks = 100, xlim = c(20, 40))
lines(density(x))

# only get the samples <= ruler length
xt = x[x<=b]
hist(xt, prob=TRUE,breaks = 100, xlim = c(20, 40))
lines(density(xt))
abline(v = b, lty = 2, col = 'red', lwd = 2)

# if know % discarded
pct_miss = 1 - length(xt) / length(x)
xtsort = sort(xt)
xtsort = xtsort[-(1:(length(x) * pct_miss))]
length(xtsort)
hist(xtsort,xlim = c(20, 40), breaks = 50, prob = TRUE)
lines(density(xtsort))
abline(v = b, lty = 2, col = 'red', lwd = 2)
abline(v = mu-(b-mu), lty = 2, col = 'red', lwd = 2)
mean(xtsort)



# show mean
mean(xt)
mean(x)

# calculation
alpha = (a - mu)/sigma
beta = (b - mu)/sigma

# if do not know % discarded
mu + sigma * (dnorm(alpha) - dnorm(beta))/(pnorm(beta)-pnorm(alpha))
Emu = mean(xt) - sigma * (dnorm(alpha) - dnorm(beta))/(pnorm(beta)-pnorm(alpha))
Emu
mu

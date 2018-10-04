##Question 1
out=read.csv("minicase1_data.csv")
class(out)
mean_MSFT=12*mean(out[,2])
var_MSFT=12*var(out[,2])
sd_MSFT=sd(out[,2])*sqrt(12)
print(paste0("mean of Microsoft is ",mean_MSFT))
print(paste0("variance of Microsoft is ",var_MSFT))
print(paste0("standard deviation of Microsoft is ",sd_MSFT))

mean_GM=12*mean(out[,3])
var_GM=12*var(out[,3])
sd_GM=sd(out[,3])*sqrt(12)
print(paste0("mean of general motors is ",mean_GM))
print(paste0("variance of general motors is ",var_GM))
print(paste0("standard deviation of general motors is ",sd_GM))

cov_MG=12*cov(out[,2],out[,3])
print(paste0("covariance of general motors and microsoft is ",cov_MG))
correlation= cov_MG/(sd_MSFT*sd_GM)
print(paste0("correlation of general motors and microsoft is ",correlation))

##Question 2

x_sd=double(1000)
y_mean=double(1000)
for(i in 1:1000){
  x=i/1000
  x_sd[i]=sqrt(var_MSFT*x*x + (var_GM*(1-x)*(1-x))+ 2*x*(1-x)*cov_MG)
  y_mean[i]=x*mean_MSFT + (1-x)*mean_GM
  
}
plot(x_sd,y_mean,col="green",xlim=c(0,.4),ylim = c(0,.4))

##Question 3
#$$w_x = (\sigma_y^2 - \sigma_x_y) / (\sigma_x^2 + \sigma_y^2 - 2\sigma_x_y)$$
 # $$w_y = 1 - w_x$$

sd_min=min(x_sd)
proportion_portfolio=which(x_sd==sd_min)/1000
mean_minvar=y_mean[proportion_portfolio*1000]
var_minvar=sd_min^2

w_msft=(var_GM-cov_MG)/(var_GM+var_MSFT-2*cov_MG)
w_gm=1-w_msft
# as we can see the w_msft is same as proportion_portfolio
mean_portfolio=w_msft*mean_MSFT + w_gm*mean_GM

##Question 4

rf=.02
w_tangency_msft=((mean_MSFT-rf)*(var_GM)-(mean_GM-rf)*cov_MG)/((mean_MSFT-rf)*var_GM+(mean_GM-rf)*var_MSFT-(mean_MSFT-rf +mean_GM-rf)*cov_MG)
w_tangency_gm=1-w_tangency_msft
x=w_tangency_msft
sd_tangency=sqrt(var_MSFT*x*x + (var_GM*(1-x)*(1-x))+ 2*x*(1-x)*cov_MG)
mean_tangency=x*mean_MSFT + (1-x)*mean_GM

sharpe_ratio_tangency=(mean_tangency-rf)/sd_tangency

##Question 5
y=4
w_optimal_tangency=(mean_tangency-rf)/(y*(sd_tangency^2))
w_risk_free=1-w_optimal_tangency

w_optimal_tangency_msft=w_optimal_tangency*w_tangency_msft
w_optimal_tangency=w_optimal_tangency*w_tangency_gm

##Question 6
e=.25
w_expected_tangency=(e-rf)/(mean_tangency-rf)
w_expected_risk_free=1-w_expected_tangency
sd_portfolio=w_expected_tangency*sd_tangency
w_expected_msft=w_tangency_msft*w_expected_tangency
w_expected_gm=w_tangency_gm*w_expected_tangency

##Question 7

w_portfolio_msft=(e-mean_GM)/(mean_MSFT-mean_GM)
w_portfolio_gm=1-w_portfolio_msft
x=w_portfolio_msft
sd_portfolio=sqrt(var_MSFT*x*x + (var_GM*(1-x)*(1-x))+ 2*x*(1-x)*cov_MG)

##Question 8
w_50_msft=(.50-mean_GM)/(mean_MSFT-mean_GM)
w_50_gm=1-w_50_msft
x=w_50_msft
sd_portfolio=sqrt(var_MSFT*x*x + (var_GM*(1-x)*(1-x))+ 2*x*(1-x)*cov_MG) #.5855


w_50_tangency=(.50-rf)/(mean_tangency-rf)
sd_portfolio=w_50_tangency*sd_tangency #.5396
w_risk_free=1-w_50_tangency

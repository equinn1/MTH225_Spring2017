//Compare means of two normal samples - equal standard deviations in each sample
data {
  int N;                          //sample size
  real y[N];                      //sample data
  int<lower=1,upper=2> group[N];  //group - should be 1 or 2
}
parameters {
  real mu[2];                     //location parameters (two parameters)
  real<lower=0> sigma;            //common standard deviation - only one parameter 
}
model {
  int j;
  mu ~ normal(0,100);             //normal priors for mu
  sigma ~ cauchy(0,50);           //half-cauchy prior for standard deviations 
  
  for(i in 1:N){                   
    	j=group[i];                  //get group number for this y value
      y[i] ~ normal(mu[j],sigma);  //liklihood:  normal with mean mu[j] and std deviation sigma[j]
  }
}
generated quantities {
  real diff_mu;                   //declare variable for difference mu[1]-mu[2]
  diff_mu=mu[1]-mu[2];            //get posterior sample of difference in mu values  
}

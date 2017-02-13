//Compare means of two normal samples - single data vector with indicator
data {
  int N;                          //sample size
  real y[N];                      //sample data
  int<lower=1,upper=2> group[N];  //group - should be 1 or 2
}
parameters {
  real mu[2];                  //location parameters (two parameters)
  real<lower=0> sigma[2];      //standard deviations (allow these to be different, so two parameters) 
}
model {
  int j;
  mu ~ normal(0,100);       //normal priors for mu
  sigma ~ cauchy(0,50);     //half-cauchy prior for standard deviations 
  
  for(i in 1:N){                   
    	j=group[i];                   //get group number for this y value
      y[i] ~ normal(mu[j],sigma[j]);  //liklihood:  normal with mean mu[j] and std deviation sigma[j]
  }
}
generated quantities {
  real diff_mu;                  //declare variable for difference mu[1]-mu[2]
  real diff_sigma;               //declare variable for difference sigma[1]-sigma[2]
  diff_mu=mu[1]-mu[2];           //get posterior sample of difference in mu values  
  diff_sigma=sigma[1]-sigma[2];  //get posterior sample of difference in sigma values
}

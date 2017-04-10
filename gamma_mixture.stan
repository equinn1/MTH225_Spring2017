data { 
  int<lower=1> N;               //number of observations
  real<lower=0> y[N];           //rainfall amount
} 
parameters {
  real<lower=0,upper=1> theta;  //probability of measurable rain
  real<lower=0> alpha;          //shape parameter for rainfall amount gamma
  real<lower=0> beta;           //scale parameter for rainfall amount gamma
} 
model {
  theta ~ beta(1,1);            //uniform prior for theta
  alpha ~ normal(0,5);          //half-normal prior for alpha
  beta ~ normal(0,5);           //half-normal prior for beta
  
  for (i in 1:N){
    if(y[i] < 0.0001) {           //no measurable rain
      target += log(1-theta);     //add log(p(0))         
    }
    else {                                //measurable rainfall
      target += log(theta)+gamma_lpdf(y[i] | alpha,beta);
    }
  }
}

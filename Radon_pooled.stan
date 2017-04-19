//Radon data - completely pooled
data {
  int<lower=0> N; 
  vector[N] x;
  vector[N] y;
}
parameters {
  vector[2] beta;
  real<lower=0> sigma;
} 
model {
  y ~ normal(beta[1] + beta[2] * x, sigma);
}
generated quantities {
  real ypred0;                      #simulated y value - basement
  real ypred1;                      #simulated y value - first floor
  real bpred0;                      #beta for basement
  real bpred1;                      #beta for first floor
  real diff;
  bpred0 = beta[1];                 #basement
  bpred1 = beta[1] + beta[2];       #first floor
  ypred0 = normal_rng(beta[1],sigma);            #y basement
  ypred1 = normal_rng(beta[1]+beta[2],sigma);    #y first floor
  diff = beta[1]-beta[2];                        #difference between basement and first floor
}

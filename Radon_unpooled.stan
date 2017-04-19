//Radon data - unpooled
data {
  int<lower=0> N; 
  int<lower=0> N_counties;
  int<lower=1,upper=N_counties> county[N];
  vector[N] x;
  vector[N] y;
} 
parameters {
  real a[N_counties];
  real beta;
  real<lower=0,upper=100> sigma_y;
} 
transformed parameters {
  vector[N] y_hat;
  for (i in 1:N){
    y_hat[i] = a[county[i]]+beta*x[i];
  }
}
model {
  beta ~ normal(0,5);
  a ~ normal(0,2);
  
  y ~ normal(y_hat,sigma_y);
}
generated quantities {
  real ypred0[N_counties];          #posterior predicted y value - basement
  real ypred1[N_counties];          #posterior predicted y value - first floor
  real yexp0[N_counties];           #expected y value - basement
  real yexp1[N_counties];           #expected y value - first floor

  for (i in 1:N_counties){
    yexp0[i] = a[i];
    yexp1[i] = a[i] + beta;
    ypred0[i] = normal_rng(a[i], sigma_y);
    ypred1[i] = normal_rng(a[i]+beta,sigma_y);
  }
}

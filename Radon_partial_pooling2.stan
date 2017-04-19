//Radon data - Partial pooling
data {
  int<lower=0> N;
  int<lower=0> N_counties;
  int<lower=1,upper=N_counties> county[N];
  vector[N] y;
  vector[N] x;
} 
parameters {
  vector[N_counties] a;
  real mu_a;
  vector[N_counties] beta;
  real mu_b;
  
  real<lower=0,upper=100> sigma_a;
  real<lower=9,upper=100> sigma_b;
  real<lower=0,upper=100> sigma_y;
} 
transformed parameters {
  vector[N] y_hat;
  for (i in 1:N)
    y_hat[i] = a[county[i]]+beta[county[i]]*x[i];
}
model {
  mu_a ~ normal(0, 1);
  a ~ normal(10* mu_a, sigma_a);
  mu_b ~ normal(0,1);
  beta ~ normal(10*mu_b,sigma_b);

  y ~ normal(y_hat,sigma_y);
}
generated quantities {
  real ypred0[N_counties];          #posterior predicted y value - basement
  real ypred1[N_counties];          #posterior predicted y value - first floor
  real yexp0[N_counties];           #expected y value - basement
  real yexp1[N_counties];           #expected y value - first floor

  for (i in 1:N_counties){
    yexp0[i] = a[i];
    yexp1[i] = a[i] + beta[i];
    ypred0[i] = normal_rng(a[i], sigma_y);
    ypred1[i] = normal_rng(a[i]+beta[i],sigma_y);
  }
}

//compare two proportions using a series of binomial trials as data
data {
  int N;                                //sample1 size
  vector[N] y;                          //y values 
  vector[N] x;                          //x values
  int<lower=1,upper=2> grp[N];          //group for this observation
}
parameters {
  real a;                               //common intercept
  real b[2];                            //slopes for two groups
  real<lower=0> sigma;                  //common standard deviation
}
model {
  a ~ normal(0,100);                    //normal prior for intercept
  b ~ normal(0,100);                    //normal priors for slopes
  sigma ~ cauchy(0,5);                  //half-cauchy for sigma
  
  for (i in 1:N) {
    y[i] ~ normal(a+b[grp[i]]*x[i],sigma);
  }
}

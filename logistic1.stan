data { 
  int N;               //number of months
  int n[N];            //days in this month
  int y[N];            //days with measurable rain
  real x[N];           //time scale
  int<lower=1,upper=12> m[N];   //month
} 
parameters {
  real beta0[12];
  real beta1;
} 
model {
  beta0  ~ normal(0,5);
  beta1  ~ normal(0,5);
  for (i in 1:N){
    y[i] ~ binomial_logit(n[i],beta0[m[i]]+beta1*x[i]);
  }
}





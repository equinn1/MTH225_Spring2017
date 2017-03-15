//model file for week8: Single factor ANOVA with a covariate
data {
  int N;                  //sample1 size
  int cartruck[N];        //car or truck
  real weight[N];         //number of levels
  real mpg[N];            //y values - nanoseconds
}
parameters {
  real car;               //car 
  real truck;             //truck
  real beta;              //beta is the slope of the parallel regression lines
  real<lower=0> sigma;             //residual standard error
}
model {
  car   ~ normal(0,100);        //normal priors for slope includes all reasonable mileage values
  truck ~ normal(0,100);      //slope will be very small with small standard deviation if weight is in pounds
  beta  ~ normal(0,100);      //slope will be very small with small standard deviation if weight is in pounds
  sigma ~ cauchy(0,10);       //half-Cauchy prior for residual standard error
  
  for (i in 1:N)                   //loop through y values
    if (cartruck[i]==1)  
      mpg[i] ~ normal(50.0+car+beta*weight[i],sigma);
    else 
      mpg[i] ~ normal(50.0+truck+beta*weight[i],sigma);
}

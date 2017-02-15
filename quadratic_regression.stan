//quadratic regression
data {
  int N;                              //sample size
  vector[N] y;                        //dependent variable
  vector[N] x;                        //independent variable
}
transformed data {
  vector[N] x2;                       //square of independent variable
  for (i in 1:N) {
    x2[i] = pow(x[i],2);              //compute squares using the pow()  (power) function
  }
}
parameters {
  real a;                             //intercept
  real b[2];                          //coefficients of x and x squared
  real<lower=0> sigma;                //error standard deviation
}
model {
  a ~ normal(0,100);                  //prior for intercept
  b ~ normal(0,10);                   //prior for coefficients of x and x squared
  sigma ~ cauchy(0,5);                //residual standard error
 
  y ~ normal(a+b[1]*x+b[2]*x2,sigma);
}



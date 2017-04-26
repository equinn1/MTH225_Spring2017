//Gaussian process simulation example from Users Guide V12.2.0
data {
  int D;
  int N;                                //sample1 size
  vector[D] x[N];                            //data values
}
transformed data{
  vector[N] mu;
  cov_matrix[N] Sigma;

  for (i in 1:N){
    mu[i] = 0;
    for (j in 1:N){
      Sigma[i,j] = exp(-dot_self(x[i]-x[j]));
      if (i==j) Sigma[i,i] = Sigma[i,i]+0.1;
    } 
  }
}
parameters {
  vector[N] y;                    //unobserved true value of x
}
model {
  y ~ multi_normal(mu, Sigma);
  
}

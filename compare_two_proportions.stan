//compare two proportions using a series of binomial trials as data
data {
  int N;                                //sample1 size
  int y[N];                             //y values - number of successes
  int trials[N];                        //number of trials
  int<lower=1,upper=2> grp[N];          //group for this trial
}
parameters {
  real p[2];                            //Parameters for the proportion of success
}
model {
  p ~ uniform(0,1);                //normal priors for two intercepts
  for (i in 1:N) {
    y[i] ~ binomial(trials[i],p[grp[i]]);
  }
}

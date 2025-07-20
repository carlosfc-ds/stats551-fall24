data {
  int<lower=0> N; // number of obs
  int<lower=0> K; // number of predictors
  int<lower=0,upper=1> y[N]; // outcomes
  matrix[N, K] x; // predictor variables
}
parameters {
  vector[K] beta; // beta coefficients
}
model {
  vector[N] mu; 
  beta ~ normal(0, 1.732);
  mu = x*beta;
  for (n in 1:N) mu[n] = Phi(mu[n]);
  y ~ bernoulli(mu);
}



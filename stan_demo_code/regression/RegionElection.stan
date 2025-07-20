
data {
  int Nt;
  int Ns;
  int p;
  matrix[Ns, Nt] Y;
  matrix[Nt, p] X[Ns];
  int Southlabel[Ns];
}
parameters {
  vector[p] beta;
  matrix[2, Nt] gamma;
  vector[Nt] delta;
  real<lower=0> tauSouth;
  real<lower=0> tauNonSouth;
  real<lower=0> sigma;
  real<lower=0> tauTime;
}
model {
  for(i in 1:Nt){
    gamma[1, i] ~ normal(0, tauNonSouth);
    gamma[2, i] ~ normal(0, tauSouth);
    delta[i] ~ normal(0, tauTime);
  }
  tauNonSouth ~ inv_gamma(2, 1);
  tauSouth ~ inv_gamma(2, 1);
  tauTime ~ inv_gamma(2, 1);
  sigma ~ cauchy(0, 10);
  
  for(i in 1:Ns){
    for(k in 1:Nt){
      if (Y[i, k]){
       Y[i, k] ~ normal(X[i, k] * beta + gamma[Southlabel[i]+1, k] + delta[k], sigma); 
      }
    }
  }
  
}


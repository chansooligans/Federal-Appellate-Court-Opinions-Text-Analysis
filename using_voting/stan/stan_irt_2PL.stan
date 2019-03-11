// https://mc-stan.org/docs/2_18/stan-users-guide/item-response-models-section.html
// https://mc-stan.org/users/documentation/case-studies/tutorial_twopl.html
// 1PL (Rasch) Model: one parameter (1P) for cases and uses the logistic link function (L)

data {
	int<lower=1> J; 				// number of judges
	int<lower=1> K; 				// number of cases
	int<lower=1> N; 				// number of observations
	int<lower=1,upper=J> jj[N]; 	// judge for observation n
	int<lower=1,upper=K> kk[N]; 	// case for observation n
	int<lower=0,upper=1> y[N]; 		// conservative vote for observation n
}

// N judge-case pairs
// n in 1:N indexes a binary observation y[n] of the correctness of answer of student jj[n] on question kk[n]

parameters {
	real mu_beta;					// mean case conservativeness
	vector[J] alpha;				// conservativeness for judge j - mean
	vector[K] beta;					// conservativeness of case k
	vector<lower=0>[K] gamma;		// discrimination of k
	real<lower=0> sigma_beta		// scale of conservativeness
	real<lower=0> sigma_gamma		// scale of log conservativeness
}

model {
	alpha ~ normal(0, 1);			
	beta ~ normal(0, sigma_beta);
	gamma ~ lognormal(0, sigma_gamma);
	
	mu_beta ~ cauchy(0, 5);

	sigma_beta ~ cauchy(0, 5);
	sigma_gamma ~ cauchy(0, 5); 			
	
	y[ ~ bernoulli_logit(gamma[kk] .* (alpha[jj] - (beta[kk] + mu_beta)));
	// .* is elementwise product

	for (n in 1:N) {
  		y[n] ~ bernoulli_logit(gamma[kk[n]] * (alpha[jj[n]] - (beta[kk[n]] + mu_beta));
	}
}

// The "alpha" determines the scale and location, while beta and gamma are allowed to float
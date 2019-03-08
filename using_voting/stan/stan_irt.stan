// https://mc-stan.org/docs/2_18/stan-users-guide/item-response-models-section.html
// https://mc-stan.org/users/documentation/case-studies/tutorial_twopl.html
// 1PL (Rasch) Model: one parameter (1P) for cases and uses the logistic link function (L)

data {
	int<lower=1> J; 			// number of judges
	int<lower=1> K; 			// number of cases
	int<lower=1> N; 			// number of observations
	int<lower=1,upper=J> jj[N]; // judge for observation n
	int<lower=1,upper=K> kk[N]; // case for observation n
	int<lower=0,upper=1> y[N]; // conservative vote for observation n
}

// N judge-case pairs
// n in 1:N indexes a binary observation y[n] of the correctness of answer of student jj[n] on question kk[n]

parameters {
	real delta;					// mean judge conservativeness
	real alpha[J];				// conservativeness of judge j - mean conservativeness
	real beta[K];				// conservativeness of case k
}

model {
	alpha ~ normal(0,1);		// informative true prior
	beta ~ normal(0,1); 		// informative true prior
	delta ~ normal(0.75,1);		// informative true prior
	for (n in 1:N) {
		y[n] ~ bernoulli_logit(alpha[jj[n]] - beta[kk[n]] + delta);
	}
}

// So: P(y=1) = inv.logit(a - B + delta)
// The model suffers from additive identifiability issues without the informative priors
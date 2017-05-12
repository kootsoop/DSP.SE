    # extern crate rand;
    #
    #use std::f64::EPSILON;
    EPSILON <- 10^(-6)
    #use rand::distributions::{IndependentSample, Normal};
    #
    #extern crate gnuplot;
    #
    #use gnuplot::{Figure, Caption, Color};
    
    #
    #fn main() {
    #  let trial_count = 100;
    trial_count <- 100
    #let signal_len = 500;
    signal_len <- 500
    
    #  let noise_std_dev = 0.96761;
    noise_std_dev <- 0.96761
    #  // AR process coefficient [n-1]
    #let process = [-0.99];
    process <- rep(-0.99, signal_len)
      
    #let mut rand_gen = rand::OsRng::new().unwrap();
    
    #let mut mmse: Vec<f64> = vec![0.0; signal_len];
    mmse <- rep(0.0, signal_len)
    #let mut avg_filt_err: Vec<f64> = vec![0.0; signal_len];
    avg_filt_err <- rep(0.0, signal_len)
    
    #let noise_dist = Normal::new(0.0, noise_std_dev);
      
     # for _ in 0..trial_count {
    for (idx in 1:(trial_count+1 )) 
    {
    #    let mut sig_vec: Vec<f64> = Vec::with_capacity(signal_len);
        sig_vec <- rep(0.0, signal_len)
        
    #    // Zero padding to start noise process
    #    sig_vec.push(0.0);
        sig_vec[1] <- 0.0
        
        p1 <- rep(0.0, signal_len)
        
    #    for n in 1..signal_len {
        for (n in 1:signal_len)
        {
    #      let noise = noise_dist.ind_sample(&mut rand_gen);
          noise <- rnorm(1, 0, noise_std_dev)
    #      let p1 = if n > 0 {
    #        -process[0]*sig_vec[n-1]
    #      } else {
    #        0.0
    #      };
          # was: 
          #p1[n] <-  if (n > 1) -process[1]*sig_vec[n-1] else 0.0
          p1[n] <-  if (n > 1) process[1]*sig_vec[n-1] else 0.0
          
    #      sig_vec.push(noise + p1);
          sig_vec[n] <- noise + p1[n]
        }
        
    #    let step_size = 0.05;
        step_size <- 0.05
        
    #    let mut pred_vec: Vec<f64> = Vec::with_capacity(signal_len);
        pred_vec <- rep(0, signal_len)
        
    #    let mut filt_coef: f64 = 0.0;    
        filt_coef <-  rep(0.0, signal_len)
        
    #    // Zero padding to start filter process
    #    pred_vec.push(0.0);
        pred_vec[1] <- 0.0
        
    #    for sig_ind in 1..signal_len {
        for (sig_ind in seq(2,signal_len))
        {
          #let pred = filt_coef * sig_vec[sig_ind - 1];
          pred <-  filt_coef[sig_ind-1] * sig_vec[sig_ind - 1]
          #pred_vec.push(pred);
          pred_vec[sig_ind] <- pred
          #let err = sig_vec[sig_ind] - pred;
          #WAS: 
          #err <- sig_vec[sig_ind] - pred
          err <- p1[sig_ind] - pred
          #mmse[sig_ind] += err.powi(2) / trial_count as f64;
          mmse[sig_ind] <-  mmse[sig_ind] + err^2 / trial_count
          #filt_coef += step_size * sig_vec[sig_ind - 1] * err /
          #  (sig_vec[sig_ind - 1].powi(2) + EPSILON);
          filt_coef[sig_ind] <- filt_coef[sig_ind-1] + step_size * sig_vec[sig_ind - 1] * err /
            (sig_vec[sig_ind - 1]^2 + EPSILON)
          #avg_filt_err[sig_ind] += (process[0] - filt_coef).abs() / trial_count as f64;
          avg_filt_err[sig_ind] <-  avg_filt_err[sig_ind] + abs((process[1] - filt_coef[sig_ind-1])) / trial_count ;
        }
      
    #  let x: Vec<usize> = (0..mmse.len()).collect();
    #  let mut fg = Figure::new();
    #  fg.axes2d()
    #  .lines(&x, &mmse, &[Caption("MMSE"), Color("black")]);
    #  
    #  let mut fg2 = Figure::new();
    #  fg2.axes2d()
    #  .lines(&x, &avg_filt_err, &[Caption("Average filter error"), Color("red")]);
    #  fg.show();
    #  fg2.show();
    }
    
    plot(avg_filt_err)

    #26568
    
    Ndata <- 1000
    
    c1 <- runif(Ndata,1.5,3)
    c2 <- runif(Ndata,1,2.5)
    
    data <- c(c1, c2)
    
    thresholds <- seq(1,2.99,0.01)
    
    precision <- thresholds*0
    recall <- thresholds*0
    
    for (k in 1:length(thresholds))
    {
      threshold <- thresholds[k]
      cl <- data*0
      tp <- 0
      tn <- 0
      fp <- 0
      fn <- 0
      
      for (i in 1:length(data))
      {
        if ( (data[i] > threshold) && (i <= Ndata))
        {
          tp <- tp + 1  
        }
        if ( (data[i] > threshold) && (i > Ndata))
        {
          fp <- fp + 1  
        }
        if ( (data[i] <= threshold) && (i <= Ndata))
        {
          fn <- fn + 1  
        }
        if ( (data[i] <= threshold) && (i > Ndata))
        {
          tn <- tn + 1  
        }
      }
      
      precision[k] <- tp / (tp + fp)
      recall[k] <- tp / (tp  + fn)
    }
    
    plot(precision,recall)
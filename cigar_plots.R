
#### Plotrix ####

# This implementation of cigar plots makes use of the plotrix package to draw ellipses
# https://cran.r-project.org/web/packages/plotrix/index.html

#install.packages("plotrix")
library(plotrix)

#### FUNCTIONS ####

cigar_plot.calc_metrics <- function(obs, pred, group_IDs, perf_method = "spearman", spread_method = "IQR"){
  
  groups.uniq <- unique(group_IDs)
  
  obs_list <- list()
  pred_list <- list()
  for(i in 1:length(groups.uniq)){
    group <- groups.uniq[i]
    group.ind <- which(group_IDs == group)
    
    obs.group <- obs[group.ind]
    pred.group <- pred[group.ind]
    
    obs_list[[i]] <- obs.group
    pred_list[[i]] <- pred.group
    
    names(obs_list)[i] <- group
    names(pred_list)[i] <- group
  }
  
  
  obs_mean <- unlist(lapply(X = obs_list, FUN = mean))
  pred_mean <- unlist(lapply(X = pred_list, FUN = mean))
  
  if(perf_method == "spearman"){
    performances <- sapply(X = 1:length(obs_list), FUN = function(i) cor( obs_list[[i]], pred_list[[i]], method = "spearman" ) )
  }else if(perf_method == "pearson"){
    performances <- sapply(X = 1:length(obs_list), FUN = function(i) cor( obs_list[[i]], pred_list[[i]], method = "pearson" ) )
  }else{
    print( paste("WARNING! Performance method not recognized:", perf_method) )
  }
  
  if(spread_method == "IQR"){
    spread <- unlist(lapply(X = obs_list, FUN = IQR))
  }else if(spread_method == "var"){
    spread <- unlist(lapply(X = obs_list, FUN = var))
  }else if(spread_method == "sd"){
    spread <- unlist(lapply(X = obs_list, FUN = sd))
  }else{
    print( paste("WARNING! Spread method not recognized:", spread_method) )
  }
  
  spread <- (spread - min(spread)) / (max(spread) - min(spread))
  
  return( list( obs_mean = obs_mean, pred_mean = pred_mean, performances = performances, spread = spread ) )
}



make_transparent_color <- function(color_name, alpha){
  col.rgb <- col2rgb(color_name)
  col.rgb2 <- col.rgb/255
  col.transparent <- rgb( col.rgb2[1], col.rgb2[2], col.rgb2[3], alpha = alpha )
  return(col.transparent)
}



cigar_plot <- function(obs_mean, pred_mean, performances,
                       spread = NULL, base_spread = 1,
                       scale_means = FALSE, plot_limits = NULL, 
                       colors = rainbow( length(obs_mean) ), color_alpha = 0.2, 
                       main_title = NA, xlab = "Mean observed", ylab = "Mean predicted"){
  
  library(plotrix)
  
  max_angle = 45
  pch = 16
  cex = 1
  lty = "dashed"
  
  #### Prep plot features ####
  
  # scale means
  
  if(scale_means){
    obs_mean <- (obs_mean - min(obs_mean)) / (max(obs_mean) - min(obs_mean))
    pred_mean <- (pred_mean - min(pred_mean)) / (max(pred_mean) - min(pred_mean))
  }
  
  # transparent colors
  
  colors_t <- sapply(X = colors, FUN = function(x) make_transparent_color(color_name = x, alpha = color_alpha) )
  
  # spread
  if(length(spread) == 0){
    spread <- rep(0, length(obs_mean))
  }
  
  spread_a <- sapply( X = spread, FUN = function(x) base_spread + (base_spread * x) )
  spread_b <- sapply( X = 1:length(obs_mean), FUN = function(i) spread_a[i] - (spread_a[i] * abs(performances)[i]) )
  
  # angles
  angles.deg <- max_angle * performances
  ellipse_fx <- function(i) draw.ellipse(x = obs_mean[i], y = pred_mean[i],
                                         a = spread_a[i], b = spread_b[i], angle = angles.deg[i],
                                         border = colors[i], col = colors_t[i] )
  
  # segments
  
  angles.rad <- angles.deg * (pi / 180)
  
  hypot <- spread_a
  opp <- sin(angles.rad) * hypot
  adj <- cos(angles.rad) * hypot
  
  segments.x0 <- obs_mean - adj
  segments.x1 <- obs_mean + adj
  
  segments.y0 <- pred_mean - opp
  segments.y1 <- pred_mean + opp
  
  segments_fx <- function(i) segments(x0 = segments.x0[i], y0 = segments.y0[i],
                                      x1 = segments.x1[i], y1 = segments.y1[i],
                                      col = colors[i], lty = lty)
  
  # limits
  
  if(length(plot_limits) == 0){
    endpoints <- c( obs_mean+max(spread_a), obs_mean-max(spread_a), 
                    pred_mean+max(spread_b), pred_mean-max(spread_b),
                    segments.x0, segments.x1, segments.y0, segments.y1 )
    plot_limits <- c( min(endpoints), max(endpoints) )
  }
  
  #### Generate plot ####
  
  plot(1, type = 'n', xlim = plot_limits, ylim = plot_limits, xlab = xlab, ylab = ylab, main = main_title)
  
  invisible(sapply(X = 1:length(obs_mean), FUN = ellipse_fx ))
  invisible(sapply(X = 1:length(obs_mean), FUN = segments_fx))
  points( x = obs_mean, y = pred_mean, col = colors, pch = pch, cex = cex )
  
}


#### EXAMPLE CODE ####

# Setting up 5 example groups: a - e
n_a <- 10
n_b <- 10
n_c <- 10
n_d <- 10
n_e <- 10

obs <- c( rnorm(n = n_a, mean = 20, sd = 5),
          rnorm(n = n_b, mean = 25, sd = 5),
          rnorm(n = n_c, mean = 30, sd = 5),
          rnorm(n = n_d, mean = 35, sd = 5),
          rnorm(n = n_e, mean = 40, sd = 5) )
pred <- c( rnorm(n = n_a, mean = 20, sd = 5),
          rnorm(n = n_b, mean = 25, sd = 5),
          rnorm(n = n_c, mean = 30, sd = 5),
          rnorm(n = n_d, mean = 35, sd = 5),
          rnorm(n = n_e, mean = 40, sd = 5) )
group_IDs <- c( rep("a", n_a), rep("b", n_b), rep("c", n_c), rep("d", n_d), rep("e", n_e) ) 

example_metrics <- cigar_plot.calc_metrics( obs = obs, pred = pred, group_IDs = group_IDs, perf_method = "spearman", spread_method = "IQR" )

example_metrics

cor( x = obs, y = pred, method = "spearman" )
max(example_metrics$performances)
mean(example_metrics$performances)

par(mfrow = c(2, 2), pty = "s")
plot( x = obs, y = pred, pch = 16 )
plot( x = obs, y = pred, pch = 16, col = c( rep("red", n_a), rep("orange", n_b), rep("green", n_c), rep("blue", n_d), rep("purple", n_e) ) )
cigar_plot( obs_mean = example_metrics$obs_mean, pred_mean = example_metrics$pred_mean,
            performances = example_metrics$performances, spread = example_metrics$spread, base_spread = 3, scale_means = F )
cigar_plot( obs_mean = example_metrics$obs_mean, pred_mean = example_metrics$pred_mean,
            performances = example_metrics$performances, spread = example_metrics$spread, base_spread = 0.15, scale_means = T )

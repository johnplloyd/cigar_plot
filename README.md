# cigar_plot.R

## cigar_plot()

This is the main function to generate cigar plots.

*Required inputs:*

**obs_mean**: numeric vector with mean *observed* response per group

**pred_mean**: numeric vector with mean *predicted* response per group

**performances**: numeric vector with within-group performance measures. Values are expected to range between -1 and 1 (e.g. pearon or spearman correlation coefficients)

*Optional inputs:*

**spread**: numeric vector with spread measure for each group. Values are expected to range between 0 and 1.

**base_spread**: numeric value indicating the spread length for the smallest spread value.

**scale_means**: Boolean indicating whether the mean observed and predicted values should be scaled between 0 and 1. scale_means = TRUE is useful for cases when observed and predicted values are in different ranges, as the x- and y-axis limits should be equal so that ellipses plot correctly.

**plot_limits**: min and max value for the x- and y-axes

**colors**: character vector with colors for groups.

**color_alpha**: Numeric value. Alpha transparency value for ellipsis backgrounds. Range: [0, 1].

**main_title / xlab / ylab**: Main, x-axis, or y-axis labels.

## cigar_plot.calc_metrics()

This function will take three vectors and calculate the inputs to necessary to generate cigar plots.

*Required inputs:*

**obs**: numeric vector with observed response values.

**pred**: numeric vector with predicted response values.

**group_IDs**: character vector with group labels.

*Optional inputs:*

**perf_method**: Performance metric to calculate. Available: "spearman" (default) and "pearson".

**spread_method**: Spread measure to calculate. Available: "IQR" (default), "var", and "sd".

Output is a list object with mean observed values within groups ($obs_mean), mean predicted values within groups ($pred_mean), performance metrics within groups ($peformances), and the observed spread within groups ($spread).

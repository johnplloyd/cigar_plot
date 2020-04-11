# cigar_plots.R

Cigar plots represent a visualization strategy to simultaneously display within- and between-group prediction performances. The cigar plot displays each group as an ellipse and indicates between-group performance (mean predicted and observed response values) with the location of ellipsis centers and indicates within-group performance (e.g. rank correlation coefficients) with the tilt and width of ellipses. Ellipsis tilt is calculated by 45° × correlation coefficient: coefficient of 1 is associated with a 45° tilt, coefficient of 0 a 0° tilt, and coefficient of -1 a -45° tilt. The slopes of the lines transverse across ellipses are calculated the same as ellipsis tilt. Ellipsis length is scaled to observed within-group spread. Ellipsis width scales with within-group performance and is calculated as: ellipsis length – (ellipsis length × absolute correlation coefficient). Large absolute coefficients result in narrow ellipses (coefficient of 1 results in a line) while small coefficients result in round ellipses (coefficient of 0 results in a circle).

The **cigar_plots.R** file contains two functions that can be used to generate cigar plots, described below.

## cigar_plot()

This is the main function to generate cigar plots.

*Required inputs:*

**obs_mean**: numeric vector with mean *observed* response per group

**pred_mean**: numeric vector with mean *predicted* response per group

**performances**: numeric vector with within-group performance measures. Values are expected to range between -1 and 1 (e.g. pearson or spearman correlation coefficients)

*Optional inputs:*

**spread**: numeric vector with spread measure for each group. Values are expected to range between 0 and 1.

**base_spread**: numeric value indicating the spread length for the smallest spread value.

**scale_means**: Boolean indicating whether the mean observed and predicted values should be scaled between 0 and 1. scale_means = TRUE is useful for cases when observed and predicted values are in different ranges, as the x- and y-axis limits should be equal so that ellipses plot correctly.

**plot_limits**: min and max value for the x- and y-axes

**colors**: character vector with colors for groups.

**color_alpha**: Numeric value. Alpha transparency value for ellipsis backgrounds. Range: [0, 1], lower values = greater transparency.

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

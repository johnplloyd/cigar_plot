Cigar plots represent a visualization strategy to simultaneously display within- and between-group prediction performances. The cigar plot displays the predicted and observed drug response in an x-y plot, and highlights their concordance (i.e., the prediction performance) at two levels. First, the variation within each group is shown as an ellipse, with the within-group concordance (e.g., measured by rank correlation coefficients) shown as the tilt and width of the ellipses. Second, the between-group variation (differences of group mean values) is shown as the location of ellipsis centers.

Ellipsis *tilt* is calculated by 45° × correlation coefficient: coefficient of 1 is associated with a 45° tilt, coefficient of 0 a 0° tilt, and coefficient of -1 a -45° tilt. The slope of the line across an ellipse is the same as ellipsis tilt.

Ellipsis *length* is scaled to the observed within-group range, with longer ellipses representing groups with larger observed response ranges.

Ellipsis *width* scales with within-group performance and is calculated as: ellipsis length × (1 - absolute correlation coefficient). Larger absolute coefficients result in narrower ellipses (coefficient of 1 results in a line) while smaller coefficients result in rounder ellipses (coefficient of 0 results in a circle). 

If you would like to make use of cigar plots, please cite:
Lloyd et al (2020) bioRxiv: Pan-cancer predictions of MEK inhibitor sensitivity are partially driven by differences between cancer types
https://www.biorxiv.org/content/10.1101/800193v3.full

## cigar_plots.R

The **cigar_plots.R** file contains two functions that can be used to generate cigar plots, described below, along with sample code to display example cigar plots.

## cigar_plot()

This is the main function to generate cigar plots.

*Required inputs:*

**obs_mean**: numeric vector with mean *observed* response per group.

**pred_mean**: numeric vector with mean *predicted* response per group.

**performances**: numeric vector with within-group performance measures. Values are expected to range between -1 and 1 (e.g. pearson or spearman correlation coefficients).

*Optional inputs:*

**spread**: numeric vector with spread measure for each group. Values are expected to range between 0 and 1.

**base_spread**: numeric value indicating the spread length for the smallest spread value.

**scale_means**: Boolean indicating whether the mean observed and predicted values should be scaled between 0 and 1. scale_means = TRUE is useful for cases when observed and predicted values are in different ranges, as the x- and y-axis limits should be equal so that ellipses plot correctly.

**plot_limits**: Numeric vector with min and max value for the x- and y-axes.

**colors**: character vector with colors for groups.

**color_alpha**: Numeric value. Alpha transparency value for ellipsis backgrounds. Range: [0, 1], lower values = greater transparency.

**main_title / xlab / ylab**: Main, x-axis, or y-axis labels.

*Output:*

Generates a cigar plot to the current graphics device.

## cigar_plot.calc_metrics()

This function will take three vectors and calculate the inputs to necessary to generate cigar plots.

*Required inputs:*

**obs**: numeric vector with *observed* response values per instance.

**pred**: numeric vector with *predicted* response values per instance.

**group_IDs**: character vector with group labels per instance.

*Optional inputs:*

**perf_method**: Performance metric to calculate. Available: "spearman" (default) and "pearson".

**spread_method**: Spread measure to calculate. Available: "IQR" (default), "var", and "sd".

*Output:*

Output is a list object with mean observed values within groups ($obs_mean), mean predicted values within groups ($pred_mean), performance metrics within groups ($peformances), and the observed spread within groups ($spread). These can be used as inputs to the **cigar_plot()** function.

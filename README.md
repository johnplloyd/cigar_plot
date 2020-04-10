# cigar_plot.R

**cigar_plot.calc_metrics()**

This function will take three vectors: observed response values ("obs", numeric vector), predicted response values ("pred", numeric vector), and group labels ("group_IDs", character vector), and calculate the inputs to necessary to generate cigar plots.

Output is a list object with mean observed values within groups ($obs_mean), mean predicted values within groups ($pred_mean), performance metrics within groups ($peformances), and the observed spread within groups ($spread). Performance metric and spread measure can be selected with the "perf_method" and "spread_method" arguments, respectively.

Available performance metrics: "spearman" and "pearson"

Available spread measures: "IQR", "var", and "sd"

**cigar_plot()**


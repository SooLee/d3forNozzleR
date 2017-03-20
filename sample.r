source("interactive_multiline_d3prep.r")
res=create_d3_js_for_interactive_multiline_plot(report_dir="sample", xmin=3, xmax=8, ymin=-13, ymax=0)
write.table(res$minihtml, "sample/sample.html", quote=FALSE, col.names=FALSE, row.names=FALSE)


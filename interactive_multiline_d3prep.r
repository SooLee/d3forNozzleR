## Author: Soo Lee (duplexa@gmail.com), Department of Biomedical Informatics, Harvard Medical School.
create_d3_js_for_interactive_multiline_plot <- function(
    sample_name = "mysample", # Some kind of plot identification (in case you want to add multiple plots into a single html)
    xmin= 0,
    xmax= 1,
    ymin= 0,
    ymax= 1,
    div_id = paste("d3div_myplot_", sample_name, "___", sep=""), # Your d3 plot will be placed in a div section with this div_id.
    xlab = 'x',
    ylab = 'y',
    report_dir = "report",  ## output directory that will contain html, js, tsv etc.
    js_file_prefix = 'interactive_multiline',

    # tsvfile relative path ( to be used inside js file)
    tsvfile = "sample_tsvfile.tsv", # relative to report dir
    
    # data frame for column pairs, colors (on and off) and labels.
    tsvcoldata = read.table("sample/sample_tsvcolfile.tsv", comment.char="", sep="\t", header=T, stringsAsFactors=FALSE)
){

    # The function assumes a directory structure of a report_dir which contains all necessary html, js and tsv.
    # the data tsv file must already be in the report_dir.

    # tsvcolfile relative path (to be used inside js file)
    tsvcolfile =paste("./tsvcol.", div_id, ".tsv", sep="") # relative to report dir

    # create tsvcolfilecurr from data frame tsvcoldata
    tsvcolfilecurr =paste(report_dir, "/tsvcol.", div_id, ".tsv", sep="") # relative to current dir
    write.table(tsvcoldata, tsvcolfilecurr, quote=FALSE, row.names=FALSE, sep="\t")

    # create js file
    js_content = c(
      paste("d3.tsv('", tsvcolfile, "', function(tsvcolumns) {", sep=""),
      paste( "interactive_multiline_plot('", tsvfile, "', tsvcolumns, ", xmin, ",", xmax, ",", ymin, ",", ymax ,", '", xlab, "', '", ylab, "', '", div_id , "');", sep=""),
      "});"
    )
    js_file = paste("./", js_file_prefix, ".", sample_name, ".js", sep="") # relative to report dir  (to be used in html)
    js_file_curr = paste(report_dir, "/distanceplot_perchr.", sample_name, ".js", sep="") # relative to current dir
    write.table(js_content, js_file_curr,quote=FALSE, row.names=FALSE, col.names=FALSE)
   
   # tags for html to call js file  
   html_script_tag = paste("<script src=\"", js_file, "\"></script>",sep="")   # relative to report dir
   html_common_script_tag = "<script src=\"https://d3js.org/d3.v3.js\"></script><script src=\"https://rawgit.com/SooLee/d3forNozzleR/master/interactive_multiline.js\"></script>"
   html_div_tag = paste("<div id=\"", div_id, "\"></div>",sep="")  

   minihtml = paste("<html><body>",html_common_script_tag,html_div_tag,html_script_tag,"</body></html>",sep="")
  
   # return necessary things to create an html component
   return(list(div_id=div_id, tsvcolfile=tsvcolfile, js_file=js_file, html_script_tag = html_script_tag, html_common_script_tag=html_common_script_tag, html_div_tag=html_div_tag, minihtml=minihtml))


}


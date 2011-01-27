
echo > %REPORT_LOG% 
echo > %REPORT_DIFF_IN_TXT% 
echo > %REPORT_DIFF_IN_HTML%
echo > %REPORT_NUMBERS%
echo > %PROCESSING_RESULT%

call scielo_lilacs\conversion\convert.bat %scilista% %initial_date% %PROCESSING_RESULT% %debug%

call scielo_lilacs\report\report.bat generateNumbersReport %REPORT_NUMBERS% %debug% 
call scielo_lilacs\report\report.bat generateDiffReport_TextFormat %REPORT_DIFF_IN_TXT% %debug%

more %LILACS_TITLES% > %REPORT_LOG%
more %PROCESSING_RESULT% >> %REPORT_LOG%
more %REPORT_NUMBERS% >> %REPORT_LOG%
more %REPORT_DIFF_IN_TXT% >> %REPORT_LOG%

echo %LILACS_TITLES% > temp\scielo_lilacs_report_files.txt
echo %PROCESSING_RESULT% >> temp\scielo_lilacs_report_files.txt
echo %REPORT_NUMBERS% >> temp\scielo_lilacs_report_files.txt
echo %REPORT_DIFF_IN_TXT% >> temp\scielo_lilacs_report_files.txt

call scielo_lilacs\report\report.bat generateDiffReport %REPORT_DIFF_IN_HTML% %debug% temp\scielo_lilacs_report_files.txt

echo Read report in %REPORT_DIFF_IN_HTML%
echo Read processing log in %REPORT_LOG%






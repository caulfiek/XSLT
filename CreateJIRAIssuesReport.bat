echo @
REM **************************************************************************************
REM * Take a XML JIRA Issues download and transform it into a nice HTML table.
REM * K Caulfield: 7th June 2013.
REM **************************************************************************************

cd /

cd C:\JIRAIssues

del /Q MyJiraReport.xml
del /Q MyJiraReport.html

REM **************************************************************************************
REM **** get most recent Jira*.xml file, assuming you've save your export as Jira*.XML
REM **************************************************************************************

for /f "delims=" %%x in ('dir /od /a-d /b Jira*.xml') do set recent=%%x

REM **************************************************************************************
rem **** strip out the first 11 lines and spool to Report.xml 
rem **** (missing off the original JIRA XML header that messes with msxsl and XSLT!)
REM **************************************************************************************

more +11 %recent% > MyJiraReport.xml

REM **************************************************************************************
rem **** Transform XML into HTML page
REM **************************************************************************************

msxsl.exe MyJiraReport.xml JiraIssues.xsl -o MyJiraReport.html

REM **************************************************************************************
REM * open report for viewing (assume IE is default browser)
REM **************************************************************************************

MyJiraReport.html

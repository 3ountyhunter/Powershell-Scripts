## This script was made for Scripting for Network Administrators in 2018 by Michael Heeney, Zane Babcock, Cal Fritz and Heidi
$source="students.txt"
$a = (test-path $source)
If ($a -eq "True") {

clear-host
  }  Else {

  "You have chosen to exit the script or the source file was not found. "
  "Please make sure the file $source is in the same directory as this script."

exit
}

$continue = Read-host "File $source found. Is this the correct source file?"

# This creates the HTML code that properly formats the page.
if ($continue -eq 'y') {
$a = "<style>"
$a = $a + "TABLE{border-width: 1px;border-style: solid;border-color: black;margin: auto;}"
$a = $a + "TH{border-width: 1px;padding: 5px;border-style: solid;border-color: black;text-align: center;background-color:palegoldenrod;}"
$a = $a + "TD{border-width: 1px;padding: 5px;border-style: solid;border-color: black;}"
$a = $a + "</style>"

#This grabs a specific line in the code
$header= get-content students.txt | select -last 1 -skip 39

#Grabs the line with the headers we want, removes excess spaces and joins them with a comma
$header1 = ForEach-Object { ($header -split ' ' | Where-Object { $_ }) -join ',' }
#Takes the header1 variable and assigns the information to variables to be used later
$z, $b, $c, $d, $e, $f, $g, $h, $i, $j, $k, $l, $m, $n, $o = $header1.split(',')


$importTxt = Get-Content "$source" | Where-Object { $_ } # Import .txt file, removing blank lines
$studentData = $importTxt | Where-Object { $_ -match '(\d){4}\-(\d){4}.*' } # Filter for only student data
$studentDataObj = ($studentData -split "`r`n" | ForEach-Object { ($_ -split ' ' | Where-Object { $_ }) -join ',' }) |
ConvertFrom-Csv -Header $z, $b, $c, $d, $e, $f, $g, $h, $i, $j, $o #Creates the headers from the variables scraped from file earlier
$studentDataObj | convertto-html -head $a -title 'Students' | out-file .\students.htm
ii .\students.htm
}
clear-host

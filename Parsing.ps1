## This script was made for Scripting for Network Administrators in 2018 by Michael Heeney, Zane Babcock, Cal Fritz and Heidi
$source = "students.txt"
$OutputFile = "Students1.txt"
$a = (test-path $source)
If ($a -eq "True") {

clear-host
  }  Else {

  "You have chosen to exit the script or the source file was not found. "
  "Please make sure the file $source is in the same directory as this script"

exit
}

$continue = Read-host "File $source found. Is this the correct source file?"

if ($continue -eq 'y') {

  $clean = get-content $source | select-string -pattern "\d{1,4}\-\d{1,4}"

  $strings = $clean -split " " | Where-Object { $_ }

  # Bulk add properties
  $props = @{
  	StudentID = $strings[0]
  	Surname = $strings[1]
  	Firstname = $strings[2]
  	DN = $strings[3]
  	ERN = $strings[4]
  	HR = $strings[5]
  	STS = $strings[6]
  	DEG = $strings[7]
  	CON = $strings[8]
    VER = $STRINGS[9]
    GPA = $STRINGS[10]
}
  # Build Object
  New-Object PSObject -Property $props


$props | select-object -property *

}
else {
  exit
}

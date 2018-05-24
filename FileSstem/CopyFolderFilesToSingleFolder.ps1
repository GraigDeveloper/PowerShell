Set-Strictmode -Version Latest
$strSourceFolder = "z:"
$strTargetFolder = "z:\AllFiles"

Get-ChildItem $strSourceFolder  -Recurse | 
where { !$_.PSisContainer } |
Copy-Item -Destination $strTargetFolder -force


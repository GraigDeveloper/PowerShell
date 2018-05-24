$strSourceFolder = "C:\Users\Developer\Documents"
$strPMTFile = "UKIP.accdb"
$strBackupFolder = "\\GraigWS002\Backups\PMT"
$Today = Get-dATE -F "yyyyMMddhhmm"

#Create PMT folder if it does not exist
$TestTrue =Test-Path -Path $strBackupFolder
IF (-not ($TestTrue))
    
    {
    ECHO "Creaate PMT Foldert"
    
    New-Item -ItemType directory -Path $strBackupFolder

    }

Copy-Item -Path ($strSourceFolder + "\" + $strPMTFile)  -Destination ($strBackupFolder + "\" + $Today + $strPMTFile) 

$pargs = $strSourceFolder + "\" + $strPMTFile + " /compact"
start-process -FilePath "C:\Program Files (x86)\Microsoft Office\root\Office16\MSACCESS.EXE" -ArgumentList $($pargs) -WindowStyle Minimized


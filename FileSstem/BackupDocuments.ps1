$strSourceFolder = "C:\PQRDData\OneDrive - Sopra Steria"
$strTargetRootFolder = "H:\Backups"
$Today = Get-dATE -F "yyyyMMdd"
$TestTrue = $True
#Returns single digit id less than 10
$intLastMonth = ((Get-Date).Month - 1)

#Returns YYYYMM
$strLastMonth = (Get-dATE -F "yyyy") + $intLastMonth.Tostring("00") 

#Backup Folder for today
$strDestinationFolder = $strTargetRootFolder + "\" + $Today

#Root folder to contain last months backups ...\YYYYMM
$PreviousMonthFolder = $strTargetRootFolder + "\" + $strLastMonth

ECHO 'Backuping folder regime'

Copy-Item $strSourceFolder $strDestinationFolder -Recurse -Force
ECHO 'Folder regime backed up'


#Create Monthly For Previous Month if it does not exist
#Then move previous months individual day backup folders to newly created monthly folder
#$PreviousMonthFolder
$TestTrue =Test-Path -Path $PreviousMonthFolder
IF (-not ($TestTrue))
    
    {
    ECHO "Moving last Months Folder's to New Monthly Root"
    
    New-Item -ItemType directory -Path $PreviousMonthFolder

    #Now move previous months individual day backup folders to $PreviousMonthFolder
    Move-Item -Path ($strRootFolder + "\" + $strLastMonth + "??") -Destination $PreviousMonthFolder
    }

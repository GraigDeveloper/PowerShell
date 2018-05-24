Set-Strictmode -Version Latest
$SourceDestination = (
                        ("Y:\20.Asset_Management\GIO_Asset_Template","c:\Backup"),
                        ("Y:\16. Central Patch\GIO_WintelPatch","c:\Backup_Wintel"),
                        ("Y:\_GIO","c:\Backup__GIO")
                      )

foreach ($row in $SourceDestination)
{
    $strSourceFolder = $($row[0]) 
    $strBackupFolder = $($row[1]) 

    $Today = Get-dATE -F "yyyyMMddHHmm"
    $TestTrue = $True
    #Returns single digit id less than 1
    $intLastMonth = ((Get-Date).Month - 1)

    #Returns YYYYMM
    $strLastMonth = (Get-dATE -F "yyyy") + $intLastMonth.Tostring("00") 

    #Backup Folder for today
    $strDestinationFolder = $strBackupFolder + "\" + $Today
    ECHO $strDestinationFolder

    #Root folder to contain last months backups ...\YYYYMM
    $PreviousMonthFolder = $strBackupFolder + "\" + $strLastMonth

    #Create Root Backup folder if it does not exist
    If(!(test-path $strDestinationFolder ))
                    {
                        New-Item -ItemType Directory -Force -Path $strBackupFolder
                        ECHO ("Created Folder " + $strDestinationFolder) 
                    }

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

        #Now move previous months individual day backup with time stamp folders to $PreviousMonthFolder
        Move-Item -Path ($strBackupFolder + "\" + $strLastMonth + "??????") -Destination $PreviousMonthFolder
        }
}
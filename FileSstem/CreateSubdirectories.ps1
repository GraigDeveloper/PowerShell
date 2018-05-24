Set-Strictmode -Version Latest
$strRootFolder = "\\UKGIOCRSDEV01.mgmt.computacenter.co.uk\SSIS_Share\GIO_Asset_Config\"
#$strRootFolder = "M:\Backup\"
$strNewPath = ""
$strAssetSubFolder = ""
$strAssetSubFolders = "AssetFiles","ManagedData","ImportedFiles"

# initialize the items variable with the
# contents of a directory
$items = Get-ChildItem -Path $strRootFolder
 
# enumerate the items array
foreach ($item in $items)
{
      # if the item is a directory, then process it.
      if ($item.Attributes -eq "Directory")
      {
            $strNewPath = ($strRootFolder + $item.Name)
            
            foreach ( $strAssetSubFolder in $strAssetSubFolders)
            {
                $strNewPath = ($strRootFolder + $item.Name + "\" + $strAssetSubFolder)
                write-host  $strNewPath
            
            
                If(!(test-path $strNewPath))
                {
                    New-Item -ItemType Directory -Force -Path $strNewPath
                }
            }
      }
}

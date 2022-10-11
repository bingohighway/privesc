$domainObj = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain() 
$PDC = ($domainObj.PdcRoleOwner).Name 
$SearchString = "LDAP://"
$SearchString += $PDC + "/"
$DistinguishedName = "DC=$($domainObj.Name.Replace('.', ',DC='))" 
$SearchString += $DistinguishedName 
$Searcher = New-Object System.DirectoryServices.DirectorySearcher([ADSI]$SearchString) 
$objDomain = New-Object System.DirectoryServices.DirectoryEntry 
$Searcher.SearchRoot = $objDomain 
$Searcher.filter="(name=Domain Admins)" 
$Result = $Searcher.FindAll() 
foreach($obj in $Result)
{ 
 $obj.Properties.member 
}

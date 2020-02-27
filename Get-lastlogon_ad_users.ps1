function Get-ADUsersLastLogon()
{
  $dcs = Get-ADDomainController -Filter {Name -like "*"}
  $users = Get-ADUser -Filter *
  $time = 0
  $exportFilePath = "C:\Beheer\Scripts\AD\lastLogon.csv"
  $columns = "name,username,datetime"

  Out-File -filepath $exportFilePath -force -InputObject $columns

  foreach($user in $users)
  {
    foreach($dc in $dcs)
    { 
      $hostname = $dc.HostName
      $currentUser = Get-ADUser $user.SamAccountName | Get-ADObject -Server $hostname -Properties lastLogon

      if($currentUser.LastLogon -gt $time) 
      {
        $time = $currentUser.LastLogon
      }
    }

    $dt = [DateTime]::FromFileTime($time)
    $row = $user.Name+","+$user.SamAccountName+","+$dt

    Out-File -filepath $exportFilePath -append -noclobber -InputObject $row

    $time = 0
  }
}
 
Get-ADUsersLastLogon
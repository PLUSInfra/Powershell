$computers = "C:\Beheer\Scripts\ADComputer\input.txt" 
 
$ADComp = "C:\Beheer\Scripts\ADComputer\output.txt/.Log>" 
 
Get-Content $computers | Foreach {If (Get-ADComputer -Filter {Name -eq $_}) {Add-Content $ADComp "$_ is Enabled $((Get-ADComputer $_).enabled) in Active Directory."} Else {Add-Content $ADComp "Warning!! $_ is not in Active Directory."}}
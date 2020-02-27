$groups = Get-Content S:\Documents\Scripts\adgroupmember\groups.txt            
            
foreach($Group in $Groups) {            
            
Get-ADGroupMember -Id $Group | select  @{Expression={$Group};Label="Group Name"},* | Export-CSV S:\Documents\Scripts\adgroupmember\GroupsInfo.CSV
            
}
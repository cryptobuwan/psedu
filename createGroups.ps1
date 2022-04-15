#Import Active Directory Directory Module
Import-Module ActiveDirectory

# Import User data
$csv = Import-Csv -Path C:\Users\chris.carlson\Documents\adusers.csv

# Parse file for all the departments of users and list the unique ones 
$groups = $csv.Department | Select-Object -Unique

foreach ($group in $groups) {
    # Par
    $GlobalGroupInfo = @{
        Name            = "$group Users"
        SamAccountName  = $group.ToLower() + "_users"
        Path            = "OU=Groups,OU=Corp,DC=C-SNAG,DC=local"
        GroupScope      = "Global"
        GroupCategory   = "Security"
        Description     = "Members of this group work in the $group Department"
    }

    $DomainLocalGroupInfo = @{
        Name            = "$group Resources"
        SamAccountName  = $group.ToLower() + "_resources"
        Path            = "OU=Groups,OU=Corp,DC=C-SNAG,DC=local"
        GroupScope      = "DomainLocal"
        GroupCategory   = "Security"
        Description     = "Security Group used to manage access to the $group Department"
    }

    New-ADGroup @GlobalGroupInfo -WhatIf
    New-ADGroup @DomainLocalGroupInfo -WhatIf
    
    $groups
        
}

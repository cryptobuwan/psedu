#Import Active Directory Directory Module
Import-Module ActiveDirectory

# Import User data
$csv = Import-Csv -Path C:\Users\chris.carlson\Documents\adusers.csv

# Read in Secure Temporary Password (Note: Complexity)
$AccountPassword = Read-Host -AsSecureString -Prompt "Enter Temporary Password for New Users"

foreach ($user in $csv) {

    # Store User Attributes for Splatting
    $UserInfo = @{
        Name = $user.Name
        DisplayName = $user.Name
        GivenName = $user.GivenName
        Surname = $user.Surname

        SamAccountName = $user.SamAccountName
        Path = $user.Path

        Title = $user.Title
        Department = $user.Department
        Company = $user.Company
        EmailAddress = $user.EmailAddress
        
        AccountPassword = $AccountPassword
        ChangePasswordAtLogon = $true
        Enabled = $true
    }
    # Create New users
    New-ADUser @UserInfo 
    
}


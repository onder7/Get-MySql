## =====================================================================
## Title       : Get-MySqlStatus
## Description : Generic function to get a MySqlStatus
## Author      : Önder Mönder
## Date        : 7/24/2025
## Input       : -server (Server name or IP address)
## 				  -port (port number)
##               -db (database name)
##               -verbose -debug	
## Output      : 
## Usage			: PS> .\Get-MySqlStatus -server LocalHost -port 3306 -db Test -verbose -debug
## Tag         : MySQL

## ===================================================================== 
 
param(
    [string]$server = "localhost",  # Changed default
    [int]$port = 3306,              # Changed default
    [string]$db = "quiz_app",       # Changed default
    [switch]$verbose = $true,
    [switch]$debug = $false
)

function main() {
    if ($verbose) {$VerbosePreference = "Continue"}
    if ($debug) {$DebugPreference = "Continue"}

    try {
        Write-Verbose "Loading MySQL assembly..."
        Load-MySqlAssembly
        
        Write-Verbose "Generic function to get a database status..."
        Get-MySqlStatus $server $port $db
    }
    catch {
        Write-Error "Error: $_"
    }
}

function Load-MySqlAssembly() {
    try {
        [void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
    }
    catch {
        throw "Failed to load MySQL.Data assembly. Please install MySQL Connector/NET. Error: $_"
    }
}

function Get-MySqlStatus($server, $port, $db) {
    if ([string]::IsNullOrEmpty($server)) {
        throw "Server parameter cannot be empty"
    }

    # Get credentials
    $credentials = Get-Credential -Message "Enter MySQL credentials"
    if (-not $credentials) {
        throw "Credentials are required"
    }

    $cred = $credentials.GetNetworkCredential()
    $uid = $cred.UserName
    $pwd = $cred.Password
    
    # Connection string
    $connStr = "server=$server;port=$port;uid=$uid;pwd=$pwd;database=$db;Pooling=False"
    Write-Debug "Connection string: $connStr"
    
    try {
        Write-Verbose "Opening connection to MySQL database server ($server)"
        $conn = New-Object MySql.Data.MySqlClient.MySqlConnection($connStr)
        $conn.Open()
        
        $cmd = New-Object MySql.Data.MySqlClient.MySqlCommand("SHOW STATUS;", $conn)
        $da = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($cmd)
        
        Write-Verbose "Populate a dataset and output the query result..."
        $ds = New-Object System.Data.DataSet
        $da.Fill($ds) > $null
        $ds.Tables[0] | Format-Table -AutoSize
    }
    finally {
        if ($conn -and $conn.State -eq 'Open') {
            $conn.Close()
        }
    }
}

main

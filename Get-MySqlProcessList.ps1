## =====================================================================
## Title       : Get-MySqlProcessList
## Description : Generic function to get a database process list
## Author      : Önder Mönder

## Date        : 7/24/2025
## Input       : -server (Server name or IP address)
## 				  -port (port number)
##               -db (database name)
##               -verbose -debug	
## Output      : 
## Usage			: PS> .\Get-MySqlProcessList -server LocalHost -port 3306 -db Test -verbose -debug
## Tag         : MySQL

## ===================================================================== 
 
param(
    [string]$server = "localhost",  # Changed default
    [int]$port = 3306,              # Changed default
    [string]$db = "quiz_app",       # Changed default
    [switch]$verbose = $true,
    [switch]$debug = $false
)
function main()
{
	if ($verbose) {$VerbosePreference = "Continue"}
	if ($debug) {$DebugPreference = "Continue"}
	
	Write-Verbose "Generic function to get a MySQL database process list..."
	Get-MySqlProcessList $server $port $db
}

function Get-MySqlProcessList($server, $port, $db)
{
	[void][system.reflection.Assembly]::LoadWithPartialName("MySql.Data")
	
	trap [Exception] 
	{
		write-error $("TRAPPED: " + $_.Exception.Message);
		continue;
	}

	#Get credentials in clear text
	$credentials = Get-Credential
	$cred = $credentials.GetNetworkCredential()
	$uid = $cred.UserName
	$pwd = $cred.Password
	
	# Open Connection
	$connStr = "server=$server;port=$port;uid=$uid;pwd=" + $pwd + ";database=$db;Pooling=False"
	Write-Debug "Connection string ($connStr)"
	$conn = New-Object MySql.Data.MySqlClient.MySqlConnection($connStr)
	Write-Verbose "Opening connection to MySQL database server ($server)"
	$conn.Open()
	
	# Create a MySqlCommand and MySqlDataAdapter object 
	$cmd = New-Object MySql.Data.MySqlClient.MySqlCommand("SHOW FULL PROCESSLIST;", $conn)
	$da = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($cmd)
	
	# Populate a dataset and output the query result
	Write-Verbose "Populate a dataset and output the query result..."
	$ds = New-Object System.Data.DataSet
	$da.Fill($ds) > $null
	$result = $ds.Tables[0]
	$result | Format-Table *
}

main

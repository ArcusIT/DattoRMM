function Get-DrmmSiteDevices {

	<#
	.SYNOPSIS
	Fetches the devices records of the site identified by the given site uid.

	.DESCRIPTION
	Returns device settings, device type, device anti-virus status, device patch Status and UDF's.

	.PARAMMETER siteUid
	Provide site uid which will be use to return this site devices.
	
	#>
    
	# Function Parameters
    Param (
        [Parameter(Mandatory=$True)] 
        $siteUid
    )

	# Validate Site UID
	if($siteUid.GetType().Name -ne 'String') {
		return 'The Site UID is not a string!'
	}
	elseif($siteUid -notmatch '[a-z0-9]{8}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{12}') {
		return 'The Site UID format is incorrect!'
	}
	
    # Declare Variables
    $apiMethod = 'GET'
    $maxPage = 50
    $nextPageUrl = $null
    $page = 0
    $Results = @()

    do {
	    $Response = New-ApiRequest -apiMethod $apiMethod -apiRequest "/v2/site/$siteUid/devices?max=$maxPage&page=$page" | ConvertFrom-Json
	    if ($Response) {
		    $nextPageUrl = $Response.pageDetails.nextPageUrl
		    $Results += $Response.devices
		    $page++
	    }
    }
    until ($nextPageUrl -eq $null)

    # Return all site devices
    return $Results

}
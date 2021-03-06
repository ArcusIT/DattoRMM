function Set-DrmmAlertUnmute {

	<#
	.SYNOPSIS
	Unmutes the alert identified by the given alert Uid.

	.DESCRIPTION
	Resume alert providing the alert Uid.

	.PARAMMETER alertUid
	Provide alert Uid to unmute the alert.
	
	#>

	# Function Parameters
    Param (
        [Parameter(Mandatory=$True)] 
        $alertUid
    )
	
	# Validate Alert Uid
	if($alertUid.GetType().Name -ne 'String') {
		return 'The Alert UID is not a String!'
	}
	elseif($alertUid -notmatch '[a-z0-9]{8}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{12}') {
		return 'The Alert UID format is incorrect!'
	}

	# Declare Variables
		$apiMethod = 'POST'

	# Unmute Alert
	New-ApiRequest -apiMethod $apiMethod -apiRequest "/v2/alert/$alertUid/unmute"

}
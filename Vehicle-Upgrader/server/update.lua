local label =
  [[
  ||                     _       _          _                                 
  ||     __   __   ___  | |__   (_)   ___  | |   ___       _ __ ___     ___   _ __    _   _ 
  ||     \ \ / /  / _ \ | '_ \  | |  / __| | |  / _ \     | '_ ` _ \   / _ \ | '_ \  | | | |
  ||      \ V /  |  __/ | | | | | | | (__  | | |  __/     | | | | | | |  __/ | | | | | |_| |
  ||       \_/    \___| |_| |_| |_|  \___| |_|  \___|     |_| |_| |_|  \___| |_| |_|  \__,_|
  ||                                    By Llewellyn-17
  ||]]

Citizen.CreateThread(function()
	local CurrentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
	if not CurrentVersion then
		print('^1Vehicle Menu Version Check Failed!^7')
	end

	function VersionCheckHTTPRequest()
		PerformHttpRequest('https://raw.githubusercontent.com/Shadow-Develops/version-api/main/extramenu.json', VersionCheck, 'GET')
	end

	function VersionCheck(err, response, _)
		Citizen.Wait(3000)
		if err == 200 then
			local Data = json.decode(response)
			if CurrentVersion ~= Data.version then
				print( label )
				print('  ||    \n  ||    Vehicle Menu is outdated!')
				print('  ||    Your version: ^2' .. CurrentVersion .. '^7')
				print('  ||    Please download the lastest version from ^5https://github.com/Llewellyn-17/FiveM-Vehicle-Upgrades ^7')
				
			else
				print( label )
				print('  ||    ^2Vehicle Menu is up to date! Good job!\n^0  ||\n  \\\\\n')
			end
		else
			print( label )
			print('  ||    ^1There was an error getting the latest version information!    ||\n  \\\\\n')
		end

		SetTimeout(60000000, VersionCheckHTTPRequest)
	end

	VersionCheckHTTPRequest()
end)
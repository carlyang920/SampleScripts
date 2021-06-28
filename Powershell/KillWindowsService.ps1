Get-ChildItem -Path "[folder path]\*.exe" -File -Recurse | ForEach-Object {
    if ($_.Name.StartsWith('_')) {
		$_ | Rename-Item -NewName $_.Name.TrimStart('_')
		Start-Service -Name $_.Name.TrimStart('_').Replace(".exe", "")
	} else {
		$_ | Rename-Item -NewName ('_' + $_.Name)
		$_ | taskkill /f /im $_.Name.TrimStart('_')
	}
}
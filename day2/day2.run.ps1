. $PSScriptRoot/day2.ps1

$dayInput = Get-Content -Raw "$PSScriptRoot/day2.input.txt"
Write-Output (PlayGame $dayInput)
Write-Output (PlayPart2Game $dayInput)

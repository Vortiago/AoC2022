. $PSScriptRoot/day2.ps1

$dayInput = Get-Content -Raw "$PSScriptRoot/day2.input.txt"
Write-Host (PlayGame $dayInput)
Write-Host (PlayPart2Game $dayInput)

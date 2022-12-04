. $PSScriptRoot/day3.ps1

$dayInput = Parse (Get-Content -Raw "day3.input.txt")
Write-Host (SumAllErrors $dayInput)
Write-Host (SumAllBadges $dayInput)

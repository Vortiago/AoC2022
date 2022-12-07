. $PSScriptRoot/day3.ps1

$dayInput = Parse (Get-Content -Raw "day3.input.txt")
Write-Output (SumAllErrors $dayInput)
Write-Output (SumAllBadges $dayInput)

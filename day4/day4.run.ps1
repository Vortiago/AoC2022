. $PSScriptRoot/day4.ps1

$dayInput = Parse (Get-Content -Raw "day4.input.txt")
Write-Host (FindAllSectionsForReconsideration $dayInput)

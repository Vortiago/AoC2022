. $PSScriptRoot/day6.ps1

[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("UseDeclaredVarsMoreThanAssignments", "")]
$day6Input = Get-Content -Raw "day6.input.txt"
Write-Output (FindPositionAfterMarker $day6Input)
Write-Output (FindPositionAfterMarker $day6Input 14)

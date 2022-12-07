using module "./day7.psm1"

[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("UseDeclaredVarsMoreThanAssignments", "")]
$day7Input = Get-Content -Raw "day7.input.txt"
Write-Output (SolvePartOne $day7Input)
Write-Output (SolvePartTwo $day7Input)

Remove-Module day7

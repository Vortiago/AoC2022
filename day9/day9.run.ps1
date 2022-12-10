using module "./day9.psm1"

[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("UseDeclaredVarsMoreThanAssignments", "")]
$day9Input = Get-Content -Raw "day9.input.txt"
Write-Output (SolveDay9PartOne $day9Input)
Write-Output (SolveDay9PartTwo $day9Input)

Remove-Module day9

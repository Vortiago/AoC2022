using module "./day11.psm1"

[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("UseDeclaredVarsMoreThanAssignments", "")]
$day11Input = Get-Content -Raw "day11.input.txt"
Write-Output (SolveDay11PartOne $day11Input)
Write-Output ("TODO")

Remove-Module day11

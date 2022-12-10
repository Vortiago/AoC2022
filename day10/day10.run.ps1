using module "./day10.psm1"

[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("UseDeclaredVarsMoreThanAssignments", "")]
$day10Input = Get-Content -Raw "day10.input.txt"
Write-Output (SolveDay10PartOne $day10Input)
Write-Output ("TODO")

Remove-Module day10

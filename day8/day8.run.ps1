using module "./day8.psm1"

[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("UseDeclaredVarsMoreThanAssignments", "")]
$day8Input = Get-Content -Raw "day8.input.txt"
Write-Output (SumAllVisibleTrees $day8Input)
Write-Output (FindHighestScenicValue $day8Input)

Remove-Module day8

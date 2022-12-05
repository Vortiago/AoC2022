. $PSScriptRoot/day1.ps1

$dayInput = Get-Content -Raw "$PSScriptRoot/day1.input.txt"
[System.Collections.ArrayList]$outputArray= @()
Parse -inputText $dayInput -outputArray ([ref]$outputArray)
$mostCalories = 0
MostCalories -inputArray $outputArray -sumMostCalories ([ref]$mostCalories)
Write-Host $mostCalories

[System.Collections.ArrayList]$sortedArray= @()
SortBySumCalories -inputArray $outputArray -sortedArray ([ref]$sortedArray)
Write-Host ($sortedArray[0] + $sortedArray[1] + $sortedArray[2])

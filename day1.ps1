function Parse($inputText, [ref]$outputArray) {

  $stringSplitOptions = [System.StringSplitOptions]::RemoveEmptyEntries
  foreach ($textElf in $inputText.Split([System.Environment]::NewLine + [System.Environment]::NewLine, $stringSplitOptions)) {
    [System.Collections.ArrayList]$elf= @()
    foreach($calorieCountText in $textElf.Split([System.Environment]::NewLine, $stringSplitOptions)) {
      $elf.Add([Int64]$calorieCountText)
    }
    
    $outputArray.Value.Add($elf)
  }
}

function MostCalories ($inputArray, [ref]$sumMostCalories) {
  foreach ($elf in $inputArray) {
    $sumCalories = ($elf | Measure-Object -Sum).Sum
    if ($sumCalories -gt $sumMostCalories.Value) {
      $sumMostCalories.Value = $sumCalories
    }
  }
}

function SortBySumCalories($inputArray, [ref]$sortedArray) {
  [System.Collections.ArrayList]$tmpArray= @()
  foreach ($elf in $inputArray) {
    $tmpArray.Add(($elf | Measure-Object -Sum).Sum)
  }

  $sortedArray.Value = $tmpArray | Sort-Object -Descending
}

$dayInput = Get-Content -Raw "day1.input.txt"
[System.Collections.ArrayList]$outputArray= @()
Parse -inputText $dayInput -outputArray ([ref]$outputArray)
$mostCalories = 0
MostCalories -inputArray $outputArray -sumMostCalories ([ref]$mostCalories)
Write-Host $mostCalories

[System.Collections.ArrayList]$sortedArray= @()
SortBySumCalories -inputArray $outputArray -sortedArray ([ref]$sortedArray)
Write-Host ($sortedArray[0] + $sortedArray[1] + $sortedArray[2])

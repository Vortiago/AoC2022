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

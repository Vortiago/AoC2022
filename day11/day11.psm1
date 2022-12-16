. $PSScriptRoot/../common.ps1

class Monkey {
  $Name
  $Items = @()
  $WorryLevelOperation
  $WorryLevelChange
  $ThrowTest
  $ThrowTargets = @{}
  $Inspections

  [void] Turn($otherMonkeys) {
    while($this.Items.Count -gt 0) {
      $this.Inspections += 1
      $itemForInspection = $this.Items[0]
      $this.Items = $this.Items.Where({$_ -ne $itemForInspection})
      $rightSide = $this.WorryLevelChange
      if ($rightSide -eq "old") {
        $rightSide = $itemForInspection
      }
      $rightSide = [Decimal]$rightSide
      if ($this.WorryLevelOperation -eq "+") {
        $itemForInspection = ($itemForInspection + $rightSide) / [Decimal]3
      } elseif ($this.WorryLevelOperation -eq "*") {
        $itemForInspection = ($itemForInspection * $rightSide) / [Decimal]3
      }

      $itemForInspection = [Decimal]::Floor($itemForInspection)
      $otherMonkeys[$this.ThrowTargets[($itemForInspection % $this.ThrowTest) -eq [Decimal]0]].Receive($itemForInspection)
    }
  }

  [void] Receive($item) {
    $this.Items += $item
  }
}

function ParseMonkeyInput($monkeyInText) {
  $monkey = [Monkey]::new()
  $lines = $monkeyInText.Split([System.Environment]::NewLine)
  $monkey.Name = [Decimal]::Parse($lines[0].Split(" ")[1].Split(":")[0])
  $monkey.Items = $lines[1].Split(":")[1].Split(",").foreach({[Decimal]::Parse($_)})
  $monkey.WorryLevelOperation = $lines[2].Split("new = old ")[1].Split(" ")[0]
  $monkey.WorryLevelChange = $lines[2].Split("new = old ")[1].Split(" ")[1]
  $monkey.ThrowTest = [Decimal]::Parse($lines[3].Split("divisible by")[1])
  $monkey.ThrowTargets[$true] = [Decimal]::Parse($lines[4].Split(" throw to monkey")[1])
  $monkey.ThrowTargets[$false] = [Decimal]::Parse($lines[5].Split(" throw to monkey")[1])

  return $monkey
}

function SplitMonkeyInput($textInput) {
  return DefaultParser $textInput ([System.Environment]::NewLine + [System.Environment]::NewLine )
}

function Round($monkies) {
  foreach ($monkey in $monkies) {
    $monkey.Turn($monkies)
  }
}

function PlayGame($rounds = 1, $inputText) {
  $monkies = (SplitMonkeyInput $inputText).foreach({ParseMonkeyInput $_})
  for ($round = 0; $round -lt $rounds; $round++) {
    Round($monkies)
  }

  return $monkies
}

function SolveDay11PartOne($inputText) {
  $sortedList = (PlayGame 20 $inputText).Inspections | Sort-Object -Descending
  return $sortedList[0] * $sortedList[1]
} 

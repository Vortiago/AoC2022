Add-Type -TypeDefinition @"
public enum HandValues
{
   Rock = 1,
   Paper = 2,
   Scissor = 3
}
"@

Add-Type -TypeDefinition @"
public enum PossibleResults
{
   Loose = 0,
   Tie = 3,
   Win = 6
}
"@

# Rock: A, X
# Paper: B, Y
# Scissor: C, Z
# A, X > C, Z
# B, Y > A, X
# C, Z > B, Y

# X = Loose
# Y = Tie
# Z = Win

function GetHandValue($right) {
  $score = 0
  switch ($right) {
    "X" { $score = [int][HandValues]::Rock }
    "Y" { $score = [int][HandValues]::Paper }
    "Z" { $score = [int][HandValues]::Scissor }
    "A" { $score = [int][HandValues]::Rock }
    "B" { $score = [int][HandValues]::Paper }
    "C" { $score = [int][HandValues]::Scissor }
    Default {}
  }

  return $score
}

$winTable = @{
  "A" = [HandValues]::Paper;
  "B" = [HandValues]::Scissor;
  "C" = [HandValues]::Rock
}

$looseTable = @{
  "A" = [HandValues]::Scissor;
  "B" = [HandValues]::Rock;
  "C" = [HandValues]::Paper
}

function CheckGameRound($left, $right) {
  $score = GetHandValue $right

  if ($right -eq "X" -and $left -eq "A") {
    $score += [int][PossibleResults]::Tie
  } elseif ($right -eq "X" -and $left -eq "C") {
    $score += [int][PossibleResults]::Win
  } elseif ($right -eq "Y" -and $left -eq "B") {
    $score += [int][PossibleResults]::Tie
  } elseif ($right -eq "Y" -and $left -eq "A") {
    $score += [int][PossibleResults]::Win
  } elseif ($right -eq "Z" -and $left -eq "C") {
    $score += [int][PossibleResults]::Tie
  } elseif ($right -eq "Z" -and $left -eq "B") {
    $score += [int][PossibleResults]::Win
  }

  return $score
}

function CheckGameRoundPart2($left, $right) {
  $score = 0
  switch ($right) {
    "X" { $score += $looseTable[$left] }
    "Y" {
      $score += [PossibleResults]::Tie 
      $score += GetHandValue $left
    }
    "Z" {
      $score += [PossibleResults]::Win 
      $score += $winTable[$left] 
    }
    Default {}
  }

  return $score
}

function Parse($textInput) {
  $stringSplitOptions = [System.StringSplitOptions]::RemoveEmptyEntries
  return $textInput.Split([System.Environment]::NewLine, $stringSplitOptions)
}

function ParseRound($roundText) {
  return $roundText.Split(" ")
}

function PlayGame($rounds) {
  $sum = 0
  foreach ($round in (Parse $rounds)) {
    $hands = ParseRound $round
    $sum += CheckGameRound $hands[0] $hands[1]
  }

  return $sum
}

function PlayPart2Game($rounds) {
  $sum = 0
  foreach ($round in (Parse $rounds)) {
    $hands = ParseRound $round
    $sum += CheckGameRoundPart2 $hands[0] $hands[1]
  }

  return $sum
}

$dayInput = Get-Content -Raw "$PSScriptRoot/day2.input.txt"
Write-Host (PlayGame $dayInput)
Write-Host (PlayPart2Game $dayInput)

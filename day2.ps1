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

function GetHandValue($right) {
  $score = 0
  switch ($right) {
    "X" { $score = [int][HandValues]::Rock }
    "Y" { $score = [int][HandValues]::Paper }
    "Z" { $score = [int][HandValues]::Scissor }
    Default {}
  }

  return $score
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

$dayInput = Get-Content -Raw "day2.input.txt"
Write-Host (PlayGame $dayInput)

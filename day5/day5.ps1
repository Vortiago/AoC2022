. $PSScriptRoot/../common.ps1

function ParseInitialState($inputText) {
  $initialText = (ParseSplitInTwo $inputText)[0]
  $stacks = FindAllStacks $initialText
  foreach ($row in SplitStackRows $initialText) {
    for ($stack=1; $stack -le $stacks.Count; $stack++) {
      $crate = ParseCrateOnStack $row $stack
      if ($crate -ne " ") {
        $stacks[[string]$stack].Push($crate)
      }
    }
  }

  return $stacks
}

function ParseSplitInTwo($inputText) {
  return DefaultParser $inputText ([System.Environment]::NewLine + [System.Environment]::NewLine)
}

function SplitStackRows($inputText) {
  $rows = $inputText.Split([System.Environment]::NewLine)
  return $rows[-2..(-$rows.Length)]  
}

function FindAllStacks($inputText) {
  $row = $inputText.Split([System.Environment]::NewLine)[-1]
  $stacks = @{}
  foreach ($stack in $row.Split(" ").Where({$_ -ne ""})) {
    $stacks[$stack] = New-Object System.Collections.Generic.Stack[String]
  }

  return $stacks
}

function ParseCrateOnStack($row, $stack) {
  try {
    return $row[1+(4*($stack-1))]
  } catch {
    return " "
  }
}

function ParseCommands($row) {
  $parsedRow = $row.Trim(" ").Split(" ")
  return $parsedRow[1], $parsedRow[3], $parsedRow[5]
}

function RunCommand($cmd, $stacks) {
  for($crate = 0; $crate -lt $cmd[0]; $crate++) {
    $crane = $stacks[$cmd[1]].Pop()
    $stacks[$cmd[2]].Push($crane)
  }

  return $stacks
}

function RunCrane($inputText) {
  $initialParse = ParseSplitInTwo $inputText
  $stacks = ParseInitialState $inputText
  $commands = $initialParse[1].Trim().Split([System.Environment]::NewLine)
  foreach($command in $commands) {
    $parsedCommands = ParseCommands $command
    $stacks = RunCommand $parsedCommands $stacks
  }

  return $stacks
}

function PartOneSolution($inputText) {
  $stacks = RunCrane $inputText
  $solution = ""
  for($stack=1; $stack -le $stacks.Count; $stack++) {
    $solution += $stacks[[string]$stack].Pop()
  }

  return $solution
}

function PartTwoSolution($inputText) {
  $stacks = RunCrateMover9001 $inputText
  $solution = ""
  for($stack=1; $stack -le $stacks.Count; $stack++) {
    $solution += $stacks[[string]$stack].Pop()
  }

  return $solution
}

function RunCrateMover9001($inputText) {
  $initialParse = ParseSplitInTwo $inputText
  $stacks = ParseInitialState $inputText
  $commands = $initialParse[1].Trim().Split([System.Environment]::NewLine)
  foreach($command in $commands) {
    $parsedCommands = ParseCommands $command
    $stacks = RunCrateMover9001Command $parsedCommands $stacks
  }

  return $stacks
}

function RunCrateMover9001Command($cmd, $stacks) {
  $crane = New-Object System.Collections.Generic.List[String]
  for($crate = 0; $crate -lt $cmd[0]; $crate++) {
    $crane.Add($stacks[$cmd[1]].Pop())
  }
  $crane.Reverse()
  foreach($crate in $crane) {
    $stacks[$cmd[2]].Push($crate)
  }

  return $stacks
}

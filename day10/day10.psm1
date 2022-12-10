. $PSScriptRoot/../common.ps1

class CPU {
  $Cycles
  $RegistryX
  $CyclesToCheck
  $CycleStrengths

  [void] Noop(){
    $this.Cycles += 1
  }

  [void] AddX($value) {
    $this.Cycles += 2 
    $this.CheckCycle()
    $this.RegistryX += $value
  }

  [void] CheckCycle() {
    if ($this.CyclesToCheck.Count -eq 0) {
      return
    }

    if ($this.Cycles -ge $this.CyclesToCheck[0]) {
      $this.CycleStrengths += ($this.CyclesToCheck[0] * $this.RegistryX)
      $this.CyclesToCheck = $this.CyclesToCheck.where({$_ -ne $this.CyclesToCheck[0]})
    }
  }
}

function CreateCPU($cyclesToCheck = @()) {
  $cpu = [CPU]::new()
  $cpu.Cycles = 0
  $cpu.RegistryX = 1
  $cpu.CyclesToCheck = $cyclesToCheck
  $cpu.CycleStrengths = @()
  return $cpu
}

function ParseInstruction($inputLine) {
  $components = $inputLine.Split(" ")
  if ($components.Count -eq 1) {
    return @{Instruction = $components[0]; Value = $null}
  }
  return @{Instruction = $components[0]; Value =  [int]::Parse($components[1])}
}

function RunInstructionsOnCPU($inputText, $cyclesToCheck = @()) {
  $cyclesToCheck = $cyclesToCheck | Sort-Object
  $cpu = CreateCPU $cyclesToCheck
  foreach ($line in (DefaultParser $inputText)) {
    $instruction = ParseInstruction $line
    if ($instruction.Instruction -eq "addx") {
      $cpu.AddX($instruction.Value)
    } else {
      $cpu.Noop()
    }
  }

  return $cpu
}

function SolveDay10PartOne($inputText) {
  $cyclesToCheck = @(20, 60, 100, 140, 180, 220)
  return ((RunInstructionsOnCPU $inputText $cyclesToCheck).CycleStrengths | Measure-Object -Sum).Sum
}

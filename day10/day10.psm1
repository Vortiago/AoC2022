. $PSScriptRoot/../common.ps1

class CPU {
  $Cycles
  $RegistryX
  $Program
  $CurrentInstruction
  $CyclesToCheck
  $CycleStrengths
  $CRT

  [void] LoadProgram($inputText) {
    $this.Program = (DefaultParser $inputText).foreach({(ParseInstruction $_)})
    $this.CurrentInstruction = $this.Program[0]
    $this.CRT = [CRT]::new()
  }

  [void] Run() {
    while ($this.Program.Count -ge 0 -and $null -ne $this.CurrentInstruction) {
      $this.Cycles += 1
      $this.CRT.Execute($this)
      $this.CheckCycle()
      $done = $this.CurrentInstruction.Execute($this)
      if ($done -eq $true) {
        $this.Program = $this.Program.Where({$_ -ne $this.CurrentInstruction})
        $this.CurrentInstruction = $this.Program[0]
      }
    }
  }

  [void] CheckCycle() {
    if ($this.CyclesToCheck.Count -ne 0 -and $this.Cycles -ge $this.CyclesToCheck[0]) {
      $this.CycleStrengths += ($this.CyclesToCheck[0] * $this.RegistryX)
      $this.CyclesToCheck = $this.CyclesToCheck.where({$_ -ne $this.CyclesToCheck[0]})
    }
  }
}

class Noop {
  [bool] Execute($cpu) {
    return $true
  }
}

class AddX {
  $Cycles = 2
  $Value

  AddX($value) {
    $this.Value = $value
  }

  [bool] Execute($cpu) {
    $this.Cycles -= 1
    if ($this.Cycles -eq 0) {
      $cpu.RegistryX += $this.Value
      return $true
    }

    return $false
  }
}

class CRT {
  $Display

  [void] Execute($cpu) {
    $sprite = GetSpriteFromRegistry $cpu.RegistryX
    if ((($cpu.Cycles-1) % 40) -in $sprite) {
      $this.Display += "#"
    } else {
      $this.Display += "."
    }

    if ($cpu.Cycles -lt 240 -and ($cpu.Cycles % 40) -eq 0) {
      $this.Display += [System.Environment]::NewLine
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
    return [Noop]::new()
  }
  return [AddX]::new([int]::Parse($components[1]))
}

function GetSpriteFromRegistry($registry) {
  return @(($registry - 1), $registry, ($registry + 1))
}

function RunInstructionsOnCPU($inputText, $cyclesToCheck = @()) {
  $cyclesToCheck = $cyclesToCheck | Sort-Object
  $cpu = CreateCPU $cyclesToCheck
  $cpu.LoadProgram($inputText)
  $cpu.Run()
  return $cpu
}

function SolveDay10PartOne($inputText) {
  $cyclesToCheck = @(20, 60, 100, 140, 180, 220)
  return ((RunInstructionsOnCPU $inputText $cyclesToCheck).CycleStrengths | Measure-Object -Sum).Sum
}

function SolveDay10PartTwo($inputText) {
  $cpu = RunInstructionsOnCPU $inputText
  return $cpu.CRT.Display
}

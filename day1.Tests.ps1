BeforeAll {
  . $PSScriptRoot/day1.ps1

  $elves = "1000
2000
3000

4000

5000
6000

7000
8000
9000

10000"
  $elves
}

Describe "MostCalories" {
  It "Should return 24000" {
    [System.Collections.ArrayList]$outputArray= @()
    Parse -inputText $elves -outputArray ([ref]$outputArray)
    $mostCalories = 0
    MostCalories -inputArray $outputArray -sumMostCalories ([ref]$mostCalories)
    $mostCalories | Should -Be 24000
  }
}

Describe "SortBySumCalories" {
  It "First index should be 24000" {
    [System.Collections.ArrayList]$outputArray= @()
    Parse -inputText $elves -outputArray ([ref]$outputArray)
    [System.Collections.ArrayList]$sortedSumArray= @()
    SortBySumCalories -inputArray $outputArray -sortedArray ([ref]$sortedSumArray)
    $sortedSumArray[0] | Should -Be 24000
    $sortedSumArray[4] | Should -Be 4000
  }
}

Describe "SortBySumCalories" {
  It "Top three elves should have 45000 calories." {
    [System.Collections.ArrayList]$outputArray= @()
    Parse -inputText $elves -outputArray ([ref]$outputArray)
    [System.Collections.ArrayList]$sortedSumArray= @()
    SortBySumCalories -inputArray $outputArray -sortedArray ([ref]$sortedSumArray)
    ($sortedSumArray[0] + $sortedSumArray[1] + $sortedSumArray[2]) | Should -be 45000
  }
}

Describe "Parse" {
  It "Parsing should give an array with 5 elves." {
    [System.Collections.ArrayList]$outputArray= @()
    Parse -inputText $elves -outputArray ([ref]$outputArray)
    $outputArray.Count | Should -Be 5
  }
}

Describe "Parse" {
  It "First element should be an array of count 3 and last element should be of count 1." {
    [System.Collections.ArrayList]$outputArray= @()
    Parse -inputText $elves -outputArray ([ref]$outputArray)
    $outputArray[0].Count | Should -Be 3
    $outputArray[4].Count | Should -Be 1
  }
}

Describe "Parse" {
  It "First value in first element should be integer 1000." {
    [System.Collections.ArrayList]$outputArray= @()
    Parse -inputText $elves -outputArray ([ref]$outputArray)
    $outputArray[0][0] -is [Int64] | Should -be $true
    $outputArray[0][0] | Should -be 1000
  }
}

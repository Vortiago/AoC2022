BeforeAll {
  . $PSScriptRoot/day3.ps1

  $inputText = "vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw"

  $inputText
}

Describe "GetItemPrioritisationValue" {
  It "Should return int values based on the letter aA to zZ in the range 1..52" {
    GetItemPrioritisationValue "a" | Should -be 1
    GetItemPrioritisationValue "A" | Should -be 27
    GetItemPrioritisationValue "p" | Should -be 16
    GetItemPrioritisationValue "L" | Should -be 38
  }
}

Describe "SplitIntoCOmpartments" {
  It "Should split a rutsack into two equal size compartments" {
    $rucksacks = Parse $inputText
    $compartments = SplitIntoCompartments $rucksacks[0]
    $compartments.Count | Should -be 2
    $compartments[0] | Should -be "vJrwpWtwJgWr"
    $compartments[1] | Should -be "hcsFMMfFFhFp"
  }
}

Describe "FindTheError" {
  It "Should find the letter that is in both compartments." {
    $rucksacks = Parse $inputText
    $compartments = SplitIntoCompartments $rucksacks[0]
    $errorItem = FindTheError $compartments
    $errorItem | Should -be "p"

    $compartments = SplitIntoCompartments $rucksacks[1]
    $errorItem = FindTheError $compartments
    $errorItem | Should -be "L"
  }
}

Describe "SumAllErrors" {
  It "Should sum all errors like in the example." {
    $rucksacks = Parse $inputText
    SumAllErrors $rucksacks | Should -be 157
  }
}

Describe "FindBadge" {
  It "Should return the badge for the group" {
    $rucksacks = Parse $inputText
    FindBadge $rucksacks[0] $rucksacks[1] $rucksacks[2] | Should -be 'r'
    FindBadge $rucksacks[3] $rucksacks[4] $rucksacks[5] | Should -be 'Z'
  }
}

Describe "SumAllBadges" {
  It "Should sum all badges in the groups as in the example." {
    $rucksacks = Parse $inputText
    SumAllBadges $rucksacks | Should -be 70
  }
}

using module "./day8.psm1"

BeforeAll {
  [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("UseDeclaredVarsMoreThanAssignments", "")]
  $inputText = "30373
25512
65332
33549
35390"
}

Describe "BuildForest" {
  It "Should parse the text represantion of a forest." `
  -TestCases `
    @{row = 0; column = 0; expected = 3},
    @{row = 0; column = 3; expected = 7},
    @{row = 2; column = 2; expected = 3},
    @{row = 4; column = 0; expected = 3},
    @{row = 4; column = 4; expected = 0} {
    param (
      $row,
      $column,
      $expected
    )
    $forest = BuildForest $inputText
    ($forest.Rows[$row][$column][0]).Height | Should -be $expected
  }
}

Describe "CheckVisibility" {
  It "Tree visibility should be set after walking around and looking in." `
  -TestCases `
    @{row = 0; column = 0; expected = $true},
    @{row = 0; column = 3; expected = $true},
    @{row = 0; column = 2; expected = $true},
    @{row = 2; column = 2; expected = $false},
    @{row = 1; column = 3; expected = $false},
    @{row = 4; column = 0; expected = $true},
    @{row = 3; column = 1; expected = $false},
    @{row = 4; column = 2; expected = $true},
    @{row = 4; column = 4; expected = $true} {
    param (
      $row,
      $column,
      $expected
    )
    $forest = BuildForest $inputText
    CheckVisibility $forest[0]
    ($forest.Rows[$row][$column]).Visible | Should -be $expected
  }
}

Describe "SumAllVisibleTrees" {
  It "Should give a sum of how many trees are visible." {
    SumAllVisibleTrees $inputText | Should -be 21
  }
}

Describe "FindHighestScenicValue" {
  It "Should give the highest scenic score possible" {
    FindHighestScenicValue $inputText | Should -be 8
  }
}

Describe "FindScenicValueOfTree" {
  It "Should calculate the scenic value of a tree" {
    $forest = BuildForest $inputText
    CheckVisibility $forest[0]
    FindScenicValueOfTree $forest[0] $forest[0].Rows[3][2] | Should -be 8
    FindScenicValueOfTree $forest[0] $forest[0].Rows[1][2] | Should -be 4
  }
}

AfterAll {
  Remove-Module day8
}

BeforeAll {
  . $PSScriptRoot/day4.ps1

  $inputText = "2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
"
  $inputText
}

Describe "ParseSection" {
  It "Converts text representation of a section to int array." {
    $section = ParseSection "2-4"
    $section.Count | Should -be 2
    $section[0] | Should -be 2
    $section[1] | Should -be 4

    $section = ParseSection "51-82"
    $section[0] | Should -be 51
    $section[1] | Should -be 82
  }
}

Describe "SectionInOtherSection" {
  It "Checks to see if a section is contained in a bigger section." {

    SectionInOtherSection (ParseSection "2-4") (ParseSection "6-8") | Should -be 0
    SectionInOtherSection (ParseSection "2-8") (ParseSection "3-7") | Should -be 1
    SectionInOtherSection (ParseSection "6-6") (ParseSection "4-6") | Should -be 1
  }
}

Describe "FindAllSectionsForReconsideration" {
  It "Finds all section contained within a bigger section." {
    $sectionAssigments = Parse $inputText
    FindAllSectionsForReconsideration $sectionAssigments | Should -be 2
  }
}

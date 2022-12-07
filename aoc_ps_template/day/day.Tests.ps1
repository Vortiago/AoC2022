using module "./day.psm1"

BeforeAll {
  [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("UseDeclaredVarsMoreThanAssignments", "")]
  $inputText = ""
}

AfterAll {
  Remove-Module day
}

function DefaultParser($inputText, $split = [System.Environment]::NewLine) {
  $stringSplitOptions = [System.StringSplitOptions]::RemoveEmptyEntries
  return $inputText.Split($split, $stringSplitOptions)
}

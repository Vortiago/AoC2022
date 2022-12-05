function DefaultParser($inputText, $split) {
  $stringSplitOptions = [System.StringSplitOptions]::RemoveEmptyEntries
  return $inputText.Split($split, $stringSplitOptions)
}

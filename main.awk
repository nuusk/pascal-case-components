function capitalizeString(strRaw) {
  strFirstLetter = substr(strRaw, 1, 1)
  strTail = substr( strRaw, 2 )
  return toupper(strFirstLetter) strTail
}

function convertToPascalCase(strRaw, separatorInRegex) {
  split(strRaw, strSections, separatorInRegex)
  strBeforeTagOpen = strSections[1]
  strAfterTagOpen = strSections[2]

  split(strAfterTagOpen, strAfterTagOpenSections, " ")
  strKebabCase = strAfterTagOpenSections[1]
  strSufix = ""
  for (i in strAfterTagOpenSections) {
    if (i == 1) {
      continue;
    }
    strSufix = strSufix " " strAfterTagOpenSections[i]
  }

  split(strKebabCase, kebabCaseSections, "-")
  strPascalCase = ""
  for (j in kebabCaseSections) {
    strPascalCase = strPascalCase capitalizeString(kebabCaseSections[j])
  }

  strPascalCaseWithPrefix = strBeforeTagOpen separatorInRegex strPascalCase strSufix

  return strPascalCaseWithPrefix
}

{
  if ($0 ~ /.*<[a-zA-Z0-9]+([-]+[a-zA-Z0-9]+)+.*/) {
    strPascalCase = convertToPascalCase($0, "<")
    print strPascalCase
  } else if ($0 ~ /.*<\/[a-zA-Z0-9]+([-]+[a-zA-Z0-9]+)+.*/) {
    strPascalCase = convertToPascalCase($0, "</")
    print strPascalCase
  } else {
    print $0
  }
}

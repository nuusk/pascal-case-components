function capitalizeString(strRaw) {
  strFirstLetter = substr(strRaw, 1, 1)
  strTailConverted = substr( strRaw, 2 )
  return toupper(strFirstLetter) strTailConverted
}

function convertToPascalCase(strRaw, separatorInRegex) {
  split(strRaw, strSections, separatorInRegex)
  strBeforeTagOpen = strSections[1]
  strAfterTagOpen = ""
  for (i in strSections) {
    if (i == 1) {
      continue;
    } if (i == 2) {
      strAfterTagOpen = strAfterTagOpen strSections[i]
    } else {
      strAfterTagOpen = strAfterTagOpen separatorInRegex strSections[i]
    }

  }

  split(strAfterTagOpen, strAfterTagOpenSections, " ")
  strKebabCase = strAfterTagOpenSections[1]
  strTail = ""
  for (i in strAfterTagOpenSections) {
    if (i == 1) {
      continue;
    }
    strTail = strTail " " strAfterTagOpenSections[i]
  }

  split(strKebabCase, kebabCaseSections, "-")
  strPascalCase = ""
  for (j in kebabCaseSections) {
    strPascalCase = strPascalCase capitalizeString(kebabCaseSections[j])
  }

  strHead = strBeforeTagOpen separatorInRegex strPascalCase
  strHeadTail = ""
   if (strTail ~ /.*<[a-zA-Z0-9]+([-]+[a-zA-Z0-9]+)+.*/) {
    strHeadTail = strHead convertToPascalCase(strTail, "<")
  } else if (strTail ~ /.*<\/[a-zA-Z0-9]+([-]+[a-zA-Z0-9]+)+.*/) {
    strHeadTail = strHead convertToPascalCase(strTail, "</")
  } else {
    strHeadTail = strHead strTail
  }

  return strHeadTail
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

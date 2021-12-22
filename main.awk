function capitalizeString(strRaw) {
  strFirstLetter = substr(strRaw, 1, 1)
  strTail = substr( strRaw, 2 )
  return toupper(strFirstLetter) strTail
}

function convertToPascalCase(strRaw, separatorInRegex, iteration) {
  iteration++
  split(strRaw, strSections, separatorInRegex)
  strBeforeTagOpen = strSections[1]
  strAfterTagOpen = ""
  for (i in strSections) {
    if (i == 1) {
      continue;
    } if (i == 2) {
      strAfterTagOpen = strAfterTagOpen  strSections[i]
    } else {
      strAfterTagOpen = strAfterTagOpen separatorInRegex strSections[i]
    }

  }

  # print "string after: " strAfterTagOpen

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

  print "head: " strBeforeTagOpen separatorInRegex strPascalCase
  print "tail: " strSufix
  strSufixDoubleChecked = ""
   if (strSufix ~ /.*<[a-zA-Z0-9]+([-]+[a-zA-Z0-9]+)+.*/) {
    strSufixDoubleChecked = convertToPascalCase(strSufix, "<", iteration)
  } else if (strSufix ~ /.*<\/[a-zA-Z0-9]+([-]+[a-zA-Z0-9]+)+.*/) {
    strSufixDoubleChecked = convertToPascalCase(strSufix, "</", iteration)
  } else {
    strSufixDoubleChecked = strSufix
  }

  if (iteration == 1) {
    strPascalCaseWithPrefix = strBeforeTagOpen separatorInRegex strPascalCase strSufixDoubleChecked
  } else {
    strPascalCaseWithPrefix = strBeforeTagOpen separatorInRegex strPascalCase strSufixDoubleChecked
  }


  # print "strBeforeTagOpen: " strBeforeTagOpen
  # print "double checked: ", strSufixDoubleChecked
  # print "strPascalCaseWithPrefix: " strPascalCaseWithPrefix

  print "strPascalCaseWithPrefix: " strPascalCaseWithPrefix


  return strPascalCaseWithPrefix
}

{
  if ($0 ~ /.*<[a-zA-Z0-9]+([-]+[a-zA-Z0-9]+)+.*/) {
    strPascalCase = convertToPascalCase($0, "<", 0)
    print strPascalCase
  } else if ($0 ~ /.*<\/[a-zA-Z0-9]+([-]+[a-zA-Z0-9]+)+.*/) {
    strPascalCase = convertToPascalCase($0, "</", 0)
    print strPascalCase
  } else {
    print $0
  }
}

BEGIN {
  FS="";
  OUTPUT_SEPARATOR=""
}

function capitalizeString(strRaw) {
  strFirstLetter = substr(strRaw, 1, 1)
  strTail = substr( strRaw, 2 )
  return toupper(strFirstLetter) strTail
}

/.*<[a-zA-Z0-9]+([-]+[a-zA-Z0-9]+)+.*/ {
  print $0
  split($0, strSections, "<")
  strBeforeTagOpen = strSections[1]
  strAfterTagOpen = strSections[2]

  split(strAfterTagOpen, strAfterTagOpenSections, " ")
  strKebabCase = strAfterTagOpenSections[1]
  strSufix = strAfterTagOpenSections[2]

  split(strKebabCase, kebabCaseSections, "-")
  strPascalCase = ""
  for (j in kebabCaseSections) {
    strPascalCase = strPascalCase capitalizeString(kebabCaseSections[j])
  }

  strPascalCaseWithPrefix = strBeforeTagOpen "<" strPascalCase " " strSufix

  print strPascalCaseWithPrefix
}

# /.*<\/[a-zA-Z0-9]+([-]+[a-zA-Z0-9]+)+.*/ {
#   print $0
#   split($0, b, "<")
#   for (i in b) {
#     # print i, b[i]
#   }

#   split($b[1], q, "-")
#   for (j in q) {
#     print "j", j, q[j]
#   }

#   split($0,c,"-")
#   for (x in c) {
#     # print c[x]
#   }
# }

{
  # print $0
  for (i = 1; i <= NF; i++)  {
    initialInput[NR,i] = $i
  }

  if (NF > fieldsNumMax) {
    fieldsNumMax = NF
  }
}

END {
#   for (i = 1; i <= fieldsNumMax; i++) {
#     transposedInput = initialInput[1,i]

#     for (j = 2; j <= NR; j++) {
#       transposedInput = transposedInput OUTPUT_SEPARATOR initialInput[j,i]
#     }

#     print transposedInput
#   }
}

#!/bin/bash
set -e

echo cd.

curl "https://localise.biz/api/export/locale/en.strings?key=xNmOKcdSifoawk07EVWSEyWjAiaHR65w5" | iconv -f utf-16 -t utf-8 > "./ParentDriver/Resources/Strings/en.lproj/Localizable.strings"

sed -i '' '/* Exported at:/d' "./ParentDriver/Resources/Strings/en.lproj/Localizable.strings"


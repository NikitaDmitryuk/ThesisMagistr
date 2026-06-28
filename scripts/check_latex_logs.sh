#!/usr/bin/env sh
set -eu

files="$(find . -maxdepth 1 -type f \( -name '*.log' -o -name '*.blg' \) | sort)"

if [ -z "$files" ]; then
  echo "No LaTeX or BibTeX logs found."
  exit 0
fi

status=0
critical_patterns='I couldn.t open style file|I found no \\bibstyle command|I found no \\bibdata command|Database file .* not found|Warning--I didn.t find a database entry|can.t start a style-file command|LaTeX Warning: Reference .* undefined|LaTeX Warning: Citation .* undefined|There were undefined references|multiply defined|destination with the same identifier|Fatal error|! LaTeX Error'
warning_patterns='(^| )(LaTeX|Package|Class|pdfTeX) .*Warning|^Warning--'

for file in $files; do
  if grep -nEi "$critical_patterns" "$file"; then
    echo "Critical LaTeX/BibTeX issue found in $file"
    status=1
  fi
done

warning_count="$(grep -hEi "$warning_patterns" $files | wc -l | tr -d ' ')"
echo "LaTeX/BibTeX warning summary: $warning_count warning line(s)."

if [ "$warning_count" != "0" ]; then
  grep -nEi "$warning_patterns" $files || true
fi

exit "$status"

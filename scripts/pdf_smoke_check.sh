#!/usr/bin/env sh
set -eu

check_pdf() {
  pdf="$1"
  expected_pages="$2"

  if [ ! -s "$pdf" ]; then
    echo "$pdf is missing or empty."
    return 1
  fi

  pages="$(pdfinfo "$pdf" | awk '/^Pages:/ {print $2}')"
  if [ "$pages" != "$expected_pages" ]; then
    echo "$pdf has $pages page(s), expected $expected_pages."
    return 1
  fi

  first_page_text_size="$(pdftotext -f 1 -l 1 "$pdf" - | tr -d '[:space:]' | wc -c | tr -d ' ')"
  if [ "$first_page_text_size" -eq 0 ]; then
    echo "$pdf has no extractable text on the first page."
    return 1
  fi

  echo "$pdf smoke check passed: $pages page(s)."
}

check_pdf diploma.pdf 69
check_pdf presentation.pdf 24

import os
import regex

from pathlib import Path
import bibtexparser

def find_tex_files(directory):
    return list(Path(directory).glob('*.tex'))

def find_citations(tex_files):
    citations = set()
    for file_name in tex_files:
        with open(file_name, 'r') as f:
            content = f.read()
            cited_keys = regex.findall(r"(?<!\\)%.+(*SKIP)(*FAIL)|\\(?:no)?citep?\{(?P<author>(?!\*)[^{}]+)\}", content)
            for keys in cited_keys:
                keys = regex.sub(r'\s+', '', keys)  # Remove any whitespace within the citation keys
                citations.update(keys.split(','))
    return citations

def process_bib_file(bib_file, citations):
    with open(bib_file, 'r') as f:
        bib_database = bibtexparser.load(f)

    updated_entries = []

    for entry in bib_database.entries:
        if entry['ID'].lower() in {citation.lower() for citation in citations}:
            updated_entries.append(entry)

    bib_database.entries = updated_entries

    with open(f"{bib_file}.new", 'w') as f:
        bibtexparser.dump(bib_database, f)

def main():
    bib_file = "bibliography.bib"
    tex_directory = "../chapters"

    tex_files = find_tex_files(tex_directory)
    print(f"Searching for citations in files: {', '.join(map(str, tex_files))}")
    citations = find_citations(tex_files)
    print(f"Number of citations found: {len(citations)}")
    print(f"Found citations: {', '.join(citations)}")
    process_bib_file(bib_file, citations)

if __name__ == '__main__':
    main()

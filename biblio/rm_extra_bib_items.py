#!/usr/bin/env python3
import sys
import regex
from pathlib import Path

try:
    import bibtexparser
except ImportError:
    print("Ошибка: требуется установить bibtexparser")
    print("Установите через: pip install bibtexparser")
    sys.exit(1)

def find_tex_files(directory):
    return list(Path(directory).rglob('*.tex'))

def find_citations(tex_files):
    citations = set()
    for file_name in tex_files:
        try:
            with open(file_name, 'r', encoding='utf-8') as f:
                content = f.read()
                cited_keys = regex.findall(
                    r"(?<!\\)%.+(*SKIP)(*FAIL)|\\(?:no)?citep?\{(?P<author>(?!\*)[^{}]+)\}", 
                    content
                )
                for keys in cited_keys:
                    keys = regex.sub(r'\s+', '', keys)
                    citations.update(keys.split(','))
        except Exception as e:
            print(f"Предупреждение: не удалось прочитать {file_name}: {e}")
    return citations

def process_bib_file(bib_file, citations):
    try:
        with open(bib_file, 'r', encoding='utf-8') as f:
            bib_database = bibtexparser.load(f)
    except FileNotFoundError:
        print(f"Ошибка: файл {bib_file} не найден")
        sys.exit(1)
    except Exception as e:
        print(f"Ошибка при чтении {bib_file}: {e}")
        sys.exit(1)

    original_count = len(bib_database.entries)
    updated_entries = []
    citations_lower = {citation.lower() for citation in citations}

    for entry in bib_database.entries:
        if entry['ID'].lower() in citations_lower:
            updated_entries.append(entry)

    bib_database.entries = updated_entries
    removed_count = original_count - len(updated_entries)

    output_file = f"{bib_file}.new"
    with open(output_file, 'w', encoding='utf-8') as f:
        bibtexparser.dump(bib_database, f)
    
    print(f"Удалено неиспользуемых записей: {removed_count}")
    print(f"Оставлено записей: {len(updated_entries)}")
    print(f"Результат сохранен в: {output_file}")

def main():
    script_dir = Path(__file__).parent
    bib_file = script_dir / "bibliography.bib"
    tex_directory = script_dir.parent / "chapters"

    if not tex_directory.exists():
        print(f"Ошибка: директория {tex_directory} не найдена")
        sys.exit(1)

    print("=" * 60)
    print("Очистка файла библиографии от неиспользуемых записей")
    print("=" * 60)
    
    tex_files = find_tex_files(tex_directory)
    if not tex_files:
        print(f"Предупреждение: не найдено .tex файлов в {tex_directory}")
        sys.exit(1)
        
    print(f"\nНайдено .tex файлов: {len(tex_files)}")
    print(f"Поиск цитирований в: {tex_directory}")
    
    citations = find_citations(tex_files)
    print(f"\nНайдено уникальных цитирований: {len(citations)}")
    
    if citations:
        print(f"\nОбработка файла: {bib_file}")
        process_bib_file(str(bib_file), citations)
        print("\n✓ Готово!")
    else:
        print("\nПредупреждение: не найдено ни одного цитирования")

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print("\n\nПрервано пользователем")
        sys.exit(0)
    except Exception as e:
        print(f"\nОшибка: {e}")
        sys.exit(1)

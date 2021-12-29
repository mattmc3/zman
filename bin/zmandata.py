#!/usr/bin/env python3

"""
Generate zman data from Zsh .html docs
"""

import os
from pathlib import Path
from collections import namedtuple
from operator import attrgetter
from bs4 import BeautifulSoup

IndexEntry = namedtuple("IndexEntry", "phrase category indexed_at url section section_url")
endash = '\u2013'
emdash = '\u2014'


def scrub(s):
    s = s.replace(endash, "--")
    s = s.replace(emdash, "--")
    return s


def process_tables(tbls, indexed_at, category):
    entries = []
    for tbl in tbls:
        for row in tbl("tr"):
            tds = row("td")
            # example:
            # [<td></td>,
            # <td valign="top"><a href="Options.html#index-C_005fPRECEDENCES"><code>C_PRECEDENCES</code></a></td>,
            # <td> </td>,
            # <td valign="top"><a href="Options.html#Scripts-and-Functions">16.2.9 Scripts and Functions</a></td>]
            if len(tds) == 4:
                try:
                    phrase = scrub(tds[1].a.get_text())
                    url = tds[1].a["href"]
                    section = tds[3].a.get_text()
                    section_url = tds[3].a["href"]
                    entry = IndexEntry(phrase, category, indexed_at, url, section, section_url)
                    entries.append(entry)
                except Exception as ex:
                    print("!!!Issue parsing row!!!")
                    print(ex)
                    print(tds)
    return entries

def save_zdoc_entries(prjdir, zdoc_entries):
    zdoc_entries_sorted = sorted(zdoc_entries, key=lambda x: x.phrase.lower())
    zman_data_path = prjdir / "docs" / "zmandata.tsv"
    print(f"writing {zman_data_path.name}")
    with zman_data_path.open('w') as f:
        f.write("\t".join(IndexEntry._fields) + "\n")
        for e in zdoc_entries_sorted:
            f.write("\t".join(e) + "\n")

    zman_dict = {}
    for e in zdoc_entries_sorted:
        key = f"{e.phrase} ({e.section})"
        value = e.url
        dupenum = 0
        while key in zman_dict:
            dupenum += 1
            key = f"{e.phrase} ({e.section} #{dupenum})"
        zman_dict[key] = value

    zman_lookup = prjdir / "lib" / "zman_lookup.zsh"
    print(f"writing {zman_lookup.name}")
    with zman_lookup.open('w') as f:
        f.write("typeset -gA zman_lookup=(\n")
        for key in sorted(zman_dict):
            value = zman_dict[key]
            f.write(f"  '{key}' '{value}'\n")
        f.write(")\n")

def main():
    prjdir = Path(__file__).absolute().parent.parent
    zmanindex_classes = {
        "concepts": "index-cp",
        "variables": "index-vr",
        "options": "index-pg",
        "functions": "index-fn",
        "editor-functions": "index-tp",
        "styles-and-tags": "index-ky",
    }
    zsh_docs_path = prjdir / "docs" / "zsh_html"

    zdoc_entries = []
    for filepath in zsh_docs_path.glob("*.html"):
        with filepath.open() as f:
            soup = BeautifulSoup(f, "html.parser")
        for k, v in zmanindex_classes.items():
            kwtables = soup.findAll("table", {"class": v})
            if kwtables:
                print(f"found table of {k} in {filepath.name}")
            new_entries = process_tables(kwtables, filepath.name, k)
            zdoc_entries += new_entries
    save_zdoc_entries(prjdir, zdoc_entries)


if __name__ == '__main__':
    main()

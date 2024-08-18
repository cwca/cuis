#!/usr/bin/env python3

# Split a smalltalk .sources file into a directory hierarchy, with one file
# per class.

import sys
import os
import errno
from collections import namedtuple


def parse(rootDirBase, data):
    dataStart = 0
    dataEnd = len(data)
    dataLeft = data[dataStart:dataEnd]

    searchString      = "!classDefinition: #"
    searchStringLen   = len(searchString)
    categoryString    = "category: #'"
    categoryStringLen = len(categoryString)

    entries = []

    moreToDo = True

    while moreToDo:
        classStart        = data.find(searchString, dataStart, dataEnd)
        classNameStart    = classStart + searchStringLen
        classNameEnd      = data.find(" ", classNameStart, dataEnd)
        categoryStart     = data.find(categoryString, classNameEnd, dataEnd)
        categoryNameStart = categoryStart + categoryStringLen
        categoryNameEnd   = data.find("'", categoryNameStart, dataEnd)

        if (classStart >= 0) and (categoryStart > 0):
            className    = data[classNameStart:classNameEnd]
            categoryName = data[categoryNameStart:categoryNameEnd].split('-')
            entry = {
                "class": className,
                "category": categoryName,
                "start": classStart,
                "end": 0
            }
            entries.append(entry)
            dataStart = categoryNameEnd
        else:
            moreToDo = False
        
    entriesLen = len(entries)
    i = 1
    while i < entriesLen:
        entries[i - 1]["end"] = (entries[i]["start"] - 1)
        i = i + 1
    entries[entriesLen - 1]["end"] = dataEnd - 1

    print("Number of entries: ", entriesLen)

    extension = (".st", ".ug")
    for ext in extension:

        rootDir = rootDirBase + ext

        os.makedirs(rootDir, exist_ok = True)

        i = 0

        while i < entriesLen:
            entry = entries[i]
            category = entry["category"]
            path = rootDir
            for p in category:
                path = path + "/" + p
                os.makedirs(path, exist_ok = True)            
            classStart = entry["start"]
            classEnd   = entry["end"] + 1
            classText  = data[classStart:classEnd]
            name = path + "/" + entry["class"] + ext
            with open(name, "w+", encoding="utf-8") as outFile:
                outFile.write(classText)
            i = i + 1
        
        entry = entries[0]
        entryStart = entry["start"]
        if entryStart > 0:
            path = rootDir
            name = path + "/" + "preamble.txt"
            text = data[0:entryStart]
            with open(name, "w+", encoding="utf-8") as outFile:
                outFile.write(text)


def main():
    if len(sys.argv) != 2:
        print("usage:  sourcesplit <name>.sources")
        sys.exit(1)
    
    filename       = sys.argv[1]
    filename_split = os.path.splitext(filename)
    filename_root  = filename_split[0]
    filename_ext   = filename_split[1]

    if filename_ext != ".sources":
        print("only files with extension .sources are valid:  ", filename_ext)
        sys.exit(1)
    
    print("parsing sources file: ", filename)

    try:
        file = open(filename, 'r', encoding="utf-8")
        data = file.read()
        file.close
        parse(filename_root, data)
    except FileNotFoundError as e:
        print("File not found, with error: ", e)
    except PermissionError:
        print("Permission denied when opening ", filename)
    except UnicodeDecodeError:
        print("Unable to decode data from ", filename)
    


if __name__ == "__main__":
    main()

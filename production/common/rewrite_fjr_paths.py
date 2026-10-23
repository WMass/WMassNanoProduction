#!/usr/bin/env python
from __future__ import print_function

import os
import sys
import xml.etree.ElementTree as ET


def main():
    if len(sys.argv) != 4:
        raise RuntimeError("usage: rewrite_fjr_paths.py REPORT OLD_PREFIX NEW_PREFIX")

    report, old_prefix, new_prefix = sys.argv[1:]
    temporary = report + ".rewrite"

    with open(report, "r") as handle:
        contents = handle.read()

    if old_prefix not in contents:
        raise RuntimeError("framework report does not contain expected prefix: " + old_prefix)

    with open(temporary, "w") as handle:
        handle.write(contents.replace(old_prefix, new_prefix))

    ET.parse(temporary)
    os.rename(temporary, report)


if __name__ == "__main__":
    main()

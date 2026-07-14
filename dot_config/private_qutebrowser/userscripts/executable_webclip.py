#!/usr/bin/env python3

import os
import time

from qutebrowser.browser.browsertab import SelectionState
from pathlib import Path


def send_string():

    # human readable timestamp in yyyymmdd-hhmmss format
    time_stamp = time.strftime("%Y-%m-%d-%H-%M-%S")

    url = os.getenv("QUTE_URL")
    html = os.getenv("QUTE_HTML")

    outdir = "/home/thadryan/Vaults/Knowledge/Resources/WebClips"

    outfile = Path(outdir) / (str(time_stamp) + "-qutebrowser-webclip.md")

    fifo_path = os.getenv("QUTE_FIFO")

    selected_text = os.getenv("QUTE_SELECTED_TEXT")

    # single_line = selected_text.replace(" ", "")

    string_command = f"message-info '{selected_text}'"

    with open(outfile, "a") as outfile:
        outfile.write(f"selected_text: {selected_text}\n")

def main():
    send_string()

if __name__ == "__main__":
    main()

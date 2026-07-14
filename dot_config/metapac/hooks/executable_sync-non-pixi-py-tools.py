#!/usr/bin/env python3
from __future__ import annotations

import argparse
import shutil
import subprocess
import sys
from pathlib import Path

try:
    import tomllib  # Python 3.11+
except Exception as exc:  # pragma: no cover
    raise SystemExit("python 3.11+ required (tomllib missing)") from exc


def run(cmd: list[str]) -> None:
    subprocess.run(cmd, check=True)


def main() -> int:
    parser = argparse.ArgumentParser(description="Sync non-pixi Python CLI tools from TOML manifest")
    parser.add_argument(
        "manifest",
        nargs="?",
        default=str(Path.home() / ".config/metapac/manifests/non-pixi-py-tools.toml"),
        help="Path to manifest TOML",
    )
    args = parser.parse_args()

    manifest_path = Path(args.manifest).expanduser()
    cfg = tomllib.loads(manifest_path.read_text())

    pipx_packages = cfg.get("pipx", {}).get("packages", [])
    uv_tools = cfg.get("uv", {}).get("tools", [])

    if shutil.which("pipx"):
        for pkg in pipx_packages:
            run(["pipx", "install", "--force", pkg])
    else:
        print("skip pipx: not installed", file=sys.stderr)

    if shutil.which("uv"):
        for tool in uv_tools:
            run(["uv", "tool", "install", tool])
    else:
        print("skip uv: not installed", file=sys.stderr)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())

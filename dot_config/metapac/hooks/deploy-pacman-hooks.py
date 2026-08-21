import os
import subprocess
import sys

def deploy_hooks():
    # Assume dotfiles are symlinked/copied to ~/.config/metapac/
    # We look for the hooks in that expanded path
    src_dir = os.path.expanduser("~/.config/metapac/pacman-hooks/")
    dst_dir = "/etc/pacman.d/hooks/"
    
    if not os.path.exists(src_dir):
        print(f"Source directory {src_dir} not found. Skipping hook deployment.")
        return

    # Ensure destination exists
    subprocess.run(["sudo", "mkdir", "-p", dst_dir], check=True)

    for filename in os.listdir(src_dir):
        if filename.endswith(".hook"):
            src_path = os.path.join(src_dir, filename)
            dst_path = os.path.join(dst_dir, filename)
            
            print(f"Deploying hook: {filename}")
            subprocess.run(["sudo", "cp", src_path, dst_path], check=True)

if __name__ == "__main__":
    try:
        deploy_hooks()
    except Exception as e:
        print(f"Error deploying hooks: {e}")
        sys.exit(1)

# experminent from an llm yolo
import tomllib
import subprocess
import sys

# Define the TOML file and the list key
TOML_FILE = '/var/home/thadryan/.dotfiles/.config/misc/flatpaks.toml'

LIST_KEY = 'flatpaks'

def get_installed_flatpaks():
    """Returns a set of currently installed Flatpak application IDs."""
    try:
        # Get a list of all installed applications, filtering for user-installed apps
        result = subprocess.run(
            ['flatpak', 'list', '--app', '--columns=application'],
            capture_output=True, text=True, check=True
        )
        # Split output into a list and remove empty lines
        return {line.strip() for line in result.stdout.splitlines() if line.strip()}
    except FileNotFoundError:
        print("Error: 'flatpak' command not found. Is Flatpak installed?")
        sys.exit(1)
    except subprocess.CalledProcessError as e:
        print(f"Error calling flatpak: {e}")
        sys.exit(1)

def get_desired_flatpaks():
    """Reads the TOML file and returns the set of desired Flatpak IDs."""
    try:
        with open(TOML_FILE, 'rb') as f:
            data = tomllib.load(f)
        return set(data.get(LIST_KEY, []))
    except FileNotFoundError:
        print(f"Error: {TOML_FILE} not found. Please create it with your flatpak list.")
        sys.exit(1)
    except Exception as e:
        print(f"Error reading {TOML_FILE}: {e}")
        sys.exit(1)

def main():
    """Main function to sync installed Flatpaks with the TOML file."""
    desired_flatpaks = get_desired_flatpaks()
    installed_flatpaks = get_installed_flatpaks()

    # Find flatpaks to install
    to_install = desired_flatpaks - installed_flatpaks
    # Find flatpaks to remove
    to_remove = installed_flatpaks - desired_flatpaks

    # Install new flatpaks
    if to_install:
        print("--- Installing new Flatpaks ---")
        for app_id in to_install:
            print(f"Installing {app_id}...")
            subprocess.run(['flatpak', 'install', '-y', 'flathub', app_id], check=True)
    else:
        print("No new Flatpaks to install.")

    # Remove deleted flatpaks
    if to_remove:
        print("\n--- Removing unlisted Flatpaks ---")
        for app_id in to_remove:
            print(f"Uninstalling {app_id}...")
            # --delete-data is added to remove all user data associated with the app
            subprocess.run(['flatpak', 'uninstall', '-y', '--delete-data', app_id], check=True)
    else:
        print("No Flatpaks to remove.")

    if not to_install and not to_remove:
        print("\nFlatpaks are already up to date.")

if __name__ == "__main__":
    main()

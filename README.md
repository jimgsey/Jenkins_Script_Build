## Usage

# Using terminal
Just run build.sh (bash build.sh) and enjoy.

# Using jenkins (or any other CI service)
You need to set the SCRIPTROM variable before you run the script as Jenkins does not have keyboard input as the terminal.

# Supported ROMs:
[1] LineageOS 16.0
[2] LineageOS 17.1
[3] PixelExperience
[4] AospExtended

# Usage of automatic OTA
This script is designed for my own OTA service, so you'll need to modify the patch_rom function and gen_ota_json function in order to use your own OTA jsons and repos.

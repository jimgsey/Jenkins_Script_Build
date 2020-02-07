# Copyright (C) 2020 daniml3 All rights reserved

# Declare all functions

# Telegram Messages
function telegrammsg() {
curl -s -X POST https://api.telegram.org/bot${BOT_TOKEN}/sendMessage -d chat_id=$CHAT_ID -d text="$MESSAGE"
}

# Generate mirror json

function gen_ota_json() {
     if [ $SCRIPTROM = "1" ]; then
        echo "LineageOS 16.0 OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "2" ]; then
        echo "Generating LineageOS 17.1 json"
            cd $ROMDIR
            DATETIME=$(grep "ro.build.date.utc=" out/target/product/lavender/system/build.prop | cut -d "=" -f 2)
            FILENAME=$(find out/target/product/lavender/lineage-1*.zip | cut -d "/" -f 5)
            ID=$(md5sum out/target/product/lavender/lineage-1*.zip | cut -d " " -f 1)
            SIZE=$(wc -c out/target/product/lavender/lineage-1*.zip | awk '{print $1}')
            URL1="https://sourceforge.net/projects/lavenderbuilds/files/lineage/${FILENAME}/download"
            VERSION="17.1"
            ROMTYPE="unofficial"
                JSON_FMT='{\n"response": [\n{\n"filename": "%s",\n"datetime": %s,\n"size":%s, \n"url":"%s", \n"version": "%s",\n"romtype": "%s", \n"id": "%s"\n}\n]\n}'
                printf "$JSON_FMT" "$FILENAME" "$DATETIME" "$SIZE" "$URL" "$VERSION" "$ROMTYPE" "$ID" >  ${HOME}/android/ota/lavender.json
        elif [ $SCRIPTROM = "3" ]; then
        echo "Generating PixelExperience json"
            cd $ROMDIR
            DATETIME=$(grep "org.pixelexperience.build_date_utc=" out/target/product/lavender/system/build.prop | cut -d "=" -f 2)
            FILENAME=$(find out/target/product/lavender/PixelExperience*.zip | cut -d "/" -f 5)
            ID=$(md5sum out/target/product/lavender/PixelExperience*.zip | cut -d " " -f 1)
            FILEHASH=$ID
            SIZE=$(wc -c out/target/product/lavender/PixelExperience*.zip | awk '{print $1}')
            URL1="https://sourceforge.net/projects/lavenderbuilds/files/pixel/${FILENAME}/download"
            VERSION="10"
            DONATE_URL="http:\/\/bit.ly\/jhenrique09_paypal"
            WEBSITE_URL="https:\/\/download.pixelexperience.org"
            NEWS_URL="https:\/\/t.me\/PixelExperience"
            MAINTAINER="daniml3"
            MAINTAINER_URL="https:\/\/t.me/daniiml3"
            FORUM_URL="N/A"
                JSON_FMT='{\n"error":false,\n"filename": %s,\n"datetime": %s,\n"size":%s, \n"url":"%s", \n"filehash":"%s", \n"version": "%s", \n"id": "%s",\n"donate_url": "%s",\n"website_url":"%s",\n"news_url":"%s",\n"maintainer":"%s",\n"maintainer_url":"%s",\n"forum_url":"%s"\n}'
                printf "$JSON_FMT" "$FILENAME" "$DATETIME" "$SIZE" "$URL" "$FILEHASH" "$VERSION" "$ID" "$DONATE_URL" "$WEBSITE_URL" "$NEWS_URL" "$MAINTAINER" "$MAINTAINER_URL" "$FORUM_URL" > ~/android/ota/lavender-pixel.json
        elif [ $SCRIPTROM = "4" ]; then
        echo "Generating AospExtended json"
            cd $ROMDIR
            DATETIME=$(grep "ro.extended.build_date_utc=" out/target/product/lavender/system/build.prop | cut -d "=" -f 2)
            FILENAME=$(find out/target/product/lavender/AospExtended*.zip | cut -d "/" -f 5)
            ID=$(md5sum out/target/product/lavender/AospExtended*.zip | cut -d " " -f 1)
            SIZE=$(wc -c out/target/product/lavender/AospExtended*.zip | awk '{print $1}')
            URL1="https://sourceforge.net/projects/lavenderbuilds/files/aex/$FILENAME"
            URL2="/download"
            URL=$URL1$URL2
            VERSION="v7.0"
            ROMTYPE="alpha"
                JSON_FMT='{\n"response": [\n{\n"filename": "%s",\n"datetime": %s,\n"size":%s, \n"url":"%s", \n"version": "%s",\n"romtype": "%s", \n"id": "%s"\n}\n]\n}'
                printf "$JSON_FMT" "$FILENAME" "$DATETIME" "$SIZE" "$URL" "$VERSION" "$ROMTYPE" "$ID" > ~/android/ota/lavender-aex.json
	fi
}

# ROM patcher
# This is for using custom OTA services

function patchrom () {
    if [ $SCRIPTROM = "1" ]; then
            echo "OTA for Lineage 16.0 nor supported by the script, skipping patch"
        elif [ $SCRIPTROM = "2" ]; then
            echo "Patching LineageOS 17.1"
            cd packages/apps/Updater
            git fetch https://github.com/daniml3/android_packages_apps_updater lineage-17.0-los
            git cherry-pick 68bc460d7804f98485236235ce79d74af4cc73bb
        elif [ $SCRIPTROM = "3" ]; then
            echo "Patching PixelExperience"
            cd packages/apps/Updates
            git fetch https://github.com/daniml3/android_packages_apps_updater ten
            git cherry-pick eeb8a48d02e6c738bd2f3d2fde61a4f3641eb137
            cd ../Settings
            git fetch https://github.com/daniml3/android_packages_apps_settings ten
            git cherry-pick c06a3398795f8a51d50258bce542139fecf4fa3b
            cd ../../../vendor/aosp
            git fetch https://github.com/daniml3/vendor_aosp ten
            git cherry-pick 75258641f401882bb03cf11d6f550c91ce9657ed
        elif [ $SCRIPTROM = "4" ]; then
            echo "Patching AospExtended"
            rm -rf Updates/
            rm -rf Updater/
            git clone https://github.com/daniml3/android_packages_apps_updater Updater -b lineage-17.0
            cd Settings
        	git fetch https://github.com/daniml3/android_packages_apps_settings 10.x
        	git cherry-pick c5bddf6d691145d1e9b642a8c133fdf48e322a20
            cd ../../../vendor/aosp
        	git fetch https://github.com/daniml3/vendor_aosp 10.x
        	git cherry-pick d111230
    fi

}

# Upload ROM

function upload_rom() {
    if [ $SCRIPTROM = "1" ]; then
        echo "Uploading"
        scp  out/target/product/lavender/lineage-*.zip daniml3@frs.sourceforge.net:/home/frs/project/lavenderbuilds/lineage/
        elif [ $SCRIPTROM = "2" ]; then
        echo "Uploading"
        scp  out/target/product/lavender/lineage-*.zip daniml3@frs.sourceforge.net:/home/frs/project/lavenderbuilds/lineage/
        elif [ $SCRIPTROM = "3" ]; then
        echo "Uploading"
        scp  out/target/product/lavender/PixelExperience*.zip daniml3@frs.sourceforge.net:/home/frs/project/lavenderbuild/pixel/
        ROMDIR="~/android/pixel"
        elif [ $SCRIPTROM = "4" ]; then
        echo "Uploading"
        scp  out/target/product/lavender/AospExtended*.zip daniml3@frs.sourceforge.net:/home/frs/project/lavenderbuilds/aex/
    fi
}

# Select ROM

function romselect() {
    # You can export the ROM by running export SCRIPTROM="<romnumber>". Example: export SCRIPTROM="1" (for LineageOS 16.0)
    if [[ -v SCRIPTROM ]]; then
    echo "Using exported ROM: $SCRIPTROM"
    else
        echo "Select the rom to build: "
        echo "[1] LineageOS 16.0"
        echo "[2] LineageOS 17.1"
        echo "[3] PixelExperience"
        echo "[4] AospExtended"
        read -p "Selection: " SCRIPTROM
    fi
        if [ $SCRIPTROM = "1" ]; then
        echo "Building LineageOS 16.0"
        ROMDIR="${HOME}/android/lineage16"
        elif [ $SCRIPTROM = "2" ]; then
        echo "Building LineageOS 17.1"
        ROMDIR="${HOME}/android/lineage17.1"
        elif [ $SCRIPTROM = "3" ]; then
        echo "Building PixelExperience"
        ROMDIR="${HOME}/android/pixel"
        elif [ $SCRIPTROM = "4" ]; then
        echo "Building AospExtended"
        ROMDIR="${HOME}/android/aex"
        else
        echo "You didn't entered a valid option."
        fi
}

function buildrom() {
    cd $ROMDIR
    repo sync --force-sync --no-clone-bundle --no-tags -j$(nproc --all) -qc
    if [ $? -eq 0 ]; then
        echo "Sync done"
        else
        echo "Sync failed"
        exit 1
    fi
    patchrom
    cd $ROMDIR
    rm -rf out/target/product/lavender/*.zip*
    if [ $SCRIPTROM = "4" ]; then
        cd $ROMDIR
	source build/envsetup.sh
        lunch aosp_lavender-userdebug
        mka bacon -j$(nproc --all)
    else
	cd $ROMDIR
        source build/envsetup.sh
        brunch lavender
    fi

}

# Main program

function main() {
    romselect
    buildrom
    upload_rom
    gen_ota_json
}

#Execute the program

main

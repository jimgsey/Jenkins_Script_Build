# Copyright (C) 2020 daniml3 and Jimgsey All rights reserved

# Declare all functions

## You could add your link to Jenkins, that way, you could see the process when a message is sent For example Sourceforge: https://jimgsei.github.io.
LINKJEN="Your jenkins link"

## Your link server generate. For example Sourceforge: https://sourceforge.net/projects/lavender7/files
LINKSOU="Your server link"

## Your link account to upload. For example: xXxx@frs.sourceforge.net:/home/frs/project/
LINKUPL="Your account link"

## Device Default structure
DEVICES="/xiaomi/lavender"

## Folder Script (where everything is compiled) 
SCRIPTFOLDER="${HOME}/Android"

## Tools (It is inside the android folder) and inside is the Roms and Tree folder
### Tools/Roms (A copy of the rom is made when the build is finished and then maintained. So you can delete the source folder to have more space.)
### Tools/Tree (Copy the vendor and kernel folder into the "Common" folder) (copy your device folder into another with the name of the rom)
### Example
#          __________________________________________________________________
#         |                                                                  |
#         |  /home/Android/Tools/Tree/                                       |
#         |                       l___ Aicp/device/xiaomi/lavender           |
#         |                       l___ Common/vendor/xiaomi/lavender         |
#         |                       l___ Common/kernel/xiaomi/lavender         |
#         |__________________________________________________________________|
#
TOOL="${SCRIPTFOLDER}/Tools"
TOOLTREE="${SCRIPTFOLDER}/Tools/Tree"
TOOLROM="${SCRIPTFOLDER}/Tools/Roms"

## Out folder where the rom is compiled. Example to lavender: "out/target/product/lavender" 
OUTF="out/target/product/lavender"

####################################################

## You can add your repo Q or Pie

AICPLINK="https://github.com/AICP/platform_manifest.git -b p9.0"
AEXPLINK="https://github.com/AospExtended/manifest.git -b 9.x"
AOKPLINK="https://github.com/AOKP/platform_manifest.git -b pie"
AOSIPLINK="https://github.com/AOSiP/platform_manifest.git -b pie"
CANDYLINK="https://github.com/CandyRoms/candy.git -b c9.0"
CARBONLINK="https://github.com/CarbonROM/android.git -b cr-7.0 "
COLTLINK="https://github.com/Colt-Enigma/platform_manifest.git -b wip"
COSMICLINK="https://github.com/Cosmic-OS/platform_manifest.git -b corona-release"
COSPLINK="https://github.com/cosp-project/manifest -b pie"
CRDROIDLINK="https://github.com/crdroidandroid/android.git -b 9.0"
DERPFESTLINK="https://github.com/DerpFest-Pie/platform_manifest.git -b pie"
DOTOSPLINK="https://github.com/DotOS/manifest.git -b dot-p"
FLOKOLINK="https://github.com/FlokoROM/manifesto.git -b 9.0"
HAVOCLINK="https://github.com/Havoc-OS/android_manifest.git -b pie"
IONLINK="https://github.com/i-o-n/manifest -b pie"
LINEAGELINK="https://github.com/LineageOS/android.git -b lineage-16.0"
LOTUSLINK="https://github.com/LotusOS/android_manifest.git -b pie"
NITROGENLINK="https://github.com/nitrogen-project/android_manifest.git -b p"
RRLINK="https://github.com/RR-Test/platform_manifest.git -b test_pie"
XENONLINK="https://github.com/TeamHorizon/platform_manifest.git -b p"
XTENDEDLINK="https://github.com/Project-Xtended/manifest.git -b xp"

####################################################

# Telegram Messages
function telegrammsg() {
TOKEN="Use your token"
ID="Your id bot"
curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=$ID -d text="$MESSAGE"
}

## Start script

function start() {
             if [ -d ${SCRIPTFOLDER}/ ]; then
                   echo ""
				   
             else
                   mkdir ${SCRIPTFOLDER}
                   mkdir ${TOOL}
             fi
}




#Clonado device tree
function copytrees() {
                if [ -d ${ROMDIR}/device/${DEVICES}/ ]; then
                   echo ""
				   echo "..................................!"
                   echo "Folder already exists"
## Default
             elif [ -d ${TOOLTREE}/${ROM}/ ]; then	
                    echo ""
				    echo "................................../"
                    echo "Copying tree"
                    cp -r ${TOOLTREE}/${ROM}/*         ${ROMDIR}
                    cp -r ${TOOLTREE}/Common/*         ${ROMDIR}
## Internet
			elif ping -c1 google.com &>/dev/null; then
                echo ""
                echo ""
                read -p "Please, write the device tree link:  " DT

                git clone $DT ${ROMDIR}/device/${DEVICES}
                echo ""
                echo ""
                read -p "Please, write the vendor tree link:  " VT

                git clone $VT ${ROMDIR}/vendor/${DEVICES}
                echo ""
                echo ""
                read -p "Please, write the device tree link:  " KT

                git clone $KT ${ROMDIR}/kernel/${DEVICES}
## Local
            else 
	 echo "      _________________________________________________________________________ "
     echo "     |                                                                         |"
     echo "     |                                                                         |"   
     echo "     |   - Prepare the dt, vt and kernel  a folder with the name you want.     |"                          
     echo "     |          Remember that the architecture is correct device and           |"   
     echo "     |             the files are extracted, not compressed in zip.             |"
     echo "     |                                                                         |" 
     echo "     |              For example to *Lavender*                                  |" 
     echo "     |                                                                         |"
     echo "     |                    My Folder/                                           |"
     echo "     |                       l___ device/xiaomi/lavender                       |"
     echo "     |                       l___ vendor/xiaomi/lavender                       |"
     echo "     |                       l___ kernel/xiaomi/lavender                       |"
     echo "     |                                                                         |"
     echo "     |                                                                         |"
     echo "     |        * Write the full path where your folder is located.              |"
     echo "     |                                                                         |" 
     echo "     |             For example: /home/YourUserPc/My Folder                     |" 
     echo "     |_________________________________________________________________________|"
		        echo ""
                echo ""    
		        read -p "Please, write the *route* where you have saved your tree:  " RUTA
                    cp -r ${RUTA}/*         ${ROMDIR}
                    echo ""
				    echo "................................../"
                    echo "Copying your choise tree"				
                
				fi
}


## Rom Folder
function romfolder() {
     if [ -d ${ROMDIR} ]; then
                   echo ""
				   echo "..................................!"
                   echo "Folder already exists"

            else
                   echo ""
				   echo "..................................|"
                   echo "Create folder"
                   mkdir ${ROMDIR} 
            fi
	
	        if [ -d ${ROMDIR}/.repo/ ]; then
                   echo ""
				   echo "..................................!"
                   echo "Repo already exists"

            else
                   echo ""
				   echo "..................................|"
				   echo "Add link repo"
                   cd $ROMDIR
                   echo ""
                   echo ""
                   repo init -u $REPOLINK
            fi
}


# Make clean

function romclean() {
    # You can export the ROM by running export SCRIPTROM="<text>". Example: export SCRIPTROM="lineage" (for LineageOS 16.0)
    if [[ -v ROMCLEAN ]]; then
    echo ""
    else
        echo ""
		echo ""
		echo "##################"
        echo "#  Final option  #"
		echo "##################"
		echo ""
        echo "[make]   Make Clean"
        echo "[delete] Delete"
        echo "[no]     Nothing"
		echo ""
		echo ""
        read -p "Please, enter your choise: " ROMCLEAN
    fi
	
    if [ $ROMCLEAN = "make" ]; then
        echo ""
		echo "................................../"
		echo "Make clean $ROM "
        cd $ROMDIR
        make clean
##############################################Push telegram message############################################################
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Make Clean $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
				
    elif [ $ROMCLEAN = "delete" ]; then
	    echo ""
		echo "............................/"
        echo "Deleting all folder to $ROM "
        rm -rf $ROMDIR
##############################################Push telegram message############################################################

	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Delete folder $ROM.  Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
    elif [ $ROMCLEAN = "no" ]; then
	    echo ""
		echo "..................................O"
        echo "Nothing"
    else
	    echo ""
		echo "..................................-"
        echo "You didn't entered a valid option."
		exit 1

    fi
}


# Generate mirror json

function gen_ota_json() {
     
    if [ $SCRIPTROM = "aicp" ]; then
	    echo ""
		echo "................................../"
        echo "Generating $ROM 14.0 json"
            cd $ROMDIR
            DATETIME=$(grep "ro.build.date.utc=" ${OUTF}/system/build.prop | cut -d "=" -f 2)
            FILENAME=$(find ${OUTF}/aicp_lavender_p*.zip | cut -d "/" -f 5)
            ID=$(md5sum ${OUTF}/aicp_lavender_p*.zip | cut -d " " -f 1)
            SIZE=$(wc -c ${OUTF}/aicp_lavender_p*.zip | awk '{print $1}')
            URL1="${LINKSOU}/${ROM}/$FILENAME"
            URL=$URL1
            VERSION="14.0"
            ROMTYPE="unofficial"
                   JSON_FMT='{\n"response": [\n{\n"filename": "%s",\n"datetime": %s,\n"size":%s, \n"url":"%s", \n"version": "%s",\n"romtype": "%s", \n"id": "%s"\n}\n]\n}'
                   printf "$JSON_FMT" "$FILENAME" "$DATETIME" "$SIZE" "$URL" "$VERSION" "$ROMTYPE" "$ID" > ~/script/ota/lavender-aicp.json
        elif [ $SCRIPTROM = "aex" ]; then
        echo ""
		echo "................................../"
        echo "$ROM OTA is not supported by the script, skipping generation"
		elif [ $SCRIPTROM = "aokp" ]; then
        echo ""
		echo "................................../"
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "aosip" ]; then
        echo ""
		echo "................................../"
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "candy" ]; then
        echo ""
		echo "................................../"
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "carbon" ]; then
        echo ""
		echo "................................../"
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "colt" ]; then
        echo ""
		echo "................................../"
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "cosmic" ]; then
        echo ""
		echo "................................../"
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "cosp" ]; then
        echo ""
		echo "................................../"
        echo "$ROM OTA is not supported by the script, skipping generation"
		elif [ $SCRIPTROM = "crdroid" ]; then
        echo ""
		echo "................................../"
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "derpfest" ]; then
        echo ""
		echo "................................../"
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "dot" ]; then
        echo ""
		echo "................................../"
        echo "$ROM OTA is not supported by the script, skipping generation"
		elif [ $SCRIPTROM = "floko" ]; then
        echo ""
		echo "................................../"
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "havoc" ]; then
        echo ""
		echo "................................../"
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "ion" ]; then
        echo ""
		echo "................................../"
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "lineage" ]; then
        echo ""
		echo "................................../"
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "lotus" ]; then
        echo ""
		echo "................................../"
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "nitrogen" ]; then
        echo ""
		echo "................................../"
        echo "$ROM OTA is not supported by the script, skipping generation"
		elif [ $SCRIPTROM = "rr" ]; then
        echo ""
		echo "................................../"
        echo "$ROM OTA is not supported by the script, skipping generation"
		elif [ $SCRIPTROM = "xenon" ]; then
        echo ""
		echo "................................../"
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "xtended" ]; then
        echo ""
		echo "................................../"
        echo "$ROM OTA is not supported by the script, skipping generation"		
        fi
}

function push_ota () {
	cd  ${HOME}/script/ota/ 
	git add . 
	git commit -m "Update" 
	git push -u origin master
}
# ROM patcher
# This is for using custom OTA services

function patchrom () {
    if [ $SCRIPTROM = "aicp" ]; then
	        echo ""
		    echo "................................../"
            echo "Updating updater to $ROM"
            cp ~/script/aicp/updater/strings.xml ${ROMDIR}/packages/apps/Updater/res/values
        elif [ $SCRIPTROM = "aex" ]; then
            echo ""
		    echo "................................../"
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "aokp" ]; then
            echo ""
		    echo "................................../"
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "aosip" ]; then
            echo ""
		    echo "................................../"
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "candy" ]; then
            echo ""
		    echo "................................../"
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "carbon" ]; then
            echo ""
		    echo "................................../"
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "colt" ]; then
            echo ""
		    echo "................................../"
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "cosmic" ]; then
            echo ""
		    echo "................................../"
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "cosp" ]; then
            echo ""
		    echo "................................../"
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "crdroid" ]; then
            echo ""
		    echo "................................../"
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "derpfest" ]; then
            echo ""
		    echo "................................../"
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "dot" ]; then
            echo ""
		    echo "................................../"
            echo "OTA for $ROM not supported by the script, skipping patch"	
        elif [ $SCRIPTROM = "floko" ]; then
            echo ""
		    echo "................................../"
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "havoc" ]; then
            echo ""
		    echo "................................../"
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "ion" ]; then
            echo ""
		    echo "................................../"
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "lineage" ]; then
            echo ""
		    echo "................................../"
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "lotus" ]; then
            echo ""
		    echo "................................../"
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "nitrogen" ]; then
            echo ""
		    echo "................................../"
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "rr" ]; then
            echo ""
		    echo "................................../"
            echo "OTA for $ROM not supported by the script, skipping patch"
		elif [ $SCRIPTROM = "xenon" ]; then
            echo ""
		    echo "................................../"
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "xtended" ]; then
            echo ""
		    echo "................................../"
            echo "OTA for $ROM not supported by the script, skipping patch"
			
    fi

}

# Upload ROM

function uploadrom() {

        if [[ -v UPLOADROM ]]; then
    echo ""
    else
	    echo ""
		echo ""
		echo "#################################"
        echo "#  Do you want upload the rom?  #"
		echo "#################################"
		echo ""
        echo "[yes] Upload"
        echo "[no] Skip"
        echo ""
		echo ""
		read -p "Please, write your choise: " UPLOADROM
    fi

    if [ $UPLOADROM = "yes" ]; then
        if [ $SCRIPTROM = "aicp" ]; then
              echo ""
			  echo "................................../"
              echo "Uploading $ROM "			
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/aicp_lavender_p*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################				  
              scp  ${TOOLROM}/aicp_lavender_p*.zip ${LINKUPL}/${ROM}/
			  echo ""
			  echo "..................................|"
              echo "Uploaded $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/aicp_lavender_p*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	

##################### Upload OTA ############## 
                    push_ota_json
##################### Upload OTA ##############


        elif [ $SCRIPTROM = "aex" ]; then
              echo ""
			  echo "................................../"
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/AospExtended-v6*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ${TOOLROM}/AospExtended-v6*.zip ${LINKUPL}/${ROM}/
			  echo ""
			  echo "..................................|"
              echo "Uploaded $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/AospExtended-v6*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
			  
        elif [ $SCRIPTROM = "aokp" ]; then
              echo ""
			  echo "................................../"
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/aokp_lavender_pie*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ${TOOLROM}/aokp_lavender_pie*.zip ${LINKUPL}/${ROM}/
			  echo ""
			  echo "..................................|"
              echo "Uploaded $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/aokp_lavender_pie*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################
			  
        elif [ $SCRIPTROM = "aosip" ]; then
              echo ""
			  echo "................................../"
              echo "Uploading $ROM "			
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/AOSiP-9.0-Pizza*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################				  
              scp  ${TOOLROM}/AOSiP-9.0-Pizza*.zip  ${LINKUPL}/${ROM}/
			  echo ""
			  echo "..................................|"
              echo "Uploaded $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/AOSiP-9.0-Pizza*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################				  

         elif [ $SCRIPTROM = "candy" ]; then
              echo ""
			  echo "................................../"
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/Candy*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/${FILENAME}"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ${TOOLROM}/Candy*.zip ${LINKUPL}/${ROM}/
			  echo ""
			  echo "..................................|"
              echo "Uploaded $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/Candy*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/${FILENAME}"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
			  

        elif [ $SCRIPTROM = "carbon" ]; then
              echo ""
			  echo "................................../"
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/CARBON*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ${TOOLROM}/CARBON*.zip ${LINKUPL}/${ROM}/ 
			  echo ""
			  echo "..................................|"
              echo "Uploaded $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/CARBON*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################
        elif [ $SCRIPTROM = "colt" ]; then
              echo ""
			  echo "................................../"
              echo "Uploading $ROM "			
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/ColtOS*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################				  
              scp  ${TOOLROM}/ColtOS*.zip  ${LINKUPL}/${ROM}/
			  echo ""
			  echo "..................................|"
              echo "Uploaded $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/ColtOS*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################				  

        elif [ $SCRIPTROM = "cosmic" ]; then
              echo ""
			  echo "................................../"
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/Cosmic-OS-v4.0-Corona*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ${TOOLROM}/cosmic*.zip ${LINKUPL}/${ROM}/
			  echo ""
			  echo "..................................|"
              echo "Uploaded $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/Cosmic-OS-v4.0-Corona*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################
			  
        elif [ $SCRIPTROM = "cosp" ]; then
              echo ""
			  echo "................................../"
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/COSP*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ${TOOLROM}/COSP*.zip ${LINKUPL}/${ROM}/
			  echo ""
			  echo "..................................|"
              echo "Uploaded $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/COSP*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################

        elif [ $SCRIPTROM = "crdroid" ]; then
              echo ""
			  echo "................................../"
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/crDroidAndroid-9*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ${TOOLROM}/crDroidAndroid-9*.zip ${LINKUPL}/${ROM}/
			  echo ""
			  echo "..................................|"
              echo "Uploaded $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/crDroidAndroid-9*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################
			  
        elif [ $SCRIPTROM = "derpfest" ]; then
              echo ""
			  echo "................................../"
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/AOSiP-9.0-DerpFest*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ${TOOLROM}/AOSiP-9.0-DerpFest*.zip  ${LINKUPL}/${ROM}/
			  echo ""
			  echo "..................................|"
              echo "Uploaded $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/AOSiP-9.0-DerpFest*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################
		
	    elif [ $SCRIPTROM = "dot" ]; then
              echo ""
			  echo "................................../"
              echo "Uploading $ROM "			
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/dotOS-P*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################				  
              scp  ${TOOLROM}/dotOS-P*.zip  ${LINKUPL}/${ROM}/
			  echo ""
			  echo "..................................|"
              echo "Uploaded $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/dotOS-P*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################				  


        elif [ $SCRIPTROM = "floko" ]; then
              echo ""
			  echo "................................../"
              echo "Uploading $ROM "			
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/Floko*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################				  
              scp  ${TOOLROM}/Floko*.zip  ${LINKUPL}/${ROM}/
			  echo ""
			  echo "..................................|"
              echo "Uploaded $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/Floko*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
		
        elif [ $SCRIPTROM = "havoc" ]; then
              echo ""
			  echo "................................../"
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/Havoc*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ${TOOLROM}/Havoc*.zip ${LINKUPL}/${ROM}/ 
			  echo ""
			  echo "..................................|"
              echo "Uploaded $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/Havoc*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################
			  
	  
        elif [ $SCRIPTROM = "ion" ]; then
              echo ""
			  echo "................................../"
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/ion*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ${TOOLROM}/ion*.zip ${LINKUPL}/${ROM}/ 
			  echo ""
			  echo "..................................|"
              echo "Uploaded $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/ion*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################
			  

        elif [ $SCRIPTROM = "lineage" ]; then
              echo ""
			  echo "................................../"
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/lineage-16*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ${TOOLROM}/lineage-16*.zip ${LINKUPL}/${ROM}/
			  echo ""
			  echo "..................................|"
              echo "Uploaded $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/lineage-16*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	

		elif [ $SCRIPTROM = "lotus" ]; then
              echo ""
			  echo "................................../"
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/Lo*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ${TOOLROM}/Lo*.zip ${LINKUPL}/${ROM}/
			  echo ""
			  echo "..................................|"
              echo "Uploaded $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/Lo*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################
			  
        elif [ $SCRIPTROM = "nitrogen" ]; then
              echo ""
			  echo "................................../"
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/Nitrogen*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp ${TOOLROM}/Nitrogen*.zip  ${LINKUPL}/${ROM}/
			  echo ""
			  echo "..................................|"
              echo "Uploaded $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/Nitrogen*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	  
        elif [ $SCRIPTROM = "rr" ]; then
              echo ""
			  echo "................................../"
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/RR-P-v7*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/ResurrectionRemix/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ${TOOLROM}/RR-P-v7*.zip  ${LINKUPL}/ResurrectionRemix/
			  echo ""
			  echo "..................................|"
              echo "Uploaded $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/RR-P-v7*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/ResurrectionRemix/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
			  
        elif [ $SCRIPTROM = "xenon" ]; then
              echo ""
			  echo "................................../"
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/XenonHD*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ${TOOLROM}/XenonHD*.zip ${LINKUPL}/${ROM}/
              echo ""
			  echo "..................................|"
              echo "Uploaded $ROM "			  
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/XenonHD*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################				  
    
      elif [ $SCRIPTROM = "xtended" ]; then
              echo ""
			  echo "................................../"
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/Xtended*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ${TOOLROM}/Xtended*.zip ${LINKUPL}/${ROM}/
			  echo ""
			  echo "..................................|"
              echo "Uploaded $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ${TOOLROM}/Xtended*.zip | cut -d "/" -f 5)
	UPDATE_URL1="${LINKSOU}/${ROM}/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
		fi	  

      elif [ $UPLOADROM = "no" ]; then
	        echo ""
			echo "..................................O"
            echo "Skip Upload $ROM "       		
     else
		    echo ""
			echo ".................................-"
            echo "You didn't entered a valid option."
		exit 1

			

fi	
}

# Select ROM

function romselect() {
    # You can export the ROM by running export SCRIPTROM="<romnumber>". Example: export SCRIPTROM="1" (for LineageOS 16.0)
    if [[ -v SCRIPTROM ]]; then
    echo ""
    else
        	
		echo ""
        echo ""
		echo "#############################"	
		echo "#   What rom do you want?   #"
		echo "#############################"
		echo ""
        echo "[aicp] Aicp"
        echo "[aex] Aex"
        echo "[aokp] AOKP"
		echo "[aosip] Aosip"
        echo "[candy] Candy"
        echo "[carbon] Carbon"
        echo "[colt] Colt"
        echo "[cosmic] Cosmic"
        echo "[cosp] COSP"
        echo "[crdroid] CrDroid"
        echo "[derpfest] Derpfest"
        echo "[dot] Dot"
		echo "[floko] Floko"
        echo "[havoc] Havoc"
        echo "[ion] Ion"
        echo "[lineage] Lineage"
        echo "[lotus] Lotus"
        echo "[nitrogen] Nitrogen"
        echo "[rr] Resurrection Remix"
		echo "[xenon] Xenon HD"
        echo "[xtended] Xtended"     
        echo ""
        echo ""
        read -p "Please, enter your choice: " SCRIPTROM
    fi
	
    if [ $SCRIPTROM = "aicp" ]; then
        ROM="Aicp"
        ROMDIR="${SCRIPTFOLDER}/${ROM}"
        REPOLINK=$AICPLINK
		echo ""
		echo ".................................."
		echo "You will build $ROM"
        romfolder
       
		
		
    elif [ $SCRIPTROM = "aex" ]; then
        ROM="Aex"
        ROMDIR="${SCRIPTFOLDER}/${ROM}"
		REPOLINK=$AEXLINK
		echo ""
		echo ".................................."
		echo "You will build $ROM"
        romfolder
	
               
	elif [ $SCRIPTROM = "aokp" ]; then
		ROM="Aokp"
        ROMDIR="${SCRIPTFOLDER}/${ROM}"
		REPOLINK=$AOKPLINK
		echo ""
		echo ".................................."
		echo "You will build $ROM"
        romfolder

	elif [ $SCRIPTROM = "aosip" ]; then
		ROM="Aosip"
        ROMDIR="${SCRIPTFOLDER}/${ROM}"
		REPOLINK=$AOSIPLINK
		echo ""
		echo ".................................."
		echo "You will build $ROM"
        romfolder
		
	elif [ $SCRIPTROM = "candy" ]; then
        ROM="Candy"
        ROMDIR="${SCRIPTFOLDER}/${ROM}"
		REPOLINK=$CANDYLINK
		echo ""
		echo ".................................."
		echo "You will build $ROM"
        romfolder

    elif [ $SCRIPTROM = "carbon" ]; then
        ROM="Carbon"
        ROMDIR="${SCRIPTFOLDER}/${ROM}"
        REPOLINK=$CARBONLINK
		echo ""
		echo ".................................."
		echo "You will build $ROM"
        romfolder
	
    elif [ $SCRIPTROM = "colt" ]; then
		ROM="Colt"
        ROMDIR="${SCRIPTFOLDER}/${ROM}"
		REPOLINK=$COLTLINK
		echo ""
		echo ".................................."
		echo "You will build $ROM"
        romfolder
    
    elif [ $SCRIPTROM = "cosmic" ]; then
		ROM="Cosmic"
        ROMDIR="${SCRIPTFOLDER}/${ROM}"
        REPOLINK=$COSMICLINK
		echo ""
		echo ".................................."
		echo "You will build $ROM"
        romfolder

    elif [ $SCRIPTROM = "cosp" ]; then
		ROM="Cosp"
        ROMDIR="${SCRIPTFOLDER}/${ROM}"
		REPOLINK=$CSPTLINK
		echo ""
		echo ".................................."
		echo "You will build $ROM"
        romfolder
   
	elif [ $SCRIPTROM = "crdroid" ]; then
		ROM="CrDroid"
        ROMDIR="${SCRIPTFOLDER}/${ROM}"
		REPOLINK=$CRDROIDLINK
		echo ""
		echo ".................................."
		echo "You will build $ROM"
        romfolder
			
    elif [ $SCRIPTROM = "derpfest" ]; then
		ROM="Derpfest"
        ROMDIR="${SCRIPTFOLDER}/${ROM}"
		REPOLINK=$DERPFESTLINK
		echo ""
		echo ".................................."
		echo "You will build $ROM"
        romfolder

    elif [ $SCRIPTROM = "dot" ]; then
		ROM="Dot"
        ROMDIR="${SCRIPTFOLDER}/${ROM}"
		REPOLINK=$DOTLINK
		echo ""
		echo ".................................."
		echo "You will build $ROM"
        romfolder
		
		
    elif [ $SCRIPTROM = "floko" ]; then
		ROM="Floko"
        ROMDIR="${SCRIPTFOLDER}/${ROM}"
		REPOLINK=$FLOKOLINK
		echo ""
		echo ".................................."
		echo "You will build $ROM"
        romfolder
	
	elif [ $SCRIPTROM = "havoc" ]; then
		ROM="Havoc"
        ROMDIR="${SCRIPTFOLDER}/${ROM}"
		REPOLINK=$HAVOCLINK
		echo ""
		echo ".................................."
		echo "You will build $ROM"
        romfolder


    elif [ $SCRIPTROM = "ion" ]; then
		ROM="Ion"
        ROMDIR="${SCRIPTFOLDER}/${ROM}"
		REPOLINK=$IONINK
		echo ""
		echo ".................................."
		echo "You will build $ROM"
        romfolder
		
    elif [ $SCRIPTROM = "lineage" ]; then
		ROM="Lineage"
        ROMDIR="${SCRIPTFOLDER}/${ROM}"
		REPOLINK=$LINEAGELINK
		echo ""
		echo ".................................."
		echo "You will build $ROM"
        romfolder
	
    elif [ $SCRIPTROM = "lotus" ]; then
		ROM="Lotus"
        ROMDIR="${SCRIPTFOLDER}/${ROM}"
		REPOLINK=$LOTUSLINK
		echo ""
		echo ".................................."
		echo "You will build $ROM" 
        romfolder

    elif [ $SCRIPTROM = "nitrogen" ]; then
		ROM="Nitrogen"
        ROMDIR="${SCRIPTFOLDER}/${ROM}"
		REPOLINK=$NITROGENLINK
		echo ""
		echo ".................................."
		echo "You will build $ROM"
        romfolder
       
	elif [ $SCRIPTROM = "rr" ]; then
		ROM="RR"
        ROMDIR="${SCRIPTFOLDER}/${ROM}"
		REPOLINK=$RRLINK
		echo ""
		echo ".................................."
		echo "You will build $ROM"
        romfolder

	elif [ $SCRIPTROM = "xenon" ]; then
		ROM="Xenon"
        ROMDIR="${SCRIPTFOLDER}/${ROM}"
		REPOLINK=$XENONLINK
		echo ""
		echo ".................................."
		echo "You will build $ROM"
        romfolder

    elif [ $SCRIPTROM = "xtended" ]; then
        ROM="Xtended"
        ROMDIR="${SCRIPTFOLDER}/${ROM}"
		REPOLINK=$XTENDEDLINK
		echo ""
		echo ".................................."
		echo "You will build $ROM"
        romfolder

	else
	    echo ""
		echo "..................................O"
        echo "You didn't entered a valid option."
		exit 1

    fi
}

# Repo sync

function syncrom() {
     
	if [[ -v SCRIPTSYNC ]]; then
    echo ""
    else
	    echo ""
		echo ""
		echo "#################"
        echo "# Sync or skip: #"
		echo "#################"
		echo ""
        echo "[yes] Sync Repository"
        echo "[no] Skip Sync"
        echo ""
		echo ""
		read -p "Please, write your choise: " SCRIPTSYNC
    fi
    if [ $SCRIPTSYNC = "yes" ]; then
	    echo ""
		echo ".................................."
        echo "Synchronizing repository $ROM"
		
###########################################################################################################################
DATE=$(date '+%d/%m/%Y')
HOURS=$(date '+%H:%M min')
MESSAGE="Start sync $ROM at $HOURS to $DATE with link Jenkins: $LINKJEN "
        telegrammsg
###########################################################################################################################
		cd $ROMDIR	
	    if ping -c1 google.com &>/dev/null; then
       repo sync --force-sync --no-clone-bundle --no-tags -j4 
		     echo ""
			 echo ".............................|"
             echo "Sync done $ROM"
###########################################################################################################################
DATE=$(date '+%d/%m/%Y')
HOURS=$(date '+%H:%M min')
MESSAGE="Finish sync $ROM at $HOURS to $DATE with link Jenkins: $LINKJEN "
        telegrammsg
###########################################################################################################################
        else
		     echo ""
		     echo "..................................-"
             echo "Sync failed $ROM"
###########################################################################################################################
DATE=$(date '+%d/%m/%Y')
HOURS=$(date '+%H:%M min')
MESSAGE="Failed sync $ROM at $HOURS to $DATE with link Jenkins: $LINKJEN "
        telegrammsg
###########################################################################################################################
           exit 1
         fi
    elif [ $SCRIPTSYNC = "no" ]; then
	    echo ""
		echo "..................................O"
        echo "Skipping sync $ROM "
    else
		echo ""
		echo ".................................."
        echo "You didn't entered a valid option."
		exit 1

    fi
}



# Build Rom

function buildrom() {

    if [[ -v BUILDROM ]]; then
    echo ""
    else
        echo ""
		echo ""
		echo "#######################"
        echo "#   Build or Skip :   #"
        echo "#######################"
		echo ""
        echo "[yes] Build"
        echo "[no] No"
        echo ""
		echo ""
        read -p "Please, write your choise: " BUILDROM
    fi

    if [ $BUILDROM = "yes" ]; then
	    echo ""
		echo "................................../"
        echo "Cloning necessary files"
        cd $ROMDIR
		git clone -b lineage-16.0 https://github.com/LineageOS/android_packages_resources_devicesettings packages/resources/devicesettings
################
################
################		   
         if [ $SCRIPTROM = "aicp" ]; then
            echo ""
	        echo "................................../"
		    echo "it will begin to build $ROM "
            copytrees
			patchrom
			
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Start build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
			
		    source build/envsetup.sh
            brunch lavender
                if [ $? -eq 0 ]; then
                     echo ""
	                 echo "..................................|"
                     echo "Finished build $ROM"  
		             cp  ${OUTF}/aicp_lavender_p*.zip ${TOOLROM}
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################						 
##################### Generar OTA ##############       Pegar antes del elif de no?????
                    gen_ota_json
##################### Generar OTA ##############
	
                else
                      echo ""
	                  echo "..................................-"
                      echo "Error compiling $ROM "
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	             exit 1
                fi
		 

		
        elif [ $SCRIPTROM = "aex" ]; then		
            echo ""
	        echo "................................../"
		    echo "it will begin to build $ROM "
            copytrees
			patchrom
			
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Start build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
		    source build/envsetup.sh
            lunch aosp_lavender-userdebug
            mka aex -j4
                if [ $? -eq 0 ]; then
                     echo ""
	                 echo "..................................|"
                     echo "Finished build $ROM"  
		              cp  ${OUTF}/AospExtended-v6*.zip ${TOOLROM}
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
                else
				      echo ""
	                  echo "..................................-"
                      echo "Error compiling $ROM "
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	              exit 1
                fi
          
				
		
        elif [ $SCRIPTROM = "aokp" ]; then		
            echo ""
	        echo "................................../"
		    echo "it will begin to build $ROM "
            copytrees
			patchrom
		
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Start build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
		    source build/envsetup.sh
            lunch aokp_lavender-userdebug
            mka rainbowfarts
              if [ $? -eq 0 ]; then
                     echo ""
	                 echo "..................................|"
                     echo "Finished build $ROM"  
		          cp  ${OUTF}/aokp_lavender_pie*.zip ${TOOLROM}
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
              else
                      echo ""
	                  echo "..................................-"
                      echo "Error compiling $ROM "
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	            exit 1
              fi
			
        
        elif [ $SCRIPTROM = "aosip" ]; then
            echo ""
	        echo "................................../"
		    echo "it will begin to build $ROM "
            copytrees
			patchrom
			
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Start build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
			
		    source build/envsetup.sh
            lunch aosip_lavender-userdebug
            mka kronic
                if [ $? -eq 0 ]; then
                     echo ""
	                 echo "..................................|"
                     echo "Finished build $ROM"  
		             cp  ${OUTF}/AOSiP-9.0-Pizza*.zip  ${TOOLROM}
					 
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
                else
                      echo ""
	                  echo "..................................-"
                      echo "Error compiling $ROM "
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	               exit 1
                fi

		 
        elif [ $SCRIPTROM = "candy" ]; then		
            echo ""
	        echo "................................../"
		    echo "it will begin to build $ROM "
            copytrees
			patchrom
			
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Start build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
		    source build/envsetup.sh
            brunch lavender
                if [ $? -eq 0 ]; then
                     echo ""
	                 echo "..................................|"
                     echo "Finished build $ROM"  
		              cp  ${OUTF}/Candy*.zip ${TOOLROM}
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
                else
                      echo ""
	                  echo "..................................-"
                      echo "Error compiling $ROM "                        
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	               exit 1
                fi
          
				
		
        elif [ $SCRIPTROM = "carbon" ]; then		
            echo ""
	        echo "................................../"
		    echo "it will begin to build $ROM "
            copytrees
			patchrom
			
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Start build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
		    source build/envsetup.sh
            lunch carbon_lavender-user
            make carbon -j4
                if [ $? -eq 0 ]; then
                     echo ""
	                 echo "..................................|"
                     echo "Finished build $ROM"  
		              cp  ${OUTF}/CARBON*.zip ${TOOLROM}
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
                else
                      echo ""
	                  echo "..................................-"
                      echo "Error compiling $ROM "
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	               exit 1
                fi
          
       				
		 elif [ $SCRIPTROM = "colt" ]; then
            echo ""
	        echo "................................../"
		    echo "it will begin to build $ROM "
            copytrees
			patchrom
			
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Start build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
			
		    source build/envsetup.sh
            lunch colt_lavender-userdebug
            make colt
                if [ $? -eq 0 ]; then
                     echo ""
	                 echo "..................................|"
                     echo "Finished build $ROM"  
		             cp  ${OUTF}/ColtOS*.zip  ${TOOLROM}
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################						 	
                else
                     echo ""
	                  echo "..................................-"
                      echo "Error compiling $ROM "
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	               exit 1
                fi

        elif [ $SCRIPTROM = "cosmic" ]; then		
            echo ""
	        echo "................................../"
		    echo "it will begin to build $ROM "
            copytrees
			patchrom
		
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Start build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
		    source build/envsetup.sh
            lunch cos_lavender-userdebug
            brunch lavender
              if [ $? -eq 0 ]; then
                     echo ""
	                 echo "..................................|"
                     echo "Finished build $ROM"  
		          cp  ${OUTF}/Cosmic-OS-v4.0-Corona*.zip ${TOOLROM}
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
              else
                      echo ""
	                  echo "..................................-"
                      echo "Error compiling $ROM "
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	             exit 1
              fi
			
        
        elif [ $SCRIPTROM = "cosp" ]; then		
            echo ""
	        echo "................................../"
		    echo "it will begin to build $ROM "
            copytrees
			patchrom
		
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Start build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
		    source build/envsetup.sh
            lunch cosp_lavender-userdebug
            mka bacon
              if [ $? -eq 0 ]; then
                     echo ""
	                 echo "..................................|"
                     echo "Finished build $ROM"  
		          cp  ${OUTF}/COSP*.zip ${TOOLROM}
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
              else
                      echo ""
	                  echo "..................................-"
                      echo "Error compiling $ROM "
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	             exit 1
              fi


        elif [ $SCRIPTROM = "crdroid" ]; then		
            echo ""
	        echo "................................../"
		    echo "it will begin to build $ROM "
            copytrees
			patchrom
		
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Start build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
		    source build/envsetup.sh
            brunch lavender
              if [ $? -eq 0 ]; then
                     echo ""
	                 echo "..................................|"
                     echo "Finished build $ROM"  
		          cp  ${OUTF}/crDroidAndroid-9*.zip ${TOOLROM}
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
              else
                      echo ""
	                  echo "..................................-"
                      echo "Error compiling $ROM "
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	             exit 1
              fi
			  

        elif [ $SCRIPTROM = "derpfest" ]; then
            echo ""
	        echo "................................../"
		    echo "it will begin to build $ROM "
            copytrees
			patchrom
		
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Start build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
		    source build/envsetup.sh
            lunch aosip_lavender-userdebug
            mka kronic
              if [ $? -eq 0 ]; then
                     echo ""
	                 echo "..................................|"
                     echo "Finished build $ROM"  
		          cp  ${OUTF}/AOSiP-9.0-DerpFest*.zip  ${TOOLROM}
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
              else
                      echo ""
	                  echo "..................................-"
                      echo "Error compiling $ROM "
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	       exit 1
        fi


        elif [ $SCRIPTROM = "dot" ]; then
            echo ""
	        echo "................................../"
		    echo "it will begin to build $ROM "
            copytrees
			patchrom
			
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Start build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
			
		    source build/envsetup.sh
            lunch dot_lavender-userdebug
            make bacon
                if [ $? -eq 0 ]; then
                     echo ""
	                 echo "..................................|"
                     echo "Finished build $ROM"  
		             cp  ${OUTF}/dotOS-P*.zip  ${TOOLROM}
					 
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
                else
                      echo ""
	                  echo "..................................-"
                      echo "Error compiling $ROM "
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	               exit 1
                fi

		 
		elif [ $SCRIPTROM = "floko" ]; then
            echo ""
	        echo "................................../"
		    echo "it will begin to build $ROM "
            copytrees
			patchrom
			
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Start build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
			
		    source build/envsetup.sh
            brunch lavender 
                if [ $? -eq 0 ]; then
                     echo ""
	                 echo "..................................|"
                     echo "Finished build $ROM"  
		             cp  ${OUTF}/Floko*.zip   ${TOOLROM}
					 
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
                else
                     echo ""
	                  echo "..................................-"
                      echo "Error compiling $ROM "
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	               exit 1
                fi
		
        elif [ $SCRIPTROM = "havoc" ]; then		
            echo ""
	        echo "................................../"
		    echo "it will begin to build $ROM "
            copytrees
			patchrom
			
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Start build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
		    source build/envsetup.sh
            brunch lavender
                if [ $? -eq 0 ]; then
                     echo ""
	                 echo "..................................|"
                     echo "Finished build $ROM"  
		              cp  ${OUTF}/Havoc*.zip ${TOOLROM}
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
                else
                      echo ""
	                  echo "..................................-"
                      echo "Error compiling $ROM "
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	              exit 1
                fi
          
				 
        elif [ $SCRIPTROM = "ion" ]; then		
            echo ""
	        echo "................................../"
		    echo "it will begin to build $ROM "
            copytrees
			patchrom
			
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Start build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
		    source build/envsetup.sh
            lunch ion_lavender-user
            mka bacon -j4
                if [ $? -eq 0 ]; then
                      echo ""
	                 echo "..................................|"
                     echo "Finished build $ROM"  
		              cp  ${OUTF}/ion*.zip ${TOOLROM}
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
                else
                      echo ""
	                  echo "..................................-"
                      echo "Error compiling $ROM "
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	               exit 1
                fi
		
        elif [ $SCRIPTROM = "lineage" ]; then		
            echo ""
	        echo "................................../"
		    echo "it will begin to build $ROM "
            copytrees
			patchrom
			
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Start build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
		    source build/envsetup.sh
            breakfast lavender
            brunch lavender
            make carbon -j4
                if [ $? -eq 0 ]; then
                      echo ""
	                 echo "..................................|"
                     echo "Finished build $ROM"  
		              cp  ${OUTF}/lineage-16*.zip ${TOOLROM}
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
                else
                      echo ""
	                  echo "..................................-"
                      echo "Error compiling $ROM "
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	               exit 1
                fi
          
	   elif [ $SCRIPTROM = "lotus" ]; then		
            echo ""
	        echo "................................../"
		    echo "it will begin to build $ROM "
            copytrees
			patchrom
		
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Start build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
		    source build/envsetup.sh
            lunch lotus_lavender-userdebug
            make bacon -j4
              if [ $? -eq 0 ]; then
                  echo ""
	                 echo "..................................|"
                     echo "Finished build $ROM"  
		          cp  ${OUTF}/Lo*.zip ${TOOLROM}
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
              else
                  echo ""
	                  echo "..................................-"
                      echo "Error compiling $ROM "
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	             exit 1
              fi
			  

        elif [ $SCRIPTROM = "nitrogen" ]; then
            echo ""
	        echo "................................../"
		    echo "it will begin to build $ROM "
            copytrees
			patchrom
		
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Start build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
		    source build/envsetup.sh
            lunch nitrogen_lavender-userdebug
            make -j 4 otapackage
              if [ $? -eq 0 ]; then
                  echo ""
	                 echo "..................................|"
                     echo "Finished build $ROM"  
		          cp  ${OUTF}/Nitrogen*.zip  ${TOOLROM}
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
              else
                  echo ""
	                  echo "..................................-"
                      echo "Error compiling $ROM "
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	             exit 1
              fi		
		
        elif [ $SCRIPTROM = "rr" ]; then		
            echo ""
	        echo "................................../"
		    echo "it will begin to build $ROM "
            copytrees
			patchrom
		
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Start build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
		    source build/envsetup.sh
            brunch lavender
              if [ $? -eq 0 ]; then
                     echo ""
	                 echo "..................................|"
                     echo "Finished build $ROM"  
		          cp  ${OUTF}/RR-P-v7*.zip ${TOOLROM}
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
              else
                      echo ""
	                  echo "..................................-"
                      echo "Error compiling $ROM "
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	              exit 1
              fi
		
		elif [ $SCRIPTROM = "xenon" ]; then
              echo ""
	        echo "................................../"
		    echo "it will begin to build $ROM "
            copytrees
			patchrom
		
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Start build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
		    source build/envsetup.sh
            brunch lavender
              if [ $? -eq 0 ]; then
                     echo ""
	                 echo "..................................|"
                     echo "Finished build $ROM"  
		          cp  ${OUTF}/XenonHD*.zip ${TOOLROM}
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
              else
                      echo ""
	                  echo "..................................-"
                      echo "Error compiling $ROM "
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	             exit 1
              fi

        elif [ $SCRIPTROM = "xtended" ]; then	
		    echo ""
	        echo "................................../"
		    echo "it will begin to build $ROM "
            copytrees
			patchrom
			
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Start build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
		    source build/envsetup.sh
            lunch xtended_lavender-userdebug
            make xtended
                if [ $? -eq 0 ]; then
                     echo ""
	                 echo "..................................|"
                     echo "Finished build $ROM"  
		              cp  ${OUTF}/Xtended*.zip ${TOOLROM}
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
                else
                      echo ""
	                  echo "..................................-"
                      echo "Error compiling $ROM "
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	               exit 1
                fi
	 fi			
    elif [ $BUILDROM = "no" ]; then
            echo ""
		    echo "..................................O"
			echo "Skip Build $ROM"       		
        
	
	else
	    echo ""
	    echo "................................../"
        echo "You didn't entered a valid option."
		exit 1


    
fi
}      




# Main program

function main() {
echo ""
echo ""    
echo " *********************************"		
echo "                                          "		
echo "            𝕾𝖈𝖗𝖎𝖕𝖙 𝕭𝖚𝖎𝖑𝖉                 "		
echo "                                 "		
echo "               𝖇𝖞                    "
echo "                                 "		
echo "             𝕵𝖎𝖒𝖌𝖘𝖊𝖞                  "		
echo "                                "		
echo " *********************************"					
echo ""		
echo ""

    start
    romselect
    syncrom
	buildrom
    uploadrom
    romclean

}

#Execute the program

main



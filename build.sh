# Copyright (C) 2020 daniml3 and Jimgsey All rights reserved

# Declare all functions
LINKJEN="Your jenkins link"
# Telegram Messages
function telegrammsg() {
TOKEN="Use your token"
ID="Your id bot"
curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=$ID -d text="$MESSAGE"
}



# Make clean

function romclean() {
    # You can export the ROM by running export SCRIPTROM="<text>". Example: export SCRIPTROM="lineage" (for LineageOS 16.0)
    if [[ -v ROMCLEAN ]]; then
    echo "Using exported ROM: $ROMCLEAN"
    else

        echo "Select the option"
        echo "[make]   Make Clean"
        echo "[delete] Delete"
        echo "[no]     Nothing"
        read -p "Selection: " ROMCLEAN
    fi
	
    if [ $ROMCLEAN = "make" ]; then
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
        echo "Deleting all folder to $ROM "
        rm -r $ROMDIR
##############################################Push telegram message############################################################

	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Delete folder $ROM.  Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
    elif [ $ROMCLEAN = "no" ]; then
        echo "Nothing"
    else
        echo "You didn't entered a valid option."
    fi
}


# Generate mirror json

function gen_ota_json() {
     
    if [ $SCRIPTROM = "aicp" ]; then
        echo "Generating $ROM 14.0 json"
            cd $ROMDIR
            DATETIME=$(grep "ro.build.date.utc=" out/target/product/lavender/system/build.prop | cut -d "=" -f 2)
            FILENAME=$(find out/target/product/lavender/aicp_lavender_p*.zip | cut -d "/" -f 5)
            ID=$(md5sum out/target/product/lavender/aicp_lavender_p*.zip | cut -d " " -f 1)
            SIZE=$(wc -c out/target/product/lavender/aicp_lavender_p*.zip | awk '{print $1}')
            URL1="https://sourceforge.net/projects/lavender7/files/Aicp/$FILENAME"
            URL=$URL1
            VERSION="14.0"
            ROMTYPE="unofficial"
                   JSON_FMT='{\n"response": [\n{\n"filename": "%s",\n"datetime": %s,\n"size":%s, \n"url":"%s", \n"version": "%s",\n"romtype": "%s", \n"id": "%s"\n}\n]\n}'
                   printf "$JSON_FMT" "$FILENAME" "$DATETIME" "$SIZE" "$URL" "$VERSION" "$ROMTYPE" "$ID" > ~/script/ota/lavender-aicp.json
        elif [ $SCRIPTROM = "aex" ]; then
        echo "$ROM OTA is not supported by the script, skipping generation"
		elif [ $SCRIPTROM = "aokp" ]; then
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "aosip" ]; then
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "candy" ]; then
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "carbon" ]; then
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "colt" ]; then
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "cosmic" ]; then
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "cosp" ]; then
        echo "$ROM OTA is not supported by the script, skipping generation"
		elif [ $SCRIPTROM = "crdroid" ]; then
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "derpfest" ]; then
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "dot" ]; then
        echo "$ROM OTA is not supported by the script, skipping generation"
		elif [ $SCRIPTROM = "floko" ]; then
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "havoc" ]; then
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "ion" ]; then
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "lineage" ]; then
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "lotus" ]; then
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "nitrogen" ]; then
        echo "$ROM OTA is not supported by the script, skipping generation"
		elif [ $SCRIPTROM = "rr" ]; then
        echo "$ROM OTA is not supported by the script, skipping generation"
		elif [ $SCRIPTROM = "xenon" ]; then
        echo "$ROM OTA is not supported by the script, skipping generation"
        elif [ $SCRIPTROM = "xtended" ]; then
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
            echo "Updating updater to $ROM"
            cp ~/script/aicp/updater/strings.xml ~/android/aicp/packages/apps/Updater/res/values
        elif [ $SCRIPTROM = "aex" ]; then
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "aokp" ]; then
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "aosip" ]; then
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "candy" ]; then
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "carbon" ]; then
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "colt" ]; then
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "cosmic" ]; then
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "cosp" ]; then
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "crdroid" ]; then
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "derpfest" ]; then
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "dot" ]; then
            echo "OTA for $ROM not supported by the script, skipping patch"	
        elif [ $SCRIPTROM = "floko" ]; then
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "havoc" ]; then
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "ion" ]; then
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "lineage" ]; then
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "lotus" ]; then
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "nitrogen" ]; then
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "rr" ]; then
            echo "OTA for $ROM not supported by the script, skipping patch"
		elif [ $SCRIPTROM = "xenon" ]; then
            echo "OTA for $ROM not supported by the script, skipping patch"
        elif [ $SCRIPTROM = "xtended" ]; then
            echo "OTA for $ROM not supported by the script, skipping patch"
			
    fi

}

# Upload ROM

function uploadrom() {

        if [[ -v UPLOADROM ]]; then
    echo "Uploading ROM: $UPLOADROM"
    else
        echo "Do you want upload the rom? "
        echo "[yes] Upload"
        echo "[no] Skip"
        read -p "Selection: " UPLOADROM
    fi

    if [ $UPLOADROM = "yes" ]; then
        if [ $SCRIPTROM = "aicp" ]; then
              echo "Uploading $ROM "			
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/aicp_lavender_p*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Aicp/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################				  
              scp  ~/ae/aicp_lavender_p*.zip youraccount@frs.sourceforge.net:/home/frs/project/lavender7/Aicp/ 
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/aicp_lavender_p*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Aicp/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	

##################### Upload OTA ############## 
                    push_ota_json
##################### Upload OTA ##############


        elif [ $SCRIPTROM = "aex" ]; then
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/AospExtended-v6*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Aex/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ~/ae/AospExtended-v6*.zip youraccount@frs.sourceforge.net:/home/frs/project/lavender7/Aex/
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/AospExtended-v6*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Aex/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
			  
        elif [ $SCRIPTROM = "aokp" ]; then
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/aokp_lavender_pie*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Aokp/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ~/ae/aokp_lavender_pie*.zip youraccount@frs.sourceforge.net:/home/frs/project/lavender7/Aokp/ 
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/aokp_lavender_pie*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Aokp/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################
			  
        elif [ $SCRIPTROM = "aosip" ]; then
              echo "Uploading $ROM "			
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/AOSiP-9.0-Pizza*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Aosip/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################				  
              scp  ~/ae/AOSiP-9.0-Pizza*.zip  youraccount@frs.sourceforge.net:/home/frs/project/lavender7/Aosip/ 
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/AOSiP-9.0-Pizza*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Aosip/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################				  

         elif [ $SCRIPTROM = "candy" ]; then
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/Candy*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Candy/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ~/ae/candy*.zip youraccount@frs.sourceforge.net:/home/frs/project/lavender7/Candy/
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/Candy*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Candy/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
			  

        elif [ $SCRIPTROM = "carbon" ]; then
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/CARBON*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Carbon/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ~/ae/CARBON*.zip youraccount@frs.sourceforge.net:/home/frs/project/lavender7/Carbon/ 
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/CARBON*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Carbon/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################
        elif [ $SCRIPTROM = "colt" ]; then
              echo "Uploading $ROM "			
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/ColtOS*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Colt/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################				  
              scp  ~/ae/ColtOS*.zip  youraccount@frs.sourceforge.net:/home/frs/project/lavender7/Colt/ 
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/ColtOS*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Colt/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################				  

        elif [ $SCRIPTROM = "cosmic" ]; then
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/Cosmic-OS-v4.0-Corona*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Cosmic/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ~/ae/cosmic*.zip youraccount@frs.sourceforge.net:/home/frs/project/lavender7/Cosmic/ 
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/Cosmic-OS-v4.0-Corona*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Cosmic/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################
			  
        elif [ $SCRIPTROM = "cosp" ]; then
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/COSP*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Cosp/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ~/ae/COSP*.zip youraccount@frs.sourceforge.net:/home/frs/project/lavender7/Cosp/ 
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/COSP*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Cosp/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################

        elif [ $SCRIPTROM = "crdroid" ]; then
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/crDroidAndroid-9*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/CrDroid/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ~/ae/crDroidAndroid-9*.zip youraccount@frs.sourceforge.net:/home/frs/project/lavender7/CrDroid/
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/crDroidAndroid-9*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/CrDroid/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################
			  
        elif [ $SCRIPTROM = "derpfest" ]; then
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/AOSiP-9.0-DerpFest*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/DerpFest/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ~/ae/AOSiP-9.0-DerpFest*.zip  youraccount@frs.sourceforge.net:/home/frs/project/lavender7/DerpFest/ 
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/AOSiP-9.0-DerpFest*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/DerpFest/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################
		
	    elif [ $SCRIPTROM = "dot" ]; then
              echo "Uploading $ROM "			
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/dotOS-P*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Dot/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################				  
              scp  ~/ae/dotOS-P*.zip  youraccount@frs.sourceforge.net:/home/frs/project/lavender7/Dot/ 
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/dotOS-P*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Dot/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################				  


        elif [ $SCRIPTROM = "floko" ]; then
              echo "Uploading $ROM "			
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/Floko*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Floko/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################				  
              scp  ~/ae/Floko*.zip  youraccount@frs.sourceforge.net:/home/frs/project/lavender7/Floko/ 
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/Floko*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Floko/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
		
        elif [ $SCRIPTROM = "havoc" ]; then
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/Havoc*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Havoc/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ~/ae/Havoc*.zip youraccount@frs.sourceforge.net:/home/frs/project/lavender7/Havoc/ 
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/Havoc*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Havoc/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################
			  
	  
        elif [ $SCRIPTROM = "ion" ]; then
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/ion*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Ion/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ~/ae/ion*.zip youraccount@frs.sourceforge.net:/home/frs/project/lavender7/Ion/ 
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/ion*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Ion/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################
			  

        elif [ $SCRIPTROM = "lineage" ]; then
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/lineage-16*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Lineage/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ~/ae/lineage-16*.zip youraccount@frs.sourceforge.net:/home/frs/project/lavender7/Lineage/ 
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/lineage-16*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Lineage/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	

		elif [ $SCRIPTROM = "lotus" ]; then
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/Lo*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Lotus/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ~/ae/Lo*.zip youraccount@frs.sourceforge.net:/home/frs/project/lavender7/Lotus/
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/Lo*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Lotus/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################
			  
        elif [ $SCRIPTROM = "nitrogen" ]; then
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/Nitrogen*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Nitrogen/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp ~/ae/Nitrogen*.zip  youraccount@frs.sourceforge.net:/home/frs/project/lavender7/Nitrogen/ 
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/Nitrogen*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Nitrogen/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	  
        elif [ $SCRIPTROM = "rr" ]; then
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/RR-P-v7*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/ResurrectionRemix/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ~/ae/RR-P-v7*.zipyouraccount@frs.sourceforge.net:/home/frs/project/lavender7/ResurrectionRemix/ 
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/RR-P-v7*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/ResurrectionRemix/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
			  
        elif [ $SCRIPTROM = "xenon" ]; then
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/XenonHD*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Xenon/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ~/ae/XenonHD*.zip youraccount@frs.sourceforge.net:/home/frs/project/lavender7/Xenon/  
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/XenonHD*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Xenon/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################				  
    
      elif [ $SCRIPTROM = "xtended" ]; then
              echo "Uploading $ROM "
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/Xtended*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Xtended/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updating $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
              scp  ~/ae/Xtended*.zip youraccount@frs.sourceforge.net:/home/frs/project/lavender7/Xtended/
##############################################Push telegram message############################################################
    FILENAME=$(find ~/ae/Xtended*.zip | cut -d "/" -f 5)
	UPDATE_URL1="https://sourceforge.net/projects/lavender7/files/Xtended/$FILENAME"
	DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Updated $ROM. Link:$UPDATE_URL1 Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
###############################################################################################################################	
			  

      elif [ $BUILDROM = "no" ]; then
            echo "Skip Upload $ROM "       		
		   else
            echo "You didn't entered a valid option."
        
		
   
        fi
	fi	
}

# Select ROM

function romselect() {
    # You can export the ROM by running export SCRIPTROM="<romnumber>". Example: export SCRIPTROM="1" (for LineageOS 16.0)
    if [[ -v SCRIPTROM ]]; then
    echo "Using exported ROM: $SCRIPTROM"
    else
        echo "Select the rom to build: "
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
        echo "[rr] RR"
		echo "[xenon] Xenon HD"
        echo "[xtended] Xtended"     

        read -p "Selection: " SCRIPTROM
    fi
	
    if [ $SCRIPTROM = "aicp" ]; then
        ROMDIR="${HOME}/android/aicp"
        ROM="Aicp"
		echo "Building $ROM"
		

            if [ -d ~/android/aicp/ ]; then
                   echo "Folder already exists"

            else
                   echo "Create folder"
                   mkdir ~/android/aicp
            fi
	
	        if [ -d ~/android/aicp/.repo/ ]; then
                   echo "Folder already exists"

            else
                   
                   echo "Add sync"
                   cd $ROMDIR
                   repo init -u https://github.com/AICP/platform_manifest.git -b p9.0
            fi
		
		
    elif [ $SCRIPTROM = "aex" ]; then
        ROMDIR="${HOME}/android/aex"
        ROM="Aex"
		echo "Building $ROM"
		

            if [ -d ~/android/aex/ ]; then
                   echo "Folder already exists"

            else
                   echo "Create folder"
                   mkdir ~/android/aex
            fi
	
	        if [ -d ~/android/aex/.repo/ ]; then
                   echo "Folder already exists"

            else
                   echo "Add sync"
                   cd $ROMDIR
                   repo init -u git://github.com/AospExtended/manifest.git -b 9.x
            fi
	
               
	elif [ $SCRIPTROM = "aokp" ]; then
        ROMDIR="${HOME}/android/aokp"
		ROM="Aokp"
		echo "Building $ROM"

            if [ -d ~/android/aokp/ ]; then
                    echo "Folder already exists"

            else
                    echo "Create folder"
                    mkdir ~/android/aokp
            fi
	
	        if [ -d ~/android/aokp/.repo/ ]; then
                    echo "Folder already exists"

            else
                    echo "Add sync"
                    cd $ROMDIR
                    repo init -u https://github.com/AOKP/platform_manifest.git -b pie
            fi

	elif [ $SCRIPTROM = "aosip" ]; then
        ROMDIR="${HOME}/android/aosip"
		ROM="Aosip"
		echo "Building $ROM"

            if [ -d ~/android/aosip/ ]; then
                   echo "Folder already exists"

            else
                   echo "Create folder"
                   mkdir ~/android/aosip
            fi
	
	        if [ -d ~/android/aosip/.repo/ ]; then
                   echo "Folder already exists"

            else
                   
                   echo "Add sync"
                   cd $ROMDIR
                   repo init -u git://github.com/AOSiP/platform_manifest.git -b pie
            fi
		
	elif [ $SCRIPTROM = "candy" ]; then
        ROMDIR="${HOME}/android/candy"
        ROM="Candy"
		echo "Building $ROM"
		

            if [ -d ~/android/candy/ ]; then
                   echo "Folder already exists"

            else
                   echo "Create folder"
                   mkdir ~/android/candy
            fi
	
	        if [ -d ~/android/candy/.repo/ ]; then
                   echo "Folder already exists"

            else
                   echo "Add sync"
                   cd $ROMDIR
                   repo init -u git://github.com/CandyRoms/candy.git -b c9.0
            fi
		
    elif [ $SCRIPTROM = "carbon" ]; then
        ROMDIR="${HOME}/android/carbon"
		ROM="Carbon"
		echo "Building $ROM"

            if [ -d ~/android/carbon/ ]; then
                   echo "Folder already exists"

            else
                   echo "Create folder"
                   mkdir ~/android/carbon
            fi
	
	        if [ -d ~/android/carbon/.repo/ ]; then
                   echo "Folder already exists"

            else
                   echo "Add sync"
                   cd $ROMDIR
                   repo init -u https://github.com/CarbonROM/android.git -b cr-7.0 
            fi
	
    elif [ $SCRIPTROM = "colt" ]; then
        ROMDIR="${HOME}/android/colt"
		ROM="Colt"
		echo "Building $ROM"

            if [ -d ~/android/colt/ ]; then
                   echo "Folder already exists"

            else
                   echo "Create folder"
                   mkdir ~/android/colt
            fi
	
	        if [ -d ~/android/colt/.repo/ ]; then
                   echo "Folder already exists"

            else
                   
                   echo "Add sync"
                   cd $ROMDIR
                   repo init -u git://github.com/Colt-Enigma/platform_manifest.git -b wip
            fi
    
    elif [ $SCRIPTROM = "cosmic" ]; then
        ROMDIR="${HOME}/android/cosmic"
		ROM="Cosmic"
		echo "Building $ROM"

            if [ -d ~/android/cosmic/ ]; then
                    echo "Folder already exists"

            else
                    echo "Create folder"
                    mkdir ~/android/cosmic
            fi
	
	        if [ -d ~/android/cosmic/.repo/ ]; then
                    echo "Folder already exists"

            else
                    echo "Add sync"
                    cd $ROMDIR
                    repo init -u https://github.com/Cosmic-OS/platform_manifest.git -b corona-release
            fi


    elif [ $SCRIPTROM = "cosp" ]; then
        ROMDIR="${HOME}/android/cosp"
		ROM="Cosp"
		echo "Building $ROM"

            if [ -d ~/android/cosp/ ]; then
                    echo "Folder already exists"

            else
                    echo "Create folder"
                    mkdir ~/android/cosp
            fi
	
	        if [ -d ~/android/cosp/.repo/ ]; then
                    echo "Folder already exists"

            else
                    echo "Add sync"
                    cd $ROMDIR
                    repo init -u https://github.com/cosp-project/manifest -b pie
            fi
   
	elif [ $SCRIPTROM = "crdroid" ]; then
        ROMDIR="${HOME}/android/crdroid"
		ROM="CrDroid"
		echo "Building $ROM"

            if [ -d ~/android/crdroid/ ]; then
                    echo "Folder already exists"

            else
                    echo "Create folder"
                    mkdir ~/android/crdroid
            fi
	
	        if [ -d ~/android/crdroid/.repo/ ]; then
                    echo "Folder already exists"

            else
                    echo "Add sync"
                    cd $ROMDIR
                    repo init -u git://github.com/crdroidandroid/android.git -b 9.0
            fi
			
    elif [ $SCRIPTROM = "derpfest" ]; then
		ROMDIR="${HOME}/android/derpfest"
		ROM="Derpfest"
		echo "Building $ROM"
			
            if [ -d ~/android/derpfest/ ]; then
                     echo "Folder already exists"

            else
                     echo "Create folder"
                     mkdir ~/android/derpfest
            fi
	
	        if [ -d ~/android/derpfest/.repo/ ]; then
                     echo "Folder already exists"

            else
                     echo "Add sync"
                     cd $ROMDIR
                     repo init -u git://github.com/DerpFest-Pie/platform_manifest.git -b pie
            fi

    elif [ $SCRIPTROM = "dot" ]; then
        ROMDIR="${HOME}/android/dot"
		ROM="Dot"
		echo "Building $ROM"

            if [ -d ~/android/dot/ ]; then
                   echo "Folder already exists"

            else
                   echo "Create folder"
                   mkdir ~/android/dot
            fi
	
	        if [ -d ~/android/dot/.repo/ ]; then
                   echo "Folder already exists"

            else
                   
                   echo "Add sync"
                   cd $ROMDIR
                   repo init -u git://github.com/DotOS/manifest.git -b dot-p
            fi
		
		
    elif [ $SCRIPTROM = "floko" ]; then
        ROMDIR="${HOME}/android/floko"
		ROM="Floko"
		echo "Building $ROM"

            if [ -d ~/android/floko/ ]; then
                   echo "Folder already exists"

            else
                   echo "Create folder"
                   mkdir ~/android/floko
            fi
	
	        if [ -d ~/android/floko/.repo/ ]; then
                   echo "Folder already exists"

            else
                   
                   echo "Add sync"
                   cd $ROMDIR
                   repo init -u https://github.com/FlokoROM/manifesto.git -b 9.0
            fi
	
	elif [ $SCRIPTROM = "havoc" ]; then
        ROMDIR="${HOME}/android/havoc"
		ROM="Havoc"
		echo "Building $ROM"

            if [ -d ~/android/havoc/ ]; then
                   echo "Folder already exists"

            else
                   echo "Create folder"
                   mkdir ~/android/havoc
            fi
	
	        if [ -d ~/android/havoc/.repo/ ]; then
                   echo "Folder already exists"

            else
                   echo "Add sync"
                   cd $ROMDIR
                   repo init -u https://github.com/Havoc-OS/android_manifest.git -b pie
            fi


    elif [ $SCRIPTROM = "ion" ]; then
        ROMDIR="${HOME}/android/ion"
		ROM="Ion"
		echo "Building $ROM"

            if [ -d ~/android/ion/ ]; then
                   echo "Folder already exists"

            else
                   echo "Create folder"
                   mkdir ~/android/ion
            fi
	
	        if [ -d ~/android/ion/.repo/ ]; then
                   echo "Folder already exists"

            else
                   echo "Add sync"
                   cd $ROMDIR
                   repo init -u https://github.com/i-o-n/manifest -b pie
            fi
		
    elif [ $SCRIPTROM = "lineage" ]; then
        ROMDIR="${HOME}/android/lineage"
		ROM="Lineage"
		echo "Building $ROM"

            if [ -d ~/android/lineage/ ]; then
                   echo "Folder already exists"

            else
                   echo "Create folder"
                   mkdir ~/android/lineage
            fi
	
	        if [ -d ~/android/lineage/.repo/ ]; then
                   echo "Folder already exists"

            else
                   echo "Add sync"
                   cd $ROMDIR
                   repo init -u git://github.com/LineageOS/android.git -b lineage-16.0
            fi
	
    elif [ $SCRIPTROM = "lotus" ]; then
        ROMDIR="${HOME}/android/lotus"
		ROM="Lotus"
		echo "Building $ROM"

            if [ -d ~/android/lotus/ ]; then
                    echo "Folder already exists"

            else
                    echo "Create folder"
                    mkdir ~/android/lotus
            fi
	
	        if [ -d ~/android/lotus/.repo/ ]; then
                    echo "Folder already exists"

            else
                    echo "Add sync"
                    cd $ROMDIR
                    repo init -u https://github.com/LotusOS/android_manifest.git -b pie
            fi

    elif [ $SCRIPTROM = "nitrogen" ]; then
		ROMDIR="${HOME}/android/nitrogen"
		ROM="Nitrogen"
		echo "Building $ROM"
		
            if [ -d ~/android/nitrogen/ ]; then
                     echo "Folder already exists"

            else
                     echo "Create folder"
                     mkdir ~/android/nitrogen
            fi
	
	        if [ -d ~/android/nitrogen/.repo/ ]; then
                     echo "Folder already exists"

            else
                     echo "Add sync"
                     cd $ROMDIR
                     repo init -u https://github.com/nitrogen-project/android_manifest.git -b p
            fi	
       
	elif [ $SCRIPTROM = "rr" ]; then
        ROMDIR="${HOME}/android/rr"
		ROM="ResurrectionRemix"
		echo "Building $ROM"

            if [ -d ~/android/rr/ ]; then
                    echo "Folder already exists"

            else
                    echo "Create folder"
                    mkdir ~/android/rr
            fi
	
	        if [ -d ~/android/rr/.repo/ ]; then
                    echo "Folder already exists"

            else
                    echo "Add sync"
                    cd $ROMDIR
                    repo init -u https://github.com/RR-Test/platform_manifest.git -b test_pie
            fi
	elif [ $SCRIPTROM = "xenon" ]; then
		ROMDIR="${HOME}/android/xenon"
		ROM="Xenon"
        echo "Building $ROM"
		
		
            if [ -d ~/android/xenon/ ]; then
                     echo "Folder already exists"

            else
                     echo "Create folder"
                     mkdir ~/android/xenon
            fi
	
	        if [ -d ~/android/xenon/.repo/ ]; then
                     echo "Folder already exists"

            else
                     echo "Add sync"
                     cd $ROMDIR
                     repo init -u https://github.com/TeamHorizon/platform_manifest.git -b p
            fi	
    elif [ $SCRIPTROM = "xtended" ]; then
        ROMDIR="${HOME}/android/xtended"
        ROM="Xtended"
		echo "Building $ROM"

            if [ -d ~/android/xtended/ ]; then
                   echo "Folder already exists"

            else
                   echo "Create folder"
                   mkdir ~/android/xtended
            fi
	
	        if [ -d ~/android/xtended/.repo/ ]; then
                   echo "Folder already exists"

            else
                   echo "Add sync"
                   cd $ROMDIR
                   repo init -u https://github.com/Project-Xtended/manifest.git -b xp
            fi	
	else
        echo "You didn't entered a valid option."
    fi
}

# Repo sync

function syncrom() {
     
	if [[ -v SCRIPTSYNC ]]; then
    echo "Using exported ROM: $SCRIPTSYNC"
    else
        echo "Sync or skip:"
        echo "[yes] Sync Repository"
        echo "[no] Skip Sync"
        read -p "Selection: " SCRIPTSYNC
    fi
    if [ $SCRIPTSYNC = "yes" ]; then
        echo "Synchronizing repository $ROM"
		
###########################################################################################################################
DATE=$(date '+%d/%m/%Y')
HOURS=$(date '+%H:%M min')
MESSAGE="Start sync $ROM at $HOURS to $DATE with link Jenkins: $LINKJEN "
        telegrammsg
###########################################################################################################################
		cd $ROMDIR	
		repo sync --force-sync --no-clone-bundle --no-tags -j4 
	    if [ $? -eq 0 ]; then
             echo "Sync done $ROM"
###########################################################################################################################
DATE=$(date '+%d/%m/%Y')
HOURS=$(date '+%H:%M min')
MESSAGE="Finish sync $ROM at $HOURS to $DATE with link Jenkins: $LINKJEN "
        telegrammsg
###########################################################################################################################
        else
             echo "Sync failed $ROM"
             exit 1
###########################################################################################################################
DATE=$(date '+%d/%m/%Y')
HOURS=$(date '+%H:%M min')
MESSAGE="Failed sync $ROM at $HOURS to $DATE with link Jenkins: $LINKJEN "
        telegrammsg
###########################################################################################################################
     
        fi
    elif [ $SCRIPTSYNC = "no" ]; then
        echo "Skipping sync $ROM "
        else
        echo "You didn't entered a valid option."
    fi
}





# Build Rom

function buildrom() {

    if [[ -v BUILDROM ]]; then
    echo "Using exported ROM: $BUILDROM"
    else
        echo "Select the rom to build: "
        echo "[yes] Build"
        echo "[no] No"
        read -p "Selection: " BUILDROM
    fi

    if [ $BUILDROM = "yes" ]; then
        echo "Building Rom"
        cd $ROMDIR
		git clone -b lineage-16.0 https://github.com/LineageOS/android_packages_resources_devicesettings packages/resources/devicesettings
################
################
################		   
             if [ $SCRIPTROM = "aicp" ]; then
                echo "Copying tree"
		        #Clonado device tree
                if [ -d ~/android/aicp/device/xiaomi/lavender/ ]; then
                    echo "Folder already exists"
                else
                    echo "Copying tree"
                    cp -r ~/treees/bue/aicp/         ~/android/
                    cp -r ~/treees/bue/comun/vendor/ ~/android/aicp/
                    cp -r ~/treees/bue/comun/kernel/ ~/android/aicp/
                fi

		    echo "Start build  $ROM "
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
                     echo "Finished build $ROM"  
		             cp  out/target/product/lavender/aicp_lavender_p*.zip ~/ae
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
        echo "Copying tree"
		#Clonado device tree
                if [ -d ~/android/aex/device/xiaomi/lavender/ ]; then
                    echo "Folder already exists"
                else
                    echo "Copying tree"
                    cp -r ~/treees/bue/aex/         ~/android/
                    cp -r ~/treees/bue/comun/vendor/ ~/android/aex/
                    cp -r ~/treees/bue/comun/kernel/ ~/android/aex/
                fi
				
		    echo "Start build  $ROM "
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
                      echo "Finished build $ROM"  
		              cp  out/target/product/lavender/AospExtended-v6*.zip ~/ae
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
                else
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
        echo "Copying tree"
		#Clonado device tree
            if [ -d ~/android/aokp/device/xiaomi/lavender/ ]; then
                echo "Folder already exists"
            else
                echo "Copying tree"
                cp -r ~/treees/bue/aokp/         ~/android/
                cp -r ~/treees/bue/comun/vendor/ ~/android/aokp/
                cp -r ~/treees/bue/comun/kernel/ ~/android/aokp/
            fi
		echo "Start build  $ROM "
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
                  echo "Finished build $ROM"  
		          cp  out/target/product/lavender/aokp_lavender_pie*.zip ~/ae
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
              else
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
        echo "Copying tree"
		#Clonado device tree
                if [ -d ~/android/aosip/device/xiaomi/lavender/ ]; then
                    echo "Folder already exists"
                else
                    echo "Copying tree"
                    cp -r ~/treees/bue/aosip/         ~/android/
                    cp -r ~/treees/bue/comun/vendor/ ~/android/aosip/
                    cp -r ~/treees/bue/comun/kernel/ ~/android/aosip/
                fi

		    echo "Start build  $ROM "
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
                     echo "Finished build $ROM"  
		             cp  out/target/product/lavender/AOSiP-9.0-Pizza*.zip  ~/ae
					 
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
                else
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
        echo "Copying tree"
		#Clonado device tree
                if [ -d ~/android/candy/device/xiaomi/lavender/ ]; then
                    echo "Folder already exists"
                else
                    echo "Copying tree"
                    cp -r ~/treees/bue/candy/         ~/android/
                    cp -r ~/treees/bue/comun/vendor/ ~/android/candy/
                    cp -r ~/treees/bue/comun/kernel/ ~/android/candy/
                fi
				
		    echo "Start build  $ROM "
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
                      echo "Finished build $ROM"  
		              cp  out/target/product/lavender/Candy*.zip ~/ae
	
                else
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
        echo "Copying tree"
		#Clonado device tree
                if [ -d ~/android/carbon/device/xiaomi/lavender/ ]; then
                    echo "Folder already exists"
                else
                    echo "Copying tree"
                    cp -r ~/treees/bue/carbon/         ~/android/
                    cp -r ~/treees/bue/comun/vendor/ ~/android/carbon/
                    cp -r ~/treees/bue/comun/kernel/ ~/android/carbon/
                fi
				
		    echo "Start build  $ROM "
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
                      echo "Finished build $ROM"  
		              cp  out/target/product/lavender/CARBON*.zip ~/ae
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
                else
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
        echo "Copying tree"
		#Clonado device tree
                if [ -d ~/android/colt/device/xiaomi/lavender/ ]; then
                    echo "Folder already exists"
                else
                    echo "Copying tree"
                    cp -r ~/treees/bue/colt/         ~/android/
                    cp -r ~/treees/bue/comun/vendor/ ~/android/colt/
                    cp -r ~/treees/bue/comun/kernel/ ~/android/colt/
                fi

		    echo "Start build  $ROM "
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
                     echo "Finished build $ROM"  
		             cp  out/target/product/lavender/ColtOS*.zip  ~/ae
					 
	
                else
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
        echo "Copying tree"
		#Clonado device tree
            if [ -d ~/android/cosmic/device/xiaomi/lavender/ ]; then
                echo "Folder already exists"
            else
                echo "Copying tree"
                cp -r ~/treees/bue/cosmic/         ~/android/
                cp -r ~/treees/bue/comun/vendor/ ~/android/cosmic/
                cp -r ~/treees/bue/comun/kernel/ ~/android/cosmic/
            fi
		echo "Start build  $ROM "
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
                  echo "Finished build $ROM"  
		          cp  out/target/product/lavender/Cosmic-OS-v4.0-Corona*.zip ~/ae
	
              else
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
        echo "Copying tree"
		#Clonado device tree
            if [ -d ~/android/cosp/device/xiaomi/lavender/ ]; then
                echo "Folder already exists"
            else
                echo "Copying tree"
                cp -r ~/treees/bue/cosp/         ~/android/
                cp -r ~/treees/bue/comun/vendor/ ~/android/cosp/
                cp -r ~/treees/bue/comun/kernel/ ~/android/cosp/
            fi
		echo "Start build  $ROM "
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
                  echo "Finished build $ROM"  
		          cp  out/target/product/lavender/COSP*.zip ~/ae
	
              else
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
        echo "Copying tree"
		#Clonado device tree
            if [ -d ~/android/crdroid/device/xiaomi/lavender/ ]; then
                echo "Folder already exists"
            else
                echo "Copying tree"
                cp -r ~/treees/bue/crdroid/         ~/android/
                cp -r ~/treees/bue/comun/vendor/ ~/android/crdroid/
                cp -r ~/treees/bue/comun/kernel/ ~/android/crdroid/
            fi
		echo "Start build  $ROM "
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
                  echo "Finished build $ROM"  
		          cp  out/target/product/lavender/crDroidAndroid-9*.zip ~/ae
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
              else
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
        echo "Copying tree"
		#Clonado device tree
            if [ -d ~/android/derpfest/device/xiaomi/lavender/ ]; then
                echo "Folder already exists"
            else
                echo "Copying tree"
                cp -r ~/treees/bue/derpfest/         ~/android/
                cp -r ~/treees/bue/comun/vendor/ ~/android/derpfest/
                cp -r ~/treees/bue/comun/kernel/ ~/android/derpfest/
            fi
		echo "Start build  $ROM "
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
                  echo "Finished build $ROM"  
		          cp  out/target/product/lavender/AOSiP-9.0-DerpFest*.zip  ~/ae
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
              else
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
        echo "Copying tree"
		#Clonado device tree
                if [ -d ~/android/dot/device/xiaomi/lavender/ ]; then
                    echo "Folder already exists"
                else
                    echo "Copying tree"
                    cp -r ~/treees/bue/dot/         ~/android/
                    cp -r ~/treees/bue/comun/vendor/ ~/android/dot/
                    cp -r ~/treees/bue/comun/kernel/ ~/android/dot/
                fi

		    echo "Start build  $ROM "
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
                     echo "Finished build $ROM"  
		             cp  out/target/product/lavender/dotOS-P*.zip  ~/ae
					 
	
                else
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
        echo "Copying tree"
		#Clonado device tree
                if [ -d ~/android/floko/device/xiaomi/lavender/ ]; then
                    echo "Folder already exists"
                else
                    echo "Copying tree"
                    cp -r ~/treees/bue/floko/         ~/android/
                    cp -r ~/treees/bue/comun/vendor/ ~/android/floko/
                    cp -r ~/treees/bue/comun/kernel/ ~/android/floko/
                fi

		    echo "Start build  $ROM "
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
                     echo "Finished build $ROM"  
		             cp  out/target/product/lavender/Floko*.zip   ~/ae
					 
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
                else
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
        echo "Copying tree"
		#Clonado device tree
                if [ -d ~/android/havoc/device/xiaomi/lavender/ ]; then
                    echo "Folder already exists"
                else
                    echo "Copying tree"
                    cp -r ~/treees/bue/havoc/         ~/android/
                    cp -r ~/treees/bue/comun/vendor/ ~/android/havoc/
                    cp -r ~/treees/bue/comun/kernel/ ~/android/havoc/
                fi
				
		    echo "Start build  $ROM "
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
                      echo "Finished build $ROM"  
		              cp  out/target/product/lavender/Havoc*.zip ~/ae
	
                else
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
        echo "Copying tree"
		#Clonado device tree
                if [ -d ~/android/ion/device/xiaomi/lavender/ ]; then
                    echo "Folder already exists"
                else
                    echo "Copying tree"
                    cp -r ~/treees/bue/ion/         ~/android/
                    cp -r ~/treees/bue/comun/vendor/ ~/android/ion/
                    cp -r ~/treees/bue/comun/kernel/ ~/android/ion/
                fi
				
		    echo "Start build  $ROM "
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
                      echo "Finished build $ROM"  
		              cp  out/target/product/lavender/ion*.zip ~/ae
	
                else
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
        echo "Copying tree"
		#Clonado device tree
                if [ -d ~/android/lineage/device/xiaomi/lavender/ ]; then
                    echo "Folder already exists"
                else
                    echo "Copying tree"
                    cp -r ~/treees/bue/lineage/         ~/android/
                    cp -r ~/treees/bue/comun/vendor/ ~/android/lineage/
                    cp -r ~/treees/bue/comun/kernel/ ~/android/lineage/
                fi
				
		    echo "Start build  $ROM "
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
                      echo "Finished build $ROM"  
		              cp  out/target/product/lavender/lineage-16*.zip ~/ae
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
                else
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
        echo "Copying tree"
		#Clonado device tree
            if [ -d ~/android/lotus/device/xiaomi/lavender/ ]; then
                echo "Folder already exists"
            else
                echo "Copying tree"
                cp -r ~/treees/bue/lotus/         ~/android/
                cp -r ~/treees/bue/comun/vendor/ ~/android/lotus/
                cp -r ~/treees/bue/comun/kernel/ ~/android/lotus/
            fi
		echo "Start build  $ROM "
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
                  echo "Finished build $ROM"  
		          cp  out/target/product/lavender/Lo*.zip ~/ae
	
              else
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
        echo "Copying tree"
		#Clonado device tree
            if [ -d ~/android/nitrogen/device/xiaomi/lavender/ ]; then
                echo "Folder already exists"
            else
                echo "Copying tree"
                cp -r ~/treees/bue/lotus/         ~/android/
                cp -r ~/treees/bue/comun/vendor/ ~/android/lotus/
                cp -r ~/treees/bue/comun/kernel/ ~/android/lotus/
            fi
		echo "Start build  $ROM "
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
                  echo "Finished build $ROM"  
		          cp  out/target/product/lavender/Nitrogen*.zip  ~/ae
	
              else
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
        echo "Copying tree"
		#Clonado device tree
            if [ -d ~/android/rr/device/xiaomi/lavender/ ]; then
                echo "Folder already exists"
            else
                echo "Copying tree"
                cp -r ~/treees/bue/rr/         ~/android/
                cp -r ~/treees/bue/comun/vendor/ ~/android/rr/
                cp -r ~/treees/bue/comun/kernel/ ~/android/rr/
            fi
		echo "Start build  $ROM "
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
                  echo "Finished build $ROM"  
		          cp  out/target/product/lavender/RR-P-v7*.zip ~/ae
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
              else
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
        echo "Copying tree"
		#Clonado device tree
            if [ -d ~/android/xenon/device/xiaomi/lavender/ ]; then
                echo "Folder already exists"
            else
                echo "Copying tree"
                cp -r ~/treees/bue/aokp/         ~/android/
                cp -r ~/treees/bue/comun/vendor/ ~/android/aokp/
                cp -r ~/treees/bue/comun/kernel/ ~/android/aokp/
            fi
		echo "Start build  $ROM "
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
                  echo "Finished build $ROM"  
		          cp  out/target/product/lavender/XenonHD*.zip ~/ae
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Finished build  $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################		
              else
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
        echo "Copying tree"
		#Clonado device tree
                if [ -d ~/android/xtended/device/xiaomi/lavender/ ]; then
                    echo "Folder already exists"
                else
                    echo "Copying tree"
                    cp -r ~/treees/bue/xtended/         ~/android/
                    cp -r ~/treees/bue/comun/vendor/ ~/android/xtended/
                    cp -r ~/treees/bue/comun/kernel/ ~/android/xtended/
                fi
				
		    echo "Start build  $ROM "
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
                      echo "Finished build $ROM"  
		              cp  out/target/product/lavender/Xtended*.zip ~/ae
	
                else
                      echo "Error compiling $ROM "
##############################################Push telegram message####################################################
    DATE=$(date '+%d/%m/%Y')
    HOURS=$(date '+%H:%M min')
	MESSAGE="Error compiling $ROM. Date: $DATE at $HOURS link to Jenkins: $LINKJEN "
	         telegrammsg
#######################################################################################################################	
	               exit 1
                fi
				
      elif [ $BUILDROM = "no" ]; then
            echo "Skip Build $ROM"       		
        
	
	else
        echo "You didn't entered a valid option."
        fi
fi
}    




# Main program

function main() {
    romselect
    syncrom
	buildrom
    uploadrom
    romclean

}

#Execute the program

main

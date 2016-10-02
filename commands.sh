#!/bin/bash

#///// By iicc \\\\\

if [ "$1" = "source" ];then

	# Place the TOKEN in token file.
	TOKEN=$(cat token)
	ADMINS='Place here the ID of the admins of the bot separated by commas'
	ROOT='Put here the ID of the owner of the bot'
  
 else
 
  echo "--------------------------------------------------------------------------------------"
  echo ""
 
  echo $ADMINS | grep ${USER[ID]}
  if [ $? == 0 ]; then
    ADMIN=1
  else
    ADMIN=0
  fi
 
 
 # LOG BOT ON TERMINAL #
 echo "MSG: $MESSAGE | USER: ${USER[USERNAME]} | ID: ${USER[ID]} | CHAT: ${CHAT[TITLE]} | ID: ${CHAT[ID]}"
 echo ""
 
 
	case $MESSAGE in
		
		'/help')
   if [ "$ADMIN" == "1" ]; then
			send_action "${CHAT[ID]}" "typing"
			send_markdown_message "${CHAT[ID]}" "*Comandos admins:*
/warn     Da un aviso a la persona por reply.
/ban      Banea por reply.
/clear    Quita todos los avisos por reply.
/info     Informacion de los avisos de ese user.
/warns    Muestra la gente avisada."
    else
      send_markdown_message "${USER[ID]}" "*No eres admin*"
    fi
			
			;;
      
     '/backup')
       if [ "$ADMIN" == "1" ]; then
         send_file "$ROOT" "bashbot.sh" "Warnbot TG API"
         send_file "$ROOT" "commands.sh" "Warnbot code"
         send_file "$ROOT" "count" "Stats"
         send_file "$ROOT" "warns.txt" "Warns"
       else
           send_markdown_message "${CHAT[ID]}" "*No eres admin*"
       fi
      ;;
			
			'/warns')
        if [ "$ADMIN" == "1" ]; then
		
		### Not finished###
		
          send_action "${CHAT[ID]}" "typing"
          
          while read linea
          do
             ID=$(echo $linea | cut -d "_" -f1)
             N=$(echo $linea | cut -d "_" -f2)
             US=$(curl ....)
             curl -s "https://api.pwrtelegram.xyz/botxxxxxxxxxxxxxxx/getChat" -d "chat_id=$ID"

             if [ -z "${US}" ]; then
	        	   US=$(echo "Sin alias" )
             fi
             
             echo "$US tiene $N avisos" >> warns.tmp
             
          done < warns.txt
          
          SEND=$(cat warns.tmp)
          send_markdown_message "${CHAT[ID]}" "$SEND"
          rm warns.tmp
          
        else
          send_markdown_message "${USER[ID]}" "*No eres admin*"
        fi
			;;
      
			'/id')		
			send_message "${CHAT[ID]}" "$REPLYID ."
			;;
			
			'/start')
				echo $USERNAMECHAT ${USER[ID]} >> stats.txt
				send_action "${USER[ID]}" "typing"
				send_markdown_message "${USER[ID]}" "*Bienvenido, pero no eres admin...*"

				;;
        
			'')
      
				;;
			*)
				
		esac
 
 
# Functions


  # ADMIN COMMANDS # 
 
 if [ "$ADMIN" == "1" ]; then
 

  if [ -z "${REPLYUSERNAME}" ]; then
		user=$(echo ${REPLYFIRST_NAME} )
  else
    user=$(echo @${REPLYUSERNAME} )
  fi
  
  echo "$user" | grep "_"
  if [ $? == 0 ]; then
    user=$(echo ${REPLYFIRST_NAME} )
  fi




if [[ $MESSAGE =~ ^[\/!][Ww][Aa][Rr][nN] ]]; then
  
  MSG=$(echo $MESSAGE | cut -d " " -f2-)
  
  if [ "${#MESSAGE}" -gt "8" ]; then
    MSG=$(echo "*Razon:* $MSG")
  else
    
    MSG=""
  fi
  
  if [ -z "${REPLYID}" ]; then
    exit
  fi
  
  echo "$ADMINS" | grep "${REPLYID}"
  if [ $? == 0 ]; then
    exit
  fi
  
  cat warns.txt | grep "${REPLYID}"
  if [ $? == 0 ]; then
    A0=$(cat warns.txt | grep ${REPLYID} | head -1 | cut -d '_' -f2)
    grep -v ${REPLYID} warns.txt > warns.bak
    mv warns.bak warns.txt
    AD=$(echo "$A0 + 1" | bc)
    if [ "$AD" == "4" ]; then
      AD=3
    fi
    echo "${REPLYID}_${AD}" >> warns.txt
    
  else
  
    echo "${REPLYID}_1" >> warns.txt
    AD=1
  fi
  
  
  if [ "$AD" == "3" ]; then
    kick_chat_member "${CHAT[ID]}" "${REPLYID}"
    send_markdown_message "${CHAT[ID]}" "El usuario $user *ha sido baneado por pasar de las 3 advertencias*.
$MSG"
  else
  
  send_markdown_message "${CHAT[ID]}" "El usuario $user *ha sido avisado*.
$MSG
_Advertencias totales:_ * $AD * 
_Advertencias para ban:_  *3*"
  fi
  
  


elif [[ $MESSAGE =~ ^\/[Cc][Ll][Ee][Aa][Rr] ]]; then
  grep -v ${REPLY[ID]} warns.txt > warns.bak
  mv warns.bak warns.txt
  send_markdown_message "${CHAT[ID]}" "El usuario $user *ya no tiene avisos*."
  
elif [[ $MESSAGE =~ ^\/[Bb][Aa][nN]+$ ]]; then
  kick_chat_member "${CHAT[ID]}" "${REPLYID}"
  send_markdown_message "${CHAT[ID]}" "El usuario $user *ha sido baneado*."
  
  
elif [[ $MESSAGE =~ ^\/[Ii][nN][fF][Oo]+$ ]]; then

  cat warns.txt | grep "${REPLYID}"
  if [ $? == 0 ]; then
    A0=$(cat warns.txt | grep ${REPLYID} | head -1 | cut -d '_' -f2)
  else
    A0='0'
  fi
  
  send_markdown_message "${CHAT[ID]}" "El usuario $user *tiene $A0 avisos*."
  
  

fi


fi


fi
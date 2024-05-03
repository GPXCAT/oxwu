#!/bin/bash
timestamp=$(date +%s.%N)
VNC=:0 gnome-screenshot -w -f /tmp/OX_${timestamp}.png
MSG_PREFIX='地牛Wake Up!速報，'
MSG='預估震度['${1}']，['${2}']秒後抵達['${OXWU_TOWN_NAME}'] OX_'${timestamp}'.png'
curl -X POST https://notify-api.line.me/api/notify \
    -H 'Authorization: Bearer '${OXWU_NOTIFY_TOKEN} \
    -F "message=${MSG_PREFIX}${MSG}" \
    -F 'imageFile=@/tmp/OX_'${timestamp}'.png' &
echo "傳送 ${MSG_PREFIX}${MSG}"
for s in `seq ${2} -1 0`; do
    MSG=''
    case "$s" in
        $2)
            ;;
        ?0)
            MSG='預估震度['${1}']，['${s}']秒後抵達['${OXWU_TOWN_NAME}']'
            ;;
        0)
            MSG='預估震度['${1}']，🚧抵達🚧['${OXWU_TOWN_NAME}']'
            ;;
        ?)
            MSG='預估震度['${1}']，['${s}']秒後抵達['${OXWU_TOWN_NAME}']'
            ;;
    esac

    if [ ! -z "$MSG" ]
    then
        curl -X POST https://notify-api.line.me/api/notify \
            -H 'Authorization: Bearer '${OXWU_NOTIFY_TOKEN} \
            -F "message=${MSG_PREFIX}${MSG}" &
        echo "\n傳送 ${MSG_PREFIX}${MSG}"
    fi
    sleep 1;
done
rm -f /tmp/OX_${timestamp}.png

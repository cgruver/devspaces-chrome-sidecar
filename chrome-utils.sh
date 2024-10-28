#!/usr/bin/env bash

function genVncPasswd() {
  array=()
  for i in {a..z} {A..Z} {0..9}; 
    do
    array[$RANDOM]=$i
  done
  printf %s ${array[@]::10} $'\n'
}

function startChrome() {
  
  if [ ! -d ${HOME}/.config/google-chrome ]
  then
    mkdir -p ${HOME}/.config/google-chrome
    touch ${HOME}/.config/google-chrome/'First Run'
  fi
  VNC_PASSWD=$(genVncPasswd)
  echo ${VNC_PASSWD} | vncpasswd -f > /tmp/vncpasswd
  echo ${VNC_PASSWD} > /tmp/vncsec
  /usr/bin/Xvnc :0 -nolisten tcp -UseIPv4 -interface lo -localhost -SecurityTypes VncAuth -PasswordFile=/tmp/vncpasswd -rfbport 5900 -desktop chrome -nevershared -noclipboard -noreset -DisconnectClients -geometry 1280x1024 -depth 24 -verbose > /tmp/xvnc.out 2>&1 &

  /usr/bin/google-chrome --display=:0 --disable-gpu --disable-software-rasterizer --disable-dev-shm-usage --disable-plugins --disable-plugins-discovery --disable-notifications --disable-sync --mute-audio --dns-prefetch-disable --noremote --window-size=1280,1024 > /tmp/chrome.out 2>&1 &

  /usr/bin/novnc_server --listen 6080 --web /usr/share/novnc --vnc localhost:5900 > /tmp/novnc.out 2>&1 &

  echo "Use this password to access the Chrome Browser:"
  echo ""
  echo $(cat /tmp/vncsec)
  echo ""

  tail -f /dev/null
}

function getChromeUrl() {
  VNC_HOST=$(/${PROJECTS_ROOT}/bin/oc get route ${DEVWORKSPACE_ID}-${DEVWORKSPACE_COMPONENT_NAME}-6080-tiger-vnc -o jsonpath={.spec.host}) ; echo "https://${VNC_HOST}/vnc.html?host=${VNC_HOST}&port=443"
}

function getVncPasswd() {
  echo "Use this password to access the Chrome Browser:"
  echo ""
  echo $(cat /tmp/vncsec)
  echo ""
}

for i in "$@"
do
  case $i in
    --start)
      startChrome
    ;;
    --url)
      getChromeUrl
    ;;
    --passwd)
      getVncPasswd
    ;;
  esac
done

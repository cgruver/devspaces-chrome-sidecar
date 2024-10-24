# devspaces-chrome-sidecar

To Run Chrome:

1. Open a Terminal in the `chrome` container

1. Start the VNC Server:

   ```bash
   nohup /usr/bin/Xvnc :0 -nolisten tcp -UseIPv4 -interface lo -localhost -SecurityTypes None -rfbport 5900 -desktop chrome -nevershared -noclipboard -noreset -DisconnectClients -geometry 1280x1024 -depth 24 -verbose  > /tmp/xvnclog.out 2>&1 &
   ```

1. Start Chrome:

   ```bash
   nohup /usr/bin/google-chrome --display=:0 --disable-gpu --disable-software-rasterizer --disable-dev-shm-usage --disable-plugins --disable-plugins-discovery --disable-notifications --disable-sync --mute-audio --dns-prefetch-disable --noremote --window-size=1280,1024 > /tmp/googlelog.out 2>&1 &
   ```

1. Start the NoVNC Proxy:

   ```bash
   nohup /usr/bin/novnc_server --listen 3000 --web /usr/share/novnc --vnc localhost:5900 > /tmp/novnclog.out 2>&1 &
   ```

1. Open a Terminal in the `dev-tools` container:

   Get the URL for the NoVNC Proxy:

   ```bash
   VNC_HOST=$(oc get route ${DEVWORKSPACE_ID}-chrome-3000-tiger-vnc -o jsonpath={.spec.host})
   echo "https://${VNC_HOST}/vnc.html?host=${VNC_HOST}&port=443"
   ```

1. Point your Browser at the above URL

# Google Chrome Browser in a Dev Spaces Workspace

This project is a demo of how to run a Chrome browser from within a Dev Spaces workspace.

Chrome runs in a sidecar container which has been configured with an X11 server.

The X11 display is provided by TigerVNC.

External access to Chrome is provided by the NoVNC proxy server.

The artifacts to build the Chrome sidecar image are located in the `devspaces-chrome-sidecar` folder.

How to run the demo:

1. Start an Angular web app:

   ```bash
   cd test-app
   ng server
   ```

1. Start the Chrome Browser:

   ```bash
   Execute the VS Code Task: "Start Chrome"
   ```

1. Get the password for the VNC Server:

   __Note:__ The password is randomly generated each time the VNC server is started.

   ```bash
   Execute the VS Code Task: "Get VNC Password"
   ```

1. Open the `google-chrome` endpoint (Port 6080/https)

   Click on the `Connect` button and enter the password when prompted.

1. In Chrome, navigate to `http://localhost:4200`


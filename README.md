# Google Chrome Browser in a Dev Spaces Workspace

This project is a demo of how to run a Chrome browser from within a Dev Spaces workspace.

Chrome runs in a sidecar container which has been configured with an X11 server.

The X11 display is provided by TigerVNC.

External access to Chrome is provided by the NoVNC proxy server.

The artifacts to build the Chrome sidecar image are located in the `devspaces-chrome-sidecar-ubi9` which requires a Red Hat subscription, or the `devspaces-chrome-sidecar-fedora` folder.

__Note:__ By default, this workspace will use the Fedora based image since it is freely re-distributable.

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

1. Copy the password for the VNC Server:

1. Open the `google-chrome` endpoint (Port 6080/https)

   Click on the `Connect` button and enter the password when prompted.

1. In Chrome, navigate to `http://localhost:4200`


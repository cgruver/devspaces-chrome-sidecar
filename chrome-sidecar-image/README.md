# How to build the sidecar image

This image requires Red Hat Subscription Entitlements to build properly

1. Exctract the entitlement files from your OpenShift CLuster:

   __Note:__ You will need `cluster-admin` privileges, or be granted access to the `etc-pki-entitlement` Secret by a `cluster-admin` for this first step.

   ```bash
   oc extract secret/etc-pki-entitlement -n openshift-config-managed --to=entitlement --confirm
   ```

   __Note:__ If you don't have `cluster-admin` rights, have an admin extract the files for you and place them in an `entitlement` folder here.

1. Build the image

   ```bash
   podman build -t chrome-sidecar:latest -f Containerfile -v ${PWD}/entitlement:/etc/pki/entitlement:Z .
   ```

1. Create a repo in the local OpenShift Registry for the new image:

   ```bash
   oc new-project devspaces-images
   oc policy add-role-to-group system:image-puller system:serviceaccounts -n devspaces-images
   ```

1. Tag and push the new image to the internal registry:

   ```bash
   podman tag chrome-sidecar:latest image-registry.openshift-image-registry.svc:5000/devspaces-images/chrome-sidecar:latest
   podman push image-registry.openshift-image-registry.svc:5000/devspaces-images/chrome-sidecar:latest
   ```


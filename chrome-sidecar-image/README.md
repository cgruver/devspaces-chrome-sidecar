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

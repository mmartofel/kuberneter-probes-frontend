
oc delete all --selector app=angular-frontend
oc delete bc/angular-frontend
oc delete is/angular-frontend

sleep 10

oc delete cm angular-frontend-configmap
oc create cm angular-frontend-configmap --from-file=./deployment/environment.ts

oc new-build --name angular-frontend --binary --strategy docker
oc start-build angular-frontend --from-dir=.

sleep 60

oc new-app angular-frontend

# oc set volume deployment/angular-frontend --type configmap --configmap-name=angular-frontend-configmap --mount-path=/opt/app-root/src/src/environments --add

oc expose service/angular-frontend

oc label deployment/angular-frontend app.kubernetes.io/part-of=ANGULAR_DEMO_APP --overwrite
oc label deployment/angular-frontend app.openshift.io/runtime=angularjs --overwrite

echo
echo "Try now to hit your angular frontend at:"
echo
echo "   http://"`oc get route angular-frontend -o template --template='{{ .spec.host }}'`
echo


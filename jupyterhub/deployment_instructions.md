## check live config
```
kubectl get secret -n jupyterhub hub-secret -o json | jq -r '.data."values.yaml"'| base64 -d | less
```

## get copy of values
```
kubectl get secret -n jupyterhub hub-secret -o json | jq -r '.data."values.yaml"'| base64 -d > /tmp/hub-secret.values.yaml
cp /tmp/hub-secret.values{,v2}.yaml
```

## edit values in /tmp/hub-secret.valuesv2.yaml

## after your edits are done
```
cat /tmp/hub-secret.valuesv2.yaml | base64 -w 0 > /tmp/hub-secret.valuesv2BASE64
```

## get live encoded manifest
```
kubectl get secret -n jupyterhub hub-secret -o yaml > /tmp/hub-secret.yaml
cp /tmp/hub-secret{,v2}.yaml
```

## prepare new encoded manifest
copy content of `/tmp/hub-secret.valuesv2BASE64` and replace it with `"values.yaml"` part in `/tmp/hub-secretv2.yaml` file

## check files
```
diff /tmp/hub-secret{,v2}.yaml | less -S
```

## you should see only one line changes
expected output:
```
4c4
<   values.yaml: Q2hhcnQ6CiAgTmFtZToganVweXRlcmh1YgogIFZlcnN....
---
>   values.yaml: Q2hhcnQ6CiAgTmFtZToganVweXRlcmh1YgogIFZlcnN....
```

## !! this part will affect live infrastructure
```
kubectl apply -f /tmp/hub-secretv2.yaml
```

## check live values
```
kubectl get secret -n jupyterhub hub-secret -o json | jq -r '.data."values.yaml"'| base64 -d | grep -A5 image
```
## refresh pods if needed
```
kubectl delete pod -n jupyterhub -l app=jupyterhub
```
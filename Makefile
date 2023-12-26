NS=zk
RELEASE=zk
CHARTPATH=./helm/zookeeper/
IMAGE=localhost:5000/lapsatech/kubernetes-zookeeper-3_9:latest

default: build

build:
	docker build ./docker \
	   --pull \
	   --progress=plain \
	   --tag ${IMAGE}
#    --no-cache \

push: build
	docker push ${IMAGE}

install-light: push
	helm upgrade ${RELEASE} ${CHARTPATH} \
	     --namespace ${NS} \
	     --create-namespace \
	     --install \
	     --debug \
	     --reset-values \
	     --force \
	     --set deployment.pvc.enabled=false

install: push
	helm upgrade ${RELEASE} ${CHARTPATH} \
	     --namespace ${NS} \
	     --create-namespace \
	     --install \
	     --debug \
	     --reset-values \
	     --force

delete-chart:
	helm delete ${RELEASE} \
	     --namespace ${NS}

drop-namespace:
	kubectl delete namespace ${NS}

drop-pod:
	kubectl get pod --namespace ${NS} -o name | xargs -I{} kubectl delete --grace-period=0 --namespace ${NS} {}

drop-pvc:
	kubectl get pvc --namespace ${NS} -o name | xargs -I{} kubectl delete --grace-period=0 --namespace ${NS} {}

uninstall: delete-chart

cleanup: drop-pod drop-namespace

initial:
	aws eks --region ${REGION_AWS} update-kubeconfig --name ${NAME_PROJECT_AWS}

.PHONY: initial
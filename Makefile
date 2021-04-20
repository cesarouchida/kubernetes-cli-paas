initial-aws:
	aws eks --region ${REGION_AWS} update-kubeconfig --name ${NAME_PROJECT_AWS}

initial-digital-ocean:
	doctl auth init --context ${CTX_DIGITAL_OCEAN}

.PHONY: initial-aws
terraform-plan:
	rm -rf terraform/.terraform
	cd terraform && \
		terraform init && \
		terraform validate && \
		terraform plan \
			-out terraform.plan

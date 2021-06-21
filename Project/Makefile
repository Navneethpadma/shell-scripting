help:           ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

catalogue:	common ## Install catalogue component for Roboshop project
	@sh components/catalogue.sh

common: ## Install common component for Roboshop project
	@sh components/common.sh

cart:	common  ##Install cart component for Roboshop project
	@sh components/cart.sh

frontend:	common     ##Install frontend component for Roboshop project
	@sh components/frontend.sh

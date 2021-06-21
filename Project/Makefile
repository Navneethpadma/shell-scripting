help:           ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

catalogue: ## Install catalogue component for Roboshop project
	@sh components/catalogue.sh

cart:      ##Install cart component for Roboshop project
	@sh components/cart.sh

frontend:      ##Install frontend component for Roboshop project
	@sh components/frontend.sh

help:           ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

catalogue:	common ## Install catalogue component for Roboshop project
	@sh components/catalogue.sh

common: ## Install common component for Roboshop project
	@sh -x components/common.sh

cart:	common  ##Install cart component for Roboshop project
	@sh components/cart.sh

frontend:	common     ##Install frontend component for Roboshop project
	@sh components/frontend.sh

mongodb: 	common     ##Install Mongodb component for Roboshop project
	@sh components/mongodb.sh

redis: 	common     ##Install redis component for Roboshop project
	@sh components/redis.sh

user:	common  ##Install user component for Roboshop project
	@sh components/user.sh

mysql:	common  ##Install mysql component for Roboshop project
	@sh components/mysql.sh

shipping:	common  ##Install shipping component for Roboshop project
	@sh components/shipping.sh

rabbitmq:	common  ##Install rabbitmq component for Roboshop project
	@sh components/rabbitmq.sh

payment:	common  ##Install payment component for Roboshop project
	@sh components/payment.sh
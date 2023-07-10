#!/bin/bash
tar zxvf /home/admin/app/package.tgz -C /home/admin/app/
echo "env NODE_INDEX=$NODE_INDEX"
#if [ "$NODE_INDEX" = "1" ]; then
	cp /home/admin/app/gigi-auth/target/*.jar /home/admin/app/
	cp /home/admin/app/gigi-gateway/target/*.jar /home/admin/app/
	cp /home/admin/app/gigi-modules/gigi-system/target/*.jar /home/admin/app/
	cp /home/admin/app/gigi-modules/gigi-customer/target/*.jar /home/admin/app/
	cp /home/admin/app/gigi-modules/gigi-order/target/*.jar /home/admin/app/
	cp /home/admin/app/gigi-modules/gigi-payment/target/*.jar /home/admin/app/

	echo "start node servier 1 NODE_INDEX=$NODE_INDEX"
	bash /home/admin/app/deploy.sh restart gigi-auth
	bash /home/admin/app/deploy.sh restart gigi-gateway
	bash /home/admin/app/deploy.sh restart gigi-modules-system
	bash /home/admin/app/deploy.sh restart gigi-modules-customer
	bash /home/admin/app/deploy.sh restart gigi-modules-order
	bash /home/admin/app/deploy.sh restart gigi-modules-payment
#else
	cp /home/admin/app/gigi-modules/gigi-product/target/*.jar /home/admin/app/
	cp /home/admin/app/gigi-modules/gigi-chat/target/*.jar /home/admin/app/
	cp /home/admin/app/gigi-modules/gigi-moments/target/*.jar /home/admin/app/
	cp /home/admin/app/gigi-modules/gigi-job/target/*.jar /home/admin/app/
	cp /home/admin/app/gigi-modules/gigi-gen/target/*.jar /home/admin/app/
	cp /home/admin/app/gigi-modules/gigi-file/target/*.jar /home/admin/app/
	cp /home/admin/app/gigi-modules/gigi-course/target/*.jar /home/admin/app/
	cp /home/admin/app/gigi-modules/gigi-medical-record/target/*.jar /home/admin/app/
	cp /home/admin/app/gigi-modules/gigi-blog/target/*.jar /home/admin/app/

	echo "start node servier else NODE_INDEX=$NODE_INDEX"
	bash /home/admin/app/deploy.sh restart gigi-modules-product
        bash /home/admin/app/deploy.sh restart gigi-modules-chat
	bash /home/admin/app/deploy.sh restart gigi-modules-moments
	bash /home/admin/app/deploy.sh restart gigi-modules-job
	bash /home/admin/app/deploy.sh restart gigi-modules-gen
	bash /home/admin/app/deploy.sh restart gigi-modules-file
	bash /home/admin/app/deploy.sh restart gigi-modules-course
	bash /home/admin/app/deploy.sh restart gigi-modules-medical-record
	bash /home/admin/app/deploy.sh restart gigi-modules-blog
#fi

#!/bin/sh
ssh core@nuc1.home mkdir -p homepage/config homepage/public/icons homepage/public/images
scp config/custom.css config/settings.yaml config/services.yaml config/widgets.yaml config/bookmarks.yaml \
	core@nuc1.home:homepage/config
scp public/icons/* core@nuc1.home:homepage/public/icons
scp public/images/* core@nuc1.home:homepage/public/images
docker -H nuc1.home:2375 compose up -d

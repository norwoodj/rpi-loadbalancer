VERSION_PLACEHOLDER := _VERSION

.PHONY: help
help:
	@echo "Available Targets:"
	@echo
	@echo "  clean           - Clean up build artifacts"
	@echo "  deb             - Build debian packages for deploying rpi-loadbalancer"


##
# Versioning targets
##
version.txt:
	date --utc "+%y.%m%d.0" > version.txt

update-deb-version: version.txt
	sed -i "s|$(VERSION_PLACEHOLDER)|$(shell cat version.txt)|g" debian/changelog
	touch update-deb-version


##
# debian packaging
##
.PHONY: deb
deb: update-deb-version
	debuild

##
# Cleanup
##
.PHONY: debclean
debclean: version.txt
	sed -i "s|$(shell cat version.txt)|$(VERSION_PLACEHOLDER)|g" debian/changelog
	rm -rf version.txt update-deb-version

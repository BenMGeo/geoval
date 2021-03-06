#######################################
# This file is part of GEOVAL
#######################################

# XXX: machine specific paths
# pep8, ignoring some errors like e.g. indention errors or linelength error
PEP = pep8 --ignore=E501
TDIR = ./tmp
VERSION = 0.1-dev
#TESTDIRS = pycmbs/benchmarking/tests pycmbs/tests
TESTDIRS = geoval/tests


clean :
	find . -name "*.pyc" -exec rm -rf {} \;
	find . -name "y.pkl" -exec rm -rf {} \;
	find . -name "*.so" -exec rm -rf {} \;
	find . -name "polygon_utils.c" -exec rm -rf {} \;
	find . -name "data_warnings.log" -exec rm -rf {} \;
	rm -rf C:*debuglog.txt
	rm -rf build
	rm -rf MANIFEST
	rm -rf cover
	rm -rf tmp
	rm -rf doc
	rm -rf dist
	rm -rf geoval.egg-info


coverage: dependencies
	#nosetests --with-coverage --cover-package=benchmarking --cover-package=pycmbs $(TESTDIRS) --cover-html
	nosetests --with-coverage --cover-package=geoval $(TESTDIRS) --cover-html

tests: dependencies
	nosetests $(TESTDIRS)

dist : clean
	python setup.py sdist

build_docs:
	python setup.py build_sphinx

update_version:
	python autoincrement_version.py

upload_docs:
	python setup.py upload_sphinx

dependencies : clean
	sh compile_extensions.sh

upload_pip: update_version
	# ensure that pip version has always counterpart on github
	git push origin master
	# note that this requres .pypirc file beeing in home directory
	python setup.py sdist upload





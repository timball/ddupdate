
GIT_COMMIT      = $(shell git log -1 --pretty=format:%h || echo UNKNOWN)
GIT_DATE        = $(shell git log -1 --pretty=format:%cd || echo UNKNOWN)
GIT_REFS        = $(shell git log -1 --pretty=format:%d || echo UNKNOWN)
GIT_DATE_ISO    = $(shell git log -1 --pretty=format:%ci || date +"%F %T")

pylint_template  = {path}:{line}: [{msg_id}({symbol}), {obj}] {msg}

pylint: .phony
	-PYTHONPATH=$(CURDIR)/lib \
	python3-pylint --rcfile=pylint.conf \
	--msg-template='$(pylint_template)' plugins \
	    lib/ddupdate/main.py lib/ddupdate/plugins_base.py  setup.py

pep8: plugins ddupdate lib/ddupdate/main.py lib/ddupdate/plugins_base.py setup.py
	-python3-pep8 --config=pep8.conf $?

ddupdate.8.html: ddupdate.8
	man2html $? > $@

README.rst: README.md
	cp $? $@

dist: README.rst
	python3 setup.py sdist

clean: .phony
	rm -rf install dist build *.egg-info lib/*.egg-info

.phony:

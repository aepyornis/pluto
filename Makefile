venv:
	python3 -m venv venv
	venv/bin/pip3 install pyproj

.PHONY: clean
clean:
	rm -rf venv/

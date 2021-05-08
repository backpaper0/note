.PHONY: regenerate_sidebar
regenerate_sidebar:
	cd docs; \
	rm _sidebar.md; \
	docsify g .

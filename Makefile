entries_in := index.markdown $(wildcard */*.markdown)
entries_out := $(subst .markdown,.html,$(entries_in))

entries: $(entries_out)

%.html: %.markdown
	mmd $<
	#xsltproc --verbose --output $@ elmonline.xsl $@
	xsltproc --output $@ elmonline.xsl $@

.PHONY: debug
debug:
	echo inputs: $(entries_in)
	echo outputs: $(entries_out)

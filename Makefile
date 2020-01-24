.PHONY: clean spell

TEX = xelatex
pc := %
extras := $$(patsubst $$(pc).tex, $$(pc).spell, $$(wildcard $$*/**/*.tex))
vpath %.tex resume coverletter references


default: img/coverletter.png img/resume.png out/references.pdf


.SECONDEXPANSION:
out/%.pdf: %.tex $(extras)
	@echo $(TEX) -interaction nonstopmode -output-directory=$(@D) $<


img/%.png: out/%.pdf
	convert -density 300 $< $@


.PHONY:
%.spell: %.tex
	aspell --lang=en -c -t $<


clean:
	rm -rf img/*
	rm -rf out/*
	rm -rf **/*.log **/*.aux **/*.out

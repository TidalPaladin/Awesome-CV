.PHONY: clean spell

TEX = xelatex
pc := %
extras := $$(patsubst $$(pc).tex, $$(pc).spell, $$(wildcard $$*/**/*.tex))
vpath %.tex resume coverletter references


default: coverletter resume references

resume: out/resume.pdf img/resume.png 
coverletter: out/coverletter.pdf img/coverletter.png 
references: out/references.pdf img/references.png 


.SECONDEXPANSION:
out/%.pdf: %.tex $(extras)
	$(TEX) -interaction nonstopmode -output-directory=$(@D) $<


img/%.png: out/%.pdf
	convert -density 300 $< $@


.PHONY:
%.spell: %.tex
	aspell --lang=en -c -t $<


clean:
	rm -rf img/*
	rm -rf out/*
	rm -rf **/*.log **/*.aux **/*.out

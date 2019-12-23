.PHONY: default spell clean %.spell

CC = xelatex
RESUME_DIR = resume
COVERLETTER_DIR = coverletter
COVERLETTER_G_DIR = coverletter-generic
EXTRAS_DIR = extra
IMG_DIR = img

RESUME_SRCS = $(shell find $(RESUME_DIR)/$(EXTRAS_DIR) -name '*.tex')
COVERLETTER_SRCS = $(shell find $(COVERLETTER_DIR)/$(EXTRAS_DIR) -name '*.tex')
COVERLETTER_G_SRCS = $(shell find $(COVERLETTER_G_DIR)/$(EXTRAS_DIR) -name '*.tex')

default: $(foreach x, coverletter coverletter-generic resume, $x.png)

coverletter.pdf: $(COVERLETTER_DIR)/coverletter.spell $(COVERLETTER_SRCS:.tex=.spell) awesome-cv.cls
	$(CC) -interaction nonstopmode -output-directory=$(COVERLETTER_DIR) $(<:.spell=.tex)
	mv $(COVERLETTER_DIR)/coverletter.pdf ./

coverletter-generic.pdf: $(COVERLETTER_G_DIR)/coverletter-generic.spell $(COVERLETTER_G_SRCS:.tex=.spell) awesome-cv.cls
	$(CC) -interaction nonstopmode -output-directory=$(COVERLETTER_G_DIR) $(<:.spell=.tex)
	mv $(COVERLETTER_G_DIR)/coverletter-generic.pdf ./

resume.pdf: $(RESUME_DIR)/resume.spell $(RESUME_SRCS:.tex=.spell) awesome-cv.cls
	$(CC) -interaction nonstopmode -output-directory=$(RESUME_DIR) $(<:.spell=.tex)
	mv $(RESUME_DIR)/resume.pdf ./

references.pdf: references/references.tex awesome-cv.cls
	$(CC) -interaction nonstopmode -output-directory=references $< 
	mv references/references.pdf ./

%.png: %.pdf
	convert -density 300 $< $(IMG_DIR)/$(basename $<).png

%.spell: %.tex
	aspell -t check $<

clean:
	rm -rf *.pdf *.log *.aux *.out
	cd $(RESUME_DIR) && rm -rf *.pdf *.log *.aux *.out
	cd $(COVERLETTER_DIR) && rm -rf *.pdf *.log *.aux *.out
	cd $(COVERLETTER_G_DIR) && rm -rf *.pdf *.log *.aux *.out
	rm -rf $(IMG_DIR)/*

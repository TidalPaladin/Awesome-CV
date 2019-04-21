.PHONY: default

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

coverletter.pdf: $(COVERLETTER_DIR)/coverletter.tex $(COVERLETTER_SRCS) awesome-cv.cls
	$(CC) -interaction nonstopmode -output-directory=$(COVERLETTER_DIR) $<
	mv $(COVERLETTER_DIR)/coverletter.pdf ./

coverletter-generic.pdf: $(COVERLETTER_G_DIR)/coverletter-generic.tex $(COVERLETTER_G_SRCS) awesome-cv.cls
	$(CC) -interaction nonstopmode -output-directory=$(COVERLETTER_G_DIR) $<
	mv $(COVERLETTER_G_DIR)/coverletter-generic.pdf ./

resume.pdf: $(RESUME_DIR)/resume.tex $(RESUME_SRCS) awesome-cv.cls
	$(CC) -interaction nonstopmode -output-directory=$(RESUME_DIR) $<
	mv $(RESUME_DIR)/resume.pdf ./

%.png: %.pdf
	convert -density 300 $< $(IMG_DIR)/$(basename $<).png

clean:
	rm -rf *.pdf *.log *.aux *.out
	cd $(RESUME_DIR) && rm -rf *.pdf *.log *.aux *.out
	cd $(COVERLETTER_DIR) && rm -rf *.pdf *.log *.aux *.out
	cd $(COVERLETTER_G_DIR) && rm -rf *.pdf *.log *.aux *.out
	rm -rf $(IMG_DIR)/*

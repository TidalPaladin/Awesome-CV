.PHONY: default
CC = xelatex

RESUME_DIR = resume
COVERLETTER_DIR = coverletter
EXTRAS_DIR = extra
RESUME_SRCS = $(shell find $(RESUME_DIR)/$(EXTRAS_DIR) -name '*.tex')
COVERLETTER_SRCS = $(shell find $(COVERLETTER_DIR)/$(EXTRAS_DIR) -name '*.tex')

default: $(foreach x, coverletter resume, $x.pdf)

resume.pdf: $(RESUME_DIR)/resume.tex $(RESUME_SRCS)
	$(CC) -interaction nonstopmode -output-directory=$(RESUME_DIR) $<

coverletter.pdf: $(COVERLETTER_DIR)/coverletter.tex
	$(CC) -output-directory=$(COVERLETTER_DIR) $<

clean:
	cd $(RESUME_DIR) && rm -rf *.pdf *.log *.aux *.out
	cd $(COVERLETTER_DIR) && rm -rf *.pdf *.log *.aux *.out

.PHONY: default spell clean %.spell

SRC_DIR = src
OUT_DIR = out
EXTRAS_DIR = extra
SOURCES = $(patsubst %/,%,$(shell cd $(SRC_DIR) && ls -d */))
TEX_DEPS = fontawesome.sty awesome-cv.cls $(SRC_DIR)/sig.pdf


IMG_DIR = img
IMG_RES = 300
IMG_FMT = png

IMAGES = $(patsubst %,$(IMG_DIR)/%.$(IMG_FMT),$(SOURCES))
PDFS = $(patsubst %,$(OUT_DIR)/%.pdf,$(SOURCES))

CC = xelatex
CCARGS = -interaction nonstopmode

coverletter.pdf: $(COVERLETTER_DIR)/coverletter.spell $(COVERLETTER_SRCS:.tex=.spell) awesome-cv.cls
	$(CC) -interaction nonstopmode -output-directory=$(COVERLETTER_DIR) $(<:.spell=.tex)
	mv $(COVERLETTER_DIR)/coverletter.pdf ./

coverletter-generic.pdf: $(COVERLETTER_G_DIR)/coverletter-generic.spell $(COVERLETTER_G_SRCS:.tex=.spell) awesome-cv.cls
	$(CC) -interaction nonstopmode -output-directory=$(COVERLETTER_G_DIR) $(<:.spell=.tex)
	mv $(COVERLETTER_G_DIR)/coverletter-generic.pdf ./

resume.pdf: $(RESUME_DIR)/resume.spell $(RESUME_SRCS:.tex=.spell) awesome-cv.cls
	$(CC) -interaction nonstopmode -output-directory=$(RESUME_DIR) $(<:.spell=.tex)
	mv $(RESUME_DIR)/resume.pdf ./

clean-tex:
	cd $(OUT_DIR) && rm -rf *.log *.aux *.out

%.spell: %.tex
	aspell -t check $<

clean:
	rm -rf $(IMG_DIR)/*
	cd $(OUT_DIR) && rm -rf *.pdf *.log *.aux *.out

spell:
	find $(SRC_DIR)/ -name '*.tex' -exec aspell check {} \;

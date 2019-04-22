.PHONY: default clean clean-tex spell

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

default: $(IMAGES) | $(PDFS)

$(OUT_DIR)/%.pdf: $(SRC_DIR)/%/main.tex #$(SRC_DIR)/%/$(EXTRAS_DIR)/ $(DEPS)
	cd $(<D) && $(CC) $(CCARGS) -jobname $(*F) $(<F)
	mv $(<D)/$(@F) $(OUT_DIR)/

$(IMG_DIR)/%.$(IMG_FMT): $(OUT_DIR)/%.pdf
	convert -density $(IMG_RES) $< $@

clean-tex:
	cd $(OUT_DIR) && rm -rf *.log *.aux *.out

clean:
	rm -rf $(IMG_DIR)/*
	cd $(OUT_DIR) && rm -rf *.pdf *.log *.aux *.out

spell:
	find $(SRC_DIR)/ -name '*.tex' -exec aspell check {} \;

.PHONY: default
CC = xelatex

SRC_DIR = resume
RESUME_DIR = resume/resume
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')

default: $(foreach x, coverletter resume, $x.pdf)

resume.pdf: $(SRC_DIR)/resume.tex $(RESUME_SRCS)
	$(CC) -interaction nonstopmode -output-directory=$(SRC_DIR) $<

coverletter.pdf: $(SRC_DIR)/coverletter.tex
	$(CC) -output-directory=$(SRC_DIR) $<

clean:
	rm -rf $(SRC_DIR)/*.pdf *.log *.aux *.out

git_push:
	ghr \
		-t ${GITHUB_TOKEN} \
		-u ${CIRCLE_PROJECT_USERNAME} \
		-r ${CIRCLE_PROJECT_REPONAME} \
		-c ${CIRCLE_SHA1} -delete \
		$(cat /root/projects/results/VERSION) /root/project/results/
